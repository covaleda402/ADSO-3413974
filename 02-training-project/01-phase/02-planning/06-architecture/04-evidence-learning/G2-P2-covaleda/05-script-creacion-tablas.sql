-- ============================================================================
-- SCRIPT DE CREACIÓN DE BASE DE DATOS RELACIONAL: NUVORA CORE
-- Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
-- Ubicación: Centro Comercial San Pedro Plaza (Neiva, Huila)
-- Ficha SENA: 3413974 | Programa: ADSO | Competencia: 220501095
-- RAP: 593101 (Criterio C7) | Autor: covaleda402
-- Motor Compatible: PostgreSQL 15+ / ANSI SQL (10 Tablas · 64 Columnas)
-- ============================================================================

-- Configuración de sesión y esquema (PostgreSQL 15+)
SET client_encoding = 'UTF8';
SET timezone = 'America/Bogota';

-- ----------------------------------------------------------------------------
-- 1. LIMPIEZA PREVENTIVA DE TABLAS (ORDEN INVERSO DE DEPENDENCIAS)
-- ----------------------------------------------------------------------------
DROP TABLE IF EXISTS bitacora_canje CASCADE;
DROP TABLE IF EXISTS cupon CASCADE;
DROP TABLE IF EXISTS franja_horaria CASCADE;
DROP TABLE IF EXISTS promocion_producto CASCADE;
DROP TABLE IF EXISTS promocion CASCADE;
DROP TABLE IF EXISTS producto CASCADE;
DROP TABLE IF EXISTS local_comercial CASCADE;
DROP TABLE IF EXISTS categoria_comercio CASCADE;
DROP TABLE IF EXISTS preferencia_visitante CASCADE;
DROP TABLE IF EXISTS usuario CASCADE;

-- ----------------------------------------------------------------------------
-- 2. TABLA 1: USUARIO (8 columnas)
-- Almacena credenciales, datos de perfil y rol RBAC de los usuarios
-- ----------------------------------------------------------------------------
CREATE TABLE usuario (
    id_usuario              BIGSERIAL PRIMARY KEY,
    nombre_completo         VARCHAR(150) NOT NULL,
    correo_electronico      VARCHAR(150) NOT NULL UNIQUE,
    telefono_contacto       VARCHAR(20) NOT NULL,
    tipo_rol                VARCHAR(20) NOT NULL,
    hash_password           VARCHAR(255) NOT NULL,
    fecha_registro          TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    estado_cuenta           VARCHAR(20) NOT NULL DEFAULT 'ACTIVA',

    -- Restricción CHECK 1: Validación de roles permitidos
    CONSTRAINT ck_usuario_rol CHECK (
        tipo_rol IN ('VISITANTE', 'LOCATARIO', 'ADMINISTRADOR')
    ),

    -- Restricción CHECK 2: Validación de estados operativos de cuenta
    CONSTRAINT ck_usuario_estado CHECK (
        estado_cuenta IN ('ACTIVA', 'SUSPENDIDA', 'BLOQUEADA')
    )
);

-- ----------------------------------------------------------------------------
-- 3. TABLA 2: PREFERENCIA_VISITANTE (2 columnas — Atributo Multivaluado 1FN)
-- Extrae preferencias_gastronomicas [*] hacia tabla atómica con PK compuesta
-- ----------------------------------------------------------------------------
CREATE TABLE preferencia_visitante (
    id_usuario              BIGINT NOT NULL,
    categoria_preferida     VARCHAR(50) NOT NULL,

    CONSTRAINT pk_preferencia_visitante PRIMARY KEY (id_usuario, categoria_preferida),

    -- Acción Referencial 1 (ON DELETE CASCADE): Si se suprime el usuario, caen sus preferencias
    CONSTRAINT fk_preferencia_usuario FOREIGN KEY (id_usuario)
        REFERENCES usuario (id_usuario) ON DELETE CASCADE ON UPDATE CASCADE,

    -- Restricción CHECK 3: Longitud mínima válida para etiqueta de categoría
    CONSTRAINT ck_preferencia_categoria CHECK (
        LENGTH(TRIM(categoria_preferida)) >= 3
    )
);

-- ----------------------------------------------------------------------------
-- 4. TABLA 3: CATEGORIA_COMERCIO (5 columnas — Normalizada 3FN)
-- Normalización 3FN de tipos de establecimientos gastronómicos
-- ----------------------------------------------------------------------------
CREATE TABLE categoria_comercio (
    id_categoria            SERIAL PRIMARY KEY,
    nombre_categoria        VARCHAR(50) NOT NULL UNIQUE,
    descripcion             TEXT,
    porcentaje_retencion_cc NUMERIC(5,2) NOT NULL,
    administrador_categoria VARCHAR(100) NOT NULL,

    -- Restricción CHECK 4: Rango válido de retención comercial
    CONSTRAINT ck_categoria_retencion CHECK (
        porcentaje_retencion_cc >= 0.00 AND porcentaje_retencion_cc <= 100.00
    )
);

-- ----------------------------------------------------------------------------
-- 5. TABLA 4: LOCAL_COMERCIAL (7 columnas)
-- Representa los comercios físicos de la plazoleta de comidas
-- ----------------------------------------------------------------------------
CREATE TABLE local_comercial (
    id_local                 SERIAL PRIMARY KEY,
    id_usuario_responsable   BIGINT NOT NULL,
    id_categoria             INT NOT NULL,
    numero_local             VARCHAR(10) NOT NULL UNIQUE,
    razon_social             VARCHAR(150) NOT NULL,
    horario_atencion_semanal VARCHAR(80) NOT NULL,
    estado_operativo         BOOLEAN NOT NULL DEFAULT TRUE,

    -- Acción Referencial 2 (ON DELETE RESTRICT): No eliminar usuario con local activo
    CONSTRAINT fk_local_usuario FOREIGN KEY (id_usuario_responsable)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Acción Referencial 3 (ON DELETE RESTRICT): No eliminar categoría con locales
    CONSTRAINT fk_local_categoria FOREIGN KEY (id_categoria)
        REFERENCES categoria_comercio (id_categoria) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- 6. TABLA 5: PRODUCTO (7 columnas)
-- Ítems del menú gastronómico por local comercial
-- ----------------------------------------------------------------------------
CREATE TABLE producto (
    id_producto             BIGSERIAL PRIMARY KEY,
    id_local                INT NOT NULL,
    nombre_item             VARCHAR(120) NOT NULL,
    descripcion_corta       VARCHAR(255),
    precio_base_cop         NUMERIC(12,2) NOT NULL,
    categoria_menu          VARCHAR(40) NOT NULL,
    disponible_en_carta     BOOLEAN NOT NULL DEFAULT TRUE,

    -- Acción Referencial 4 (ON DELETE RESTRICT): Proteger catálogo
    CONSTRAINT fk_producto_local FOREIGN KEY (id_local)
        REFERENCES local_comercial (id_local) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Restricción CHECK 5: Precios estrictamente positivos
    CONSTRAINT ck_producto_precio CHECK (
        precio_base_cop > 0.00
    ),

    -- Restricción CHECK 6: Categorías de carta válidas
    CONSTRAINT ck_producto_categoria CHECK (
        categoria_menu IN ('PLATO_FUERTE', 'COMBO', 'ENTRADA', 'BEBIDA', 'POSTRE')
    )
);

-- ----------------------------------------------------------------------------
-- 7. TABLA 6: PROMOCION (10 columnas)
-- Campañas y ofertas gastronómicas con inventario asignado
-- ----------------------------------------------------------------------------
CREATE TABLE promocion (
    id_promocion            BIGSERIAL PRIMARY KEY,
    id_local                INT NOT NULL,
    titulo_oferta           VARCHAR(150) NOT NULL,
    descripcion_terminos    TEXT NOT NULL,
    porcentaje_descuento    NUMERIC(5,2) NOT NULL,
    stock_total_asignado    INT NOT NULL,
    stock_disponible        INT NOT NULL,
    fecha_inicio            TIMESTAMPTZ NOT NULL,
    fecha_fin               TIMESTAMPTZ NOT NULL,
    estado_campana          VARCHAR(20) NOT NULL DEFAULT 'ACTIVA',

    -- Acción Referencial 5 (ON DELETE RESTRICT): Proteger historial de ofertas
    CONSTRAINT fk_promocion_local FOREIGN KEY (id_local)
        REFERENCES local_comercial (id_local) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Restricción CHECK 7: Porcentaje de descuento coherente
    CONSTRAINT ck_promocion_porcentaje CHECK (
        porcentaje_descuento > 0.00 AND porcentaje_descuento <= 90.00
    ),

    -- Restricción CHECK 8: Stock coherente y no negativo
    CONSTRAINT ck_promocion_stock CHECK (
        stock_total_asignado > 0 AND stock_disponible >= 0 AND stock_disponible <= stock_total_asignado
    ),

    -- Restricción CHECK 9: Coherencia temporal de vigencia
    CONSTRAINT ck_promocion_fechas CHECK (
        fecha_fin > fecha_inicio
    ),

    -- Restricción CHECK 10: Estados de ciclo de vida
    CONSTRAINT ck_promocion_estado CHECK (
        estado_campana IN ('ACTIVA', 'PAUSADA', 'AGOTADA', 'VENCIDA')
    )
);

-- ----------------------------------------------------------------------------
-- 8. TABLA 7: PROMOCION_PRODUCTO (2 columnas — Puente N:M Promoción - Producto)
-- Vincula las campañas promocionales con los platos elegibles de la carta
-- ----------------------------------------------------------------------------
CREATE TABLE promocion_producto (
    id_promocion            BIGINT NOT NULL,
    id_producto             BIGINT NOT NULL,

    CONSTRAINT pk_promocion_producto PRIMARY KEY (id_promocion, id_producto),

    -- Acción Referencial 6 (ON DELETE CASCADE): Si desaparece la campaña, se limpia su vínculo
    CONSTRAINT fk_pp_promocion FOREIGN KEY (id_promocion)
        REFERENCES promocion (id_promocion) ON DELETE CASCADE ON UPDATE CASCADE,

    -- Acción Referencial 7 (ON DELETE RESTRICT): Protege platos referenciados por ofertas
    CONSTRAINT fk_pp_producto FOREIGN KEY (id_producto)
        REFERENCES producto (id_producto) ON DELETE RESTRICT ON UPDATE CASCADE
);

-- ----------------------------------------------------------------------------
-- 9. TABLA 8: FRANJA_HORARIA (6 columnas — Entidad Débil por Identificación)
-- Ventanas horarias y días de aplicación de la promoción
-- ----------------------------------------------------------------------------
CREATE TABLE franja_horaria (
    id_promocion            BIGINT NOT NULL,
    dia_semana              SMALLINT NOT NULL,
    hora_inicio             TIME NOT NULL,
    hora_fin                TIME NOT NULL,
    aplica_festivos         BOOLEAN NOT NULL DEFAULT FALSE,
    cupo_maximo_franja      INT NOT NULL,

    -- Clave primaria compuesta de entidad débil
    CONSTRAINT pk_franja_horaria PRIMARY KEY (id_promocion, dia_semana, hora_inicio),

    -- Acción Referencial 8 (ON DELETE CASCADE): Si se borra la promoción, caen sus franjas
    CONSTRAINT fk_franja_promocion FOREIGN KEY (id_promocion)
        REFERENCES promocion (id_promocion) ON DELETE CASCADE ON UPDATE CASCADE,

    -- Restricción CHECK 11: Rango de días de semana (1 = Lunes, 7 = Domingo)
    CONSTRAINT ck_franja_dia CHECK (
        dia_semana BETWEEN 1 AND 7
    ),

    -- Restricción CHECK 12: Coherencia horaria
    CONSTRAINT ck_franja_horas CHECK (
        hora_fin > hora_inicio
    ),

    -- Restricción CHECK 13: Cupo de franja positivo
    CONSTRAINT ck_franja_cupo CHECK (
        cupo_maximo_franja > 0
    )
);

-- ----------------------------------------------------------------------------
-- 10. TABLA 9: CUPON (8 columnas — Entidad Asociativa N:M)
-- Instancia única emitida con token criptográfico QR efímero
-- ----------------------------------------------------------------------------
CREATE TABLE cupon (
    id_cupon                BIGSERIAL PRIMARY KEY,
    id_usuario_visitante    BIGINT NOT NULL,
    id_promocion            BIGINT NOT NULL,
    codigo_alfanumerico     VARCHAR(8) NOT NULL UNIQUE,
    token_dinamico_hash     VARCHAR(255) NOT NULL,
    estado_canje            VARCHAR(20) NOT NULL DEFAULT 'EMITIDO',
    fecha_hora_emision      TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_hora_expiracion   TIMESTAMPTZ NOT NULL,

    -- Acción Referencial 9 (ON DELETE RESTRICT): Proteger transacciones de visitantes
    CONSTRAINT fk_cupon_usuario FOREIGN KEY (id_usuario_visitante)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Acción Referencial 10 (ON DELETE RESTRICT): Proteger auditoría de la promoción
    CONSTRAINT fk_cupon_promocion FOREIGN KEY (id_promocion)
        REFERENCES promocion (id_promocion) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Restricción CHECK 14: Estados transaccionales de cupón
    CONSTRAINT ck_cupon_estado CHECK (
        estado_canje IN ('EMITIDO', 'CANJEADO', 'EXPIRADO', 'ANULADO')
    ),

    -- Restricción CHECK 15: Vigencia temporal estricta
    CONSTRAINT ck_cupon_vigencia CHECK (
        fecha_hora_expiracion > fecha_hora_emision
    )
);

-- ----------------------------------------------------------------------------
-- 11. TABLA 10: BITACORA_CANJE (9 columnas)
-- Asentamiento transaccional inmutable para auditoría y caja POS
-- ----------------------------------------------------------------------------
CREATE TABLE bitacora_canje (
    id_canje                 BIGSERIAL PRIMARY KEY,
    id_cupon                 BIGINT NOT NULL UNIQUE,
    id_usuario_cajero        BIGINT NOT NULL,
    id_local                 INT NOT NULL,
    fecha_hora_canje         TIMESTAMPTZ NOT NULL DEFAULT CURRENT_TIMESTAMP,
    monto_descuento_aplicado NUMERIC(12,2) NOT NULL,
    numero_factura_pos       VARCHAR(50) NOT NULL,
    ip_origen_terminal       VARCHAR(45) NOT NULL,
    firma_hash_transaccion   VARCHAR(255) NOT NULL,

    -- Acción Referencial 11 (ON DELETE RESTRICT): Inmutabilidad estricta 1:1
    CONSTRAINT fk_bitacora_cupon FOREIGN KEY (id_cupon)
        REFERENCES cupon (id_cupon) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Acción Referencial 12 (ON DELETE RESTRICT): Trazabilidad del cajero responsable
    CONSTRAINT fk_bitacora_cajero FOREIGN KEY (id_usuario_cajero)
        REFERENCES usuario (id_usuario) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Acción Referencial 13 (ON DELETE RESTRICT): Trazabilidad de la sede física
    CONSTRAINT fk_bitacora_local FOREIGN KEY (id_local)
        REFERENCES local_comercial (id_local) ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Restricción CHECK 16: Monto de descuento positivo
    CONSTRAINT ck_bitacora_monto CHECK (
        monto_descuento_aplicado > 0.00
    )
);

-- ----------------------------------------------------------------------------
-- 12. ÍNDICES DE RENDIMIENTO Y OPTIMIZACIÓN (RNF-01)
-- ----------------------------------------------------------------------------
CREATE INDEX idx_pref_categoria ON preferencia_visitante (categoria_preferida);
CREATE INDEX idx_promocion_local ON promocion (id_local);
CREATE INDEX idx_producto_local ON producto (id_local);
CREATE INDEX idx_pp_producto ON promocion_producto (id_producto);
CREATE INDEX idx_cupon_codigo ON cupon (codigo_alfanumerico);
CREATE INDEX idx_cupon_estado ON cupon (estado_canje);
CREATE INDEX idx_bitacora_fecha ON bitacora_canje (fecha_hora_canje);

-- ----------------------------------------------------------------------------
-- FIN DEL SCRIPT DDL NUVORA CORE (10 TABLAS · 64 COLUMNAS · 13 FK · 16 CHECK)
-- ----------------------------------------------------------------------------

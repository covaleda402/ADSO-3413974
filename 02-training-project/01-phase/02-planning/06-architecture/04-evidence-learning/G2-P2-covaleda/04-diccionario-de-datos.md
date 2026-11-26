# Diccionario de Datos del Modelo Relacional (B4)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** Jose Esneider Covaleda Hortua (`covaleda402`)  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C4)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Estándar de Nombrado y Convenciones Declaradas

Para asegurar la uniformidad técnica y la mantenibilidad del esquema de base de datos, se declaran los siguientes estándares de nomenclatura:
1. **Nombres de Tablas:** Sustantivos en minúsculas, en singular, separados por guión bajo (`snake_case`). Ejemplo: `usuario`, `local_comercial`, `promocion`.
2. **Nombres de Columnas:** En minúsculas y formato `snake_case`. Ejemplo: `nombre_completo`, `fecha_hora_emision`.
3. **Claves Primarias:** Formato `id_<nombre_tabla>` o el nombre del identificador principal. Ejemplo: `id_usuario`, `id_local`, `id_promocion`.
4. **Claves Foráneas:** Prefijo `id_` seguido de la entidad y rol referenciado. Ejemplo: `id_usuario_visitante`, `id_usuario_cajero`, `id_promocion`.
5. **Tipos de Datos y Dominios:** Tipados bajo estándar **ANSI SQL para motor PostgreSQL 15+**.

---

## 2. Diccionario Detallado por Tablas (100 % de Tablas y Columnas)

### Tabla 1: `usuario`
Almacena las credenciales de acceso, datos biográficos y rol de todos los actores que interactúan con el sistema Nuvora.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_usuario` | BIGSERIAL | 8 bytes | `PK, NOT NULL` | Identificador autoincremental único del usuario. |
| `nombre_completo` | VARCHAR | 150 | `NOT NULL` | Nombres y apellidos reales del usuario (solo caracteres alfabéticos y espacios). |
| `correo_electronico` | VARCHAR | 150 | `NOT NULL, UNIQUE` | Dirección de correo válida (formato RFC 5322); se usa para autenticación y notificaciones. |
| `telefono_contacto` | VARCHAR | 20 | `NOT NULL` | Número telefónico con código de país (ej. `+573101234567`). |
| `tipo_rol` | VARCHAR | 20 | `NOT NULL, CHECK (tipo_rol IN ('VISITANTE', 'LOCATARIO', 'ADMINISTRADOR'))` | Rol de seguridad para control de acceso (RBAC). |
| `hash_password` | VARCHAR | 255 | `NOT NULL` | Hash seguro generado con algoritmo **bcrypt (factor de costo $\ge 12$)** con sal única. |
| `fecha_registro` | TIMESTAMPTZ | 8 bytes | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | Marca temporal con zona horaria UTC del momento del registro. |
| `estado_cuenta` | VARCHAR | 20 | `NOT NULL, DEFAULT 'ACTIVA', CHECK (estado_cuenta IN ('ACTIVA', 'SUSPENDIDA', 'BLOQUEADA'))` | Estado operativo de la cuenta de usuario. |

---

### Tabla 2: `categoria_comercio`
Normaliza las categorías gastronómicas de los locales comerciales de la plazoleta y sus parámetros administrativos.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_categoria` | SERIAL | 4 bytes | `PK, NOT NULL` | Identificador autoincremental de la categoría comercial. |
| `nombre_categoria` | VARCHAR | 50 | `NOT NULL, UNIQUE` | Denominación culinaria (ej. 'Comida Rápida', 'Parrilla', 'Café y Heladería', 'Comida Típica'). |
| `descripcion` | TEXT | Variable | `NULL` | Descripción del concepto gastronómico de la categoría. |
| `porcentaje_retencion_cc` | NUMERIC | (5,2) | `NOT NULL, CHECK (porcentaje_retencion_cc >= 0 AND porcentaje_retencion_cc <= 100)` | Porcentaje de comisión administrativa del centro comercial sobre ventas con descuento. |
| `administrador_categoria` | VARCHAR | 100 | `NOT NULL` | Funcionario comercial responsable de auditar la categoría. |

---

### Tabla 3: `local_comercial`
Representa los establecimientos comerciales de la plazoleta de comidas del Centro Comercial San Pedro Plaza.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_local` | SERIAL | 4 bytes | `PK, NOT NULL` | Identificador autoincremental único del local comercial. |
| `id_usuario_responsable` | BIGINT | 8 bytes | `FK, NOT NULL, REFERENCES usuario(id_usuario) ON DELETE RESTRICT` | Locatario o administrador comercial a cargo del establecimiento. |
| `id_categoria` | INT | 4 bytes | `FK, NOT NULL, REFERENCES categoria_comercio(id_categoria) ON DELETE RESTRICT` | Categoría gastronómica normalizada a la que pertenece el local. |
| `numero_local` | VARCHAR | 10 | `NOT NULL, UNIQUE` | Número de local físico en la plazoleta (ej. `'L-301'`, `'L-302'`). |
| `razon_social` | VARCHAR | 150 | `NOT NULL` | Nombre comercial registrado ante la administración. |
| `horario_atencion_semanal` | VARCHAR | 80 | `NOT NULL` | Rango horario de operación comercial (ej. `'Lunes a Domingo 10:00 - 21:30'`). |
| `estado_operativo` | BOOLEAN | 1 byte | `NOT NULL, DEFAULT TRUE` | `TRUE` si el local está abierto y habilitado para emitir y canjear ofertas. |

---

### Tabla 4: `producto`
Catálogo de platos, combos y bebidas ofrecidos por cada comercio con sus precios base.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_producto` | BIGSERIAL | 8 bytes | `PK, NOT NULL` | Identificador único del ítem en la carta gastronómica. |
| `id_local` | INT | 4 bytes | `FK, NOT NULL, REFERENCES local_comercial(id_local) ON DELETE RESTRICT` | Establecimiento al que pertenece el producto. |
| `nombre_item` | VARCHAR | 120 | `NOT NULL` | Denominación del plato (ej. 'Hamburguesa Especial de la Casa'). |
| `descripcion_corta` | VARCHAR | 255 | `NULL` | Ingredientes y detalles para visualización en el catálogo móvil. |
| `precio_base_cop` | NUMERIC | (12,2) | `NOT NULL, CHECK (precio_base_cop > 0)` | Precio comercial ordinario en pesos colombianos (`COP`). |
| `categoria_menu` | VARCHAR | 40 | `NOT NULL, CHECK (categoria_menu IN ('PLATO_FUERTE', 'COMBO', 'ENTRADA', 'BEBIDA', 'POSTRE'))` | Clasificación para el motor de filtrado por presupuesto. |
| `disponible_en_carta` | BOOLEAN | 1 byte | `NOT NULL, DEFAULT TRUE` | Disponibilidad física para preparación inmediata en cocina. |

---

### Tabla 5: `promocion`
Campañas de descuento parametrizadas por los locatarios para dinamizar franjas horarias valle.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_promocion` | BIGSERIAL | 8 bytes | `PK, NOT NULL` | Identificador autoincremental de la campaña promocional. |
| `id_local` | INT | 4 bytes | `FK, NOT NULL, REFERENCES local_comercial(id_local) ON DELETE RESTRICT` | Establecimiento comercial que patrocina y asume el descuento. |
| `titulo_oferta` | VARCHAR | 150 | `NOT NULL` | Título atractivo visible en el catálogo (ej. 'Almuerzo Ejecutivo 25% OFF'). |
| `descripcion_terminos` | TEXT | Variable | `NOT NULL` | Términos y condiciones legales de redención y restricciones. |
| `porcentaje_descuento` | NUMERIC | (5,2) | `NOT NULL, CHECK (porcentaje_descuento > 0 AND porcentaje_descuento <= 90)` | Porcentaje de descuento aplicado sobre el precio base. |
| `stock_total_asignado` | INT | 4 bytes | `NOT NULL, CHECK (stock_total_asignado > 0)` | Cantidad máxima de cupones que la campaña puede emitir. |
| `stock_disponible` | INT | 4 bytes | `NOT NULL, CHECK (stock_disponible >= 0 AND stock_disponible <= stock_total_asignado)` | Cantidad remanente de cupones disponibles para emisión inmediata. |
| `fecha_inicio` | TIMESTAMPTZ | 8 bytes | `NOT NULL` | Fecha y hora de apertura de la campaña. |
| `fecha_fin` | TIMESTAMPTZ | 8 bytes | `NOT NULL, CHECK (fecha_fin > fecha_inicio)` | Fecha y hora de finalización de la campaña. |
| `estado_campana` | VARCHAR | 20 | `NOT NULL, DEFAULT 'ACTIVA', CHECK (estado_campana IN ('ACTIVA', 'PAUSADA', 'AGOTADA', 'VENCIDA'))` | Ciclo de vida operativo de la promoción. |

---

### Tabla 6: `franja_horaria` (Entidad Débil)
Modela las ventanas horarias específicas (horas valle) en las cuales una promoción es válida para su redención.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_promocion` | BIGINT | 8 bytes | `PK, FK, NOT NULL, REFERENCES promocion(id_promocion) ON DELETE CASCADE` | Promoción a la cual pertenece la restricción horaria (dependencia existencial). |
| `dia_semana` | SMALLINT | 2 bytes | `PK, NOT NULL, CHECK (dia_semana BETWEEN 1 AND 7)` | Día de la semana (1 = Lunes, 2 = Martes, ..., 7 = Domingo). |
| `hora_inicio` | TIME | 8 bytes | `PK, NOT NULL` | Hora de inicio de la franja promocional (ej. `14:00:00`). |
| `hora_fin` | TIME | 8 bytes | `NOT NULL, CHECK (hora_fin > hora_inicio)` | Hora de terminación de la franja promocional (ej. `17:30:00`). |
| `aplica_festivos` | BOOLEAN | 1 byte | `NOT NULL, DEFAULT FALSE` | Indica si la promoción es redimible durante días festivos colombianos. |
| `cupo_maximo_franja` | INT | 4 bytes | `NOT NULL, CHECK (cupo_maximo_franja > 0)` | Límite máximo de cupones que se pueden redimir dentro de esa franja horaria. |

---

### Tabla 7: `cupon` (Entidad Asociativa $N:M$)
Representa la instancia única de un cupón digital generado por un visitante para una promoción específica.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_cupon` | BIGSERIAL | 8 bytes | `PK, NOT NULL` | Identificador autoincremental único de la instancia de cupón. |
| `id_usuario_visitante` | BIGINT | 8 bytes | `FK, NOT NULL, REFERENCES usuario(id_usuario) ON DELETE RESTRICT` | Visitante que adquirió y porta el cupón en su billetera digital. |
| `id_promocion` | BIGINT | 8 bytes | `FK, NOT NULL, REFERENCES promocion(id_promocion) ON DELETE RESTRICT` | Oferta específica a la cual está vinculado el cupón. |
| `codigo_alfanumerico` | VARCHAR | 8 | `NOT NULL, UNIQUE` | Código legible de 8 caracteres alfanuméricos en mayúsculas (ej. `'NUV-8K42'`). |
| `token_dinamico_hash` | VARCHAR | 255 | `NOT NULL` | Firma criptográfica **HMAC-SHA256** incrustada en el código QR dinámico. |
| `estado_canje` | VARCHAR | 20 | `NOT NULL, DEFAULT 'EMITIDO', CHECK (estado_canje IN ('EMITIDO', 'CANJEADO', 'EXPIRADO', 'ANULADO'))` | Estado transaccional del cupón. |
| `fecha_hora_emision` | TIMESTAMPTZ | 8 bytes | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | Momento exacto de generación y despacho del cupón al cliente. |
| `fecha_hora_expiracion` | TIMESTAMPTZ | 8 bytes | `NOT NULL, CHECK (fecha_hora_expiracion > fecha_hora_emision)` | Límite estricto de vigencia (**exactamente 2 horas** posteriores a la emisión). |

---

### Tabla 8: `bitacora_canje`
Asienta de forma inmutable cada transacción de redención ejecutada en una terminal de caja POS para efectos de auditoría y facturación.

| Columna | Tipo de Dato | Tamaño | Restricciones | Dominio / Regla de Negocio |
|---|---|:---:|---|---|
| `id_canje` | BIGSERIAL | 8 bytes | `PK, NOT NULL` | Identificador único del evento transaccional de canje. |
| `id_cupon` | BIGINT | 8 bytes | `FK, NOT NULL, UNIQUE, REFERENCES cupon(id_cupon) ON DELETE RESTRICT` | Cupón consumido. La restricción `UNIQUE` impide físicamente el doble canje. |
| `id_usuario_cajero` | BIGINT | 8 bytes | `FK, NOT NULL, REFERENCES usuario(id_usuario) ON DELETE RESTRICT` | Empleado del local que operó la terminal POS y autorizó el descuento. |
| `id_local` | INT | 4 bytes | `FK, NOT NULL, REFERENCES local_comercial(id_local) ON DELETE RESTRICT` | Local donde se hizo efectiva la compra física. |
| `fecha_hora_canje` | TIMESTAMPTZ | 8 bytes | `NOT NULL, DEFAULT CURRENT_TIMESTAMP` | Sello de tiempo oficial del commit transaccional en base de datos. |
| `monto_descuento_aplicado` | NUMERIC | (12,2) | `NOT NULL, CHECK (monto_descuento_aplicado > 0)` | Valor monetario en pesos (`COP`) descontado efectivamente de la factura. |
| `numero_factura_pos` | VARCHAR | 50 | `NOT NULL` | Consecutivo de la tirilla de compra física emitida por la registradora del comercio. |
| `ip_origen_terminal` | VARCHAR | 45 | `NOT NULL` | Dirección IPv4 o IPv6 de la terminal o dispositivo que ejecutó la solicitud HTTP. |
| `firma_hash_transaccion` | VARCHAR | 255 | `NOT NULL` | Hash criptográfico inmutable que sella la transacción para auditoría legal. |

---

## 3. Matriz de Coincidencia 100 % entre Modelo, Diccionario y Script SQL

Se certifica que:
1. El 100 % de las 8 tablas declaradas en el modelo relacional existen en este diccionario y en el script `05-script-creacion-tablas.sql`.
2. Todos los nombres de columnas, tipos ANSI SQL, longitudes, restricciones de integridad referencial (`PK`, `FK`), unicidad (`UNIQUE`) y dominios (`CHECK`) coinciden de forma exacta sin discrepancias.

# Políticas de Seguridad de la Información y Matriz de Roles (B6)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** `covaleda402`  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C5)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Introducción y Marco Normativo de Seguridad

La plataforma **Nuvora** maneja información personal de visitantes del Centro Comercial San Pedro Plaza, catálogos comerciales de locatarios y transacciones financieras de descuento. Para salvaguardar estos activos, se formulan políticas técnicas concretas articuladas bajo la tríada **CID (Confidencialidad, Integridad y Disponibilidad)**, dando cumplimiento al estándar **ISO/IEC 27001** y al marco legal colombiano de protección de datos personales (**Ley Estatutaria 1581 de 2012**).

---

## 2. Políticas de Seguridad de la Información (Tríada CID)

Para cumplir con la exigencia de **al menos 2 políticas concretas por cada principio (mínimo 6 en total)**, se definen e implementan las siguientes directrices operativas sobre el esquema relacional de 10 tablas:

| Principio | ID Política | Nombre de la Política | Medida Técnica Concreta sobre el Caso Nuvora |
|:---:|:---:|---|---|
| **INTEGRIDAD** | **POL-INT-01** | **Bloqueo Pesimista y Prevención de Doble Canje** | En el momento en que un cajero valida un cupón en la terminal POS (`CU07`), el backend ejecuta una transacción ACID con aislamiento exclusivo a nivel de fila sobre `cupon` (`SELECT * FROM cupon WHERE id_cupon = $1 FOR UPDATE`), garantizando que ninguna solicitud concurrente en milisegundos pueda redimir el mismo cupón dos veces. |
| **INTEGRIDAD** | **POL-INT-02** | **Inmutabilidad y Sello Transaccional de Auditoría** | La tabla `bitacora_canje` tiene prohibidas las operaciones de `UPDATE` y `DELETE` para todos los roles operativos de aplicación. Cada registro calcula `firma_hash_transaccion` (SHA-256) combinando `{id_cupon, id_usuario_cajero, fecha_hora_canje, monto_descuento_aplicado}` para detectar cualquier alteración posterior. |
| **INTEGRIDAD** | **POL-INT-03** | **Control de Stock y Restricciones CHECK de Base de Datos** | El stock disponible en `promocion` se protege con `CHECK (stock_disponible >= 0 AND stock_disponible <= stock_total_asignado)` y la unicidad de cobro con `UNIQUE(id_cupon)` en `bitacora_canje`. Si el cupo llega a cero, el motor rechaza emisiones adicionales a nivel de base de datos. |
| **CONFIDENCIALIDAD** | **POL-CON-01** | **Dispersión Criptográfica de Contraseñas (Hash + Sal)** | Las credenciales almacenadas en `usuario.hash_password` **nunca se almacenan cifradas con algoritmo reversible**, sino dispersadas de forma irreversible mediante **bcrypt (factor de costo $\ge 12$)** con sal criptográfica única por usuario, mitigando ataques de diccionario y tablas *rainbow*. |
| **CONFIDENCIALIDAD** | **POL-CON-02** | **Cifrado de Datos en Tránsito (TLS 1.3) y en Reposo** | Todo el tráfico entre clientes web (PWA visitante, POS cajero, panel admin) y la API transita obligatoriamente sobre **HTTPS/WSS con TLS 1.3**, deshabilitando versiones heredadas (TLS 1.0/1.1). La columna `usuario.telefono_contacto` y los respaldos se almacenan cifrados en reposo (AES-256 / `pgcrypto`). |
| **CONFIDENCIALIDAD** | **POL-CON-03** | **Segregación de Vistas y Mascaramiento de Datos** | El rol `LOCATARIO` en terminal POS únicamente consulta `cupon.codigo_alfanumerico` y primer nombre; los campos `usuario.correo_electronico`, `usuario.telefono_contacto`, `usuario.hash_password` y las filas de `preferencia_visitante` quedan ocultos para cajas de comercios. |
| **DISPONIBILIDAD** | **POL-DIS-01** | **Respaldo Automatizado Diario y Copia Externa Cifrada** | Se ejecuta diariamente a las 03:00 a. m. (hora de mínima actividad) un volcado completo de la base de datos (`pg_dump -Fc`) cifrado con clave asimétrica y replicado en almacenamiento secundario externo con retención rotativa de 30 días calendario. |
| **DISPONIBILIDAD** | **POL-DIS-02** | **Protocolo de Prueba de Restauración Mensual con Acta** | El primer lunes de cada mes se ejecuta un simulacro de recuperación ante desastres sobre un entorno aislado de pruebas (*Staging*), restaurando la última copia y verificando integridad de las **10 tablas** mediante script automatizado, dejando acta técnica firmada por el administrador. |

---

## 3. Matriz de Control de Acceso Basado en Roles (RBAC)

Para garantizar el principio de mínimo privilegio (*Least Privilege*), la siguiente matriz define los permisos estrictos otorgados sobre la totalidad de las **diez (10) tablas** del esquema relacional para los **tres (3) roles del sistema**:

| Tabla Relacional | Rol: Visitante (`VISITANTE`) | Rol: Locatario / Cajero (`LOCATARIO`) | Rol: Administrador (`ADMINISTRADOR`) |
|---|:---:|:---:|:---:|
| `usuario` | `SELECT` (solo su propia fila)<br>`UPDATE` (solo su perfil/clave) | `SELECT` (solo su propia fila)<br>`UPDATE` (su perfil/clave) | `SELECT`, `INSERT`, `UPDATE` (gestión de cuentas) |
| `preferencia_visitante` | `SELECT`, `INSERT`, `DELETE` (solo sus propias preferencias) | Sin acceso directo | `SELECT` (analítica agregada anonimizada) |
| `categoria_comercio` | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` |
| `local_comercial` | `SELECT` (locales con `estado_operativo = TRUE`) | `SELECT` (su local)<br>`UPDATE` (horario de su local) | `SELECT`, `INSERT`, `UPDATE` |
| `producto` | `SELECT` (ítems con `disponible_en_carta = TRUE`) | `SELECT`, `INSERT`, `UPDATE` (solo carta de su local) | `SELECT`, `UPDATE` |
| `promocion` | `SELECT` (campañas en estado `ACTIVA`) | `SELECT`, `INSERT`, `UPDATE` (solo promociones de su local) | `SELECT`, `UPDATE` (auditoría/pausa) |
| `promocion_producto` | `SELECT` (productos asociados a ofertas activas) | `SELECT`, `INSERT`, `DELETE` (solo ofertas de su local) | `SELECT` |
| `franja_horaria` | `SELECT` | `SELECT`, `INSERT`, `UPDATE`, `DELETE` (franjas de su local) | `SELECT` |
| `cupon` | `SELECT` (sus cupones emitidos)<br>`INSERT` (emitir nuevo cupón) | `SELECT` (cupones de su local)<br>`UPDATE` (transición POS) | `SELECT` (todos los cupones) |
| `bitacora_canje` | Sin acceso directo | `INSERT` (generar asiento al canjear)<br>`SELECT` (solo ventas de su local) | `SELECT` (auditoría integral) |

* **Regla estricta de no borrado:** Ningún rol de aplicación posee permiso `DELETE` sobre `usuario`, `local_comercial`, `producto`, `promocion`, `cupon` ni `bitacora_canje`. La desactivación se maneja lógicamente mediante estados (`estado_cuenta`, `estado_operativo`, `estado_campana`).

---

## 4. Política de Tratamiento de Datos Personales (Ley 1581 de 2012)

1. **Finalidad Informada:** Los datos de contacto capturados en `usuario` y `preferencia_visitante` tienen como **única y exclusiva finalidad**: (a) la expedición de credenciales de acceso a la plataforma, (b) el filtrado personalizado de ofertas en plazoleta, (c) el despacho del código QR dinámico del cupón, y (d) la validación de redención en caja.
2. **Autorización Previa y Expresa:** Durante el registro en la PWA, el visitante debe marcar una casilla obligatoria no preseleccionada:
   > *"Autorizo expresamente al Centro Comercial San Pedro Plaza y a la plataforma Nuvora el tratamiento de mis datos personales de conformidad con la Ley 1581 de 2012 y su Política de Privacidad."*
   * **Implementación sobre el modelo de 64 columnas:** La capa de negocio exige y valida obligatoriamente dicha autorización antes de ejecutar el `INSERT` en `usuario`; ninguna cuenta puede persistirse sin aceptación previa, quedando la fecha/hora exacta del consentimiento registrada en `usuario.fecha_registro` (`TIMESTAMPTZ NOT NULL`), lo que evita redundancia booleana en el esquema sin perder trazabilidad legal.
3. **Derechos del Titular (Habeas Data):** En el módulo de perfil de la PWA, el usuario dispone de acciones directas para: (1) Conocer qué datos y preferencias reposan en `usuario` y `preferencia_visitante`, (2) Actualizar o rectificar información inexacta, y (3) Revocar la autorización y solicitar supresión cuando no medie deber legal o contractual de retención histórica contable.
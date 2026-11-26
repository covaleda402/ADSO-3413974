# Políticas de Seguridad de la Información y Matriz de Roles (B6)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** Jose Esneider Covaleda Hortua (`covaleda402`)  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C5)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Introducción y Marco Normativo de Seguridad

La plataforma **Nuvora** maneja información personal de visitantes del Centro Comercial San Pedro Plaza, catálogos comerciales de locatarios y transacciones financieras de descuento. Para salvaguardar estos activos, se formulan políticas técnicas concretas articuladas bajo la tríada **CID (Confidencialidad, Integridad y Disponibilidad)**, dando cumplimiento al estándar **ISO/IEC 27001** y al marco legal colombiano de protección de datos personales (**Ley Estatutaria 1581 de 2012**).

---

## 2. Políticas de Seguridad de la Información (Tríada CID)

Para cumplir con la exigencia de **al menos 2 políticas concretas por cada principio (mínimo 6 en total)**, se definen e implementan las siguientes directrices operativas sobre el esquema de base de datos:

| Principio | ID Política | Nombre de la Política | Medida Técnica Concreta sobre el Caso Nuvora |
|:---:|:---:|---|---|
| **INTEGRIDAD** | **POL-INT-01** | **Bloqueo Pesimista y Prevención de Doble Canje** | En el momento en que un cajero valida un cupón en la terminal POS (`CU-07`), el backend ejecuta la consulta `SELECT * FROM cupon WHERE id_cupon = $1 FOR UPDATE`. Esta instrucción adquiere un bloqueo exclusivo a nivel de fila durante la transacción ACID, garantizando que ninguna solicitud concurrente en milisegundos pueda redimir el mismo cupón dos veces. |
| **INTEGRIDAD** | **POL-INT-02** | **Inmutabilidad y Sello Transaccional de Auditoría** | La tabla `bitacora_canje` tiene prohibidas las operaciones de `UPDATE` y `DELETE` para todos los roles ordinarios mediante un *Trigger* en PostgreSQL. Cada registro genera un hash criptográfico SHA-256 combinando `{id_cupon, id_usuario_cajero, fecha_hora, monto_descuento}` que sella matemáticamente la transacción contra alteraciones posteriores. |
| **INTEGRIDAD** | **POL-INT-03** | **Control de Stock y Restricciones CHECK de Base de Datos** | El stock disponible de las promociones se protege con la restricción `CHECK (stock_disponible >= 0)`. Toda emisión de cupón decrementa el stock en la misma transacción atómica; si el stock llega a cero, el motor rechaza cualquier emisión adicional a nivel de base de datos. |
| **CONFIDENCIALIDAD** | **POL-CON-01** | **Dispersión Criptográfica de Contraseñas (Hash + Sal)** | Las contraseñas de los usuarios **nunca se almacenan cifradas (no se usa cifrado reversible)**, sino dispersadas de forma irreversible mediante el algoritmo **bcrypt (factor de costo = 12)** con sal criptográfica única autogenerada por usuario. Esto neutraliza ataques de diccionario y tablas *rainbow*. |
| **CONFIDENCIALIDAD** | **POL-CON-02** | **Cifrado de Datos en Tránsito y Reposo (TLS 1.3 & AES-256)** | Todo el tráfico entre clientes web (PWA y POS) y el servidor transita obligatoriamente sobre **HTTPS/WSS con TLS 1.3**, deshabilitando versiones inseguras (SSLv3, TLS 1.0, 1.1). La columna `telefono_contacto` y datos sensibles de clientes se cifran en reposo en disco mediante extensión `pgcrypto` con clave administrada por el servidor. |
| **CONFIDENCIALIDAD** | **POL-CON-03** | **Segregación de Vistas y Mascaramiento de Datos** | Los cajeros y locatarios solo pueden consultar el código alfanumérico y nombre de pila del visitante en su terminal POS; el correo electrónico, teléfono y contraseña se enmascaran o se omiten en las consultas de caja para preservar la privacidad del consumidor. |
| **DISPONIBILIDAD** | **POL-DIS-01** | **Respaldo Automatizado Diario y Copia Externa en la Nube** | Se programa un trabajo *Cron* que ejecuta a las 3:00 a. m. (hora valle de actividad) un volcado completo de la base de datos (`pg_dump -Fc`). El archivo resultante se cifra con GPG y se replica automáticamente a un repositorio de almacenamiento secundario en la nube (AWS S3) con política de retención rotativa de 30 días calendario. |
| **DISPONIBILIDAD** | **POL-DIS-02** | **Protocolo de Prueba de Restauración Mensual con Acta** | El primer lunes de cada mes se ejecuta un simulacro de recuperación ante desastres en un entorno de pruebas aislado (*Staging*), restaurando el último respaldo y verificando la integridad referencial y de bitácora mediante script automatizado. Se emite un acta técnica formal firmada por el administrador. |

---

## 3. Matriz de Control de Acceso Basado en Roles (RBAC)

Para garantizar el principio de mínimo privilegio (*Least Privilege*), la siguiente matriz define los permisos estrictos otorgados sobre las ocho (8) tablas del esquema relacional para los **tres (3) roles principales del sistema**:

| Tabla Relacional | Rol: Visitante (`VISITANTE`) | Rol: Locatario / Cajero (`LOCATARIO`) | Rol: Administrador (`ADMINISTRADOR`) |
|---|:---:|:---:|:---:|
| `usuario` | `SELECT` (solo su propia fila)<br>`UPDATE` (solo su perfil/clave) | `SELECT` (solo su propia fila)<br>`UPDATE` (su perfil/clave) | `SELECT`, `INSERT`, `UPDATE` (gestión de cuentas) |
| `categoria_comercio` | `SELECT` | `SELECT` | `SELECT`, `INSERT`, `UPDATE` |
| `local_comercial` | `SELECT` (locales activos) | `SELECT` (su local)<br>`UPDATE` (horario/contacto de su local) | `SELECT`, `INSERT`, `UPDATE` |
| `producto` | `SELECT` (platos disponibles) | `SELECT`, `INSERT`, `UPDATE` (solo carta de su local) | `SELECT`, `UPDATE` |
| `promocion` | `SELECT` (promociones activas) | `SELECT`, `INSERT`, `UPDATE` (solo promociones de su local) | `SELECT`, `UPDATE` (auditoría/pausa) |
| `franja_horaria` | `SELECT` | `SELECT`, `INSERT`, `UPDATE`, `DELETE` (franjas de su local) | `SELECT` |
| `cupon` | `SELECT` (sus cupones emitidos)<br>`INSERT` (adquirir nuevo cupón) | `SELECT` (cupones de su local)<br>`UPDATE` (marcar canjeado vía POS) | `SELECT` (todos los cupones) |
| `bitacora_canje` | Sin acceso directo | `INSERT` (generar registro al canjear)<br>`SELECT` (solo ventas de su local) | `SELECT` (toda la bitácora para auditoría) |

* **Regla estricta:** Ningún usuario o rol tiene permiso de `DELETE` sobre las tablas `usuario`, `cupon` ni `bitacora_canje`. La eliminación lógica se gestiona mediante cambio de estado (`estado_cuenta = 'INACTIVO'`).

---

## 4. Política de Tratamiento de Datos Personales (Ley 1581 de 2012)

1. **Finalidad Informada:** Los datos de contacto capturados (nombre, correo y teléfono) tienen como **única y exclusiva finalidad**: (a) la expedición de credenciales de acceso a la plataforma, (b) el despacho del código QR dinámico del cupón, y (c) la verificación de identidad en el momento de redención en la plazoleta de comidas.
2. **Autorización Previa y Expresa:** Durante el registro en la PWA, el visitante debe marcar una casilla obligatoria no preseleccionada que reza:
   > *"Autorizo expresamente al Centro Comercial San Pedro Plaza y a la plataforma Nuvora el tratamiento de mis datos personales de conformidad con la Ley 1581 de 2012 y su Política de Privacidad."*
3. **Derechos del Titular (Habeas Data):** En el panel de perfil de la PWA, el usuario dispone de opciones directas para: (1) Conocer qué datos personales reposan en el sistema, (2) Actualizar o rectificar datos inexactos, y (3) Revocar la autorización y solicitar la supresión de sus datos de la base activa cuando no medie un deber legal o contractual de retención.

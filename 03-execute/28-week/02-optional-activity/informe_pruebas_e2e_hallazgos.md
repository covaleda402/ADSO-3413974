# Informe Técnico de Pruebas End-to-End (E2E), Metodología y Hallazgos

**Proyecto:** Sistema de Gestión de Asistencia SENA  
**Ficha Académica:** 3413974 - Análisis y Desarrollo de Software (ADSO)  
**Autor / Desarrollador:** Jose Esneider Covaleda Hortua  
**Fecha de Ejecución:** 19 de Noviembre de 2026  
**Entorno de Pruebas:** Local (`http://localhost:3000`) con Base de Datos PostgreSQL Serverless (Neon)  
**Herramienta de Ejecución:** Suite E2E personalizada en Node.js 26 (`tests/e2e/e2e-runner.js`)

---

## 1. Resumen Ejecutivo de la Evaluación

Se realizó una auditoría y ejecución de pruebas de extremo a extremo (**End-to-End - E2E**) sobre el Sistema de Gestión de Asistencia SENA tras su clonación, configuración y despliegue en entorno local. La batería de pruebas abarcó la totalidad de flujos funcionales, interfaces de usuario, restricciones criptográficas, inferencia biométrica facial, validaciones geodésicas y reglas transaccionales de negocio.

### Métricas Globales de Calidad
- **Total de pruebas E2E ejecutadas:** 48 pruebas automatizadas.
- **Pruebas superadas exitosamente (PASS):** 48 (100.0%).
- **Pruebas fallidas (FAIL):** 0 (0.0%).
- **Tiempo total de ejecución de la suite:** 25.48 segundos.
- **Suites evaluadas:** 9 dominios arquitectónicos.

```
========================================================================
🧪 RESUMEN DE RESULTADOS DE PRUEBAS E2E
========================================================================
Total de pruebas ejecutadas: 48
Pruebas superadas (PASS):    48
Pruebas fallidas  (FAIL):    0
Tiempo total de ejecución:   25.48 s
Tasa de éxito:               100.0%
========================================================================
```

---

## 2. Metodología y Estrategia de Pruebas E2E

Las pruebas End-to-End validan el comportamiento del sistema simulando exactamente el rol de los actores humanos (Instructor, Coordinador Académico y Aprendiz) interactuando con el servidor en tiempo real. 

### Arquitectura del Ejecutor de Pruebas (`tests/e2e/e2e-runner.js`)
Para garantizar aislamiento, alta velocidad y reproducibilidad en entornos CI/CD y locales, se implementó un motor de pruebas que emula:

1. **Gestión de Sesiones y Cookies HTTP:**
   - Implementación de un `CookieJar` personalizado para capturar y adjuntar automáticamente las cookies firmadas `sena_session` (JWT con expiración de 12 horas para Instructor/Coordinador) y `sena_aprendiz_session` (JWT de 8 horas para Aprendices).
2. **Simulación Biométrica Facial 128D:**
   - Generación determinística de descriptores faciales unitarios (vectores de 128 elementos tipo `Float64` normalizados) para evaluar tanto coincidencias biométricas legítimas (distancia euclidiana $\approx 0.00 < 0.55$) como intentos de suplantación de identidad (vectores ortogonales con distancia $> 0.55$).
3. **Generación Criptográfica de Tokens Rotativos:**
   - Emulación del algoritmo HMAC-SHA256 con ventana de tiempo de 30 segundos (`Math.floor(Date.now() / 30000)`), verificando la aceptación de tokens actuales y la invalidación estricta de capturas adulteradas o expiradas.
4. **Validación Geodésica Haversine:**
   - Envío de coordenadas GPS para comprobar tanto la marcación exitosa dentro del radio perimetral del Ambiente de Aprendizaje (Ambiente 204: 100 metros) como el rechazo inmediato ante coordenadas externas (prueba con geolocalización fuera de rango).
5. **Simulación de Carga de Archivos (Multipart/Form-Data):**
   - Transmisión en memoria de adjuntos médicos sintéticos en formatos admitidos (`application/pdf` e `image/png`) para probar la radicación de excusas unidía y multidía.
6. **Verificación Directa de Integridad en PostgreSQL:**
   - Conexión concurrente vía `pg.Client` para auditar la persistencia física en las tablas `attendances`, `qr_sessions`, `aprendices`, `excuse_requests` y `audit_events`.

---

## 3. Desglose Detallado de Pruebas Realizadas por Suite

### Suite 1: Autenticación y Control de Acceso Basado en Roles (RBAC)
- **1.1 Validación de Términos Legales (Habeas Data):** Petición de login sin `accept_terms: true` rechazada con `HTTP 400 Bad Request`.
- **1.2 Login Exitoso de Instructor:** Autenticación de *Carlos Mario Restrepo* (Doc. `1000200300`), generación de cookie `sena_session` y redirección a `/instructor/dashboard`.
- **1.3 Verificación de Sesión Activa (`/api/auth/me`):** Extracción y descifrado del JWT confirmando rol `instructor`.
- **1.4 Login Exitoso de Coordinador:** Autenticación de *Diana Carolina Rojas* (Doc. `900800700`) con redirección a `/coordinador/dashboard`.
- **1.5 Detección de Documento No Registrado:** Envío de documento inexistente; respuesta adecuada con `HTTP 401 Unauthorized`.
- **1.6 Discrepancia de Nombre:** Intento de login con documento válido pero nombre no coincidente; rechazo con `HTTP 401 Unauthorized`.
- **1.7 Restricción Cruzada de Roles:** Intento del Instructor de consultar endpoints de gestión global de instructores (`/api/coordinador/instructores`); bloqueado con `HTTP 403 Forbidden`.
- **1.8 Protección de Rutas Anónimas:** Petición sin credenciales a `/api/instructor/sessions` bloqueada con `HTTP 403 Forbidden`.

### Suite 2: Ciclo de Vida de Sesiones QR (Instructor)
- **2.1 Consulta de Opciones Académicas:** Obtención dinámica de ambientes y fichas asignadas (comprobando presencia de la Ficha `3413974`).
- **2.2 Aislamiento de Entorno:** Limpieza de sesiones residuales previas.
- **2.3 Apertura de Sesión Regular:** Creación de sesión para la Ficha `3413974` en el *Ambiente 204*, con duración de 6 horas académicas y expiración de QR de 5 minutos. Retorno de token maestro y token rotativo HMAC-SHA256.
- **2.4 Regla de Sesión Única Activa:** Intento de abrir una segunda sesión concurrente sin cerrar la anterior; bloqueado con `HTTP 400 Bad Request`.
- **2.5 Consulta de Estado Activo:** Verificación de que la sesión consultada coincide con los parámetros creados.

### Suite 3: Onboarding y Enrolamiento Biométrico del Aprendiz
- **3.1 Comprobación de Identidad:** Validación en `/api/aprendiz/check-identity` para *Jose Esneider Covaleda Hortua* (Doc. `1077726131`) contra el listado oficial de la ficha.
- **3.2 Exigencia de Consentimiento Biométrico:** Intento de enrolamiento facial sin aceptar la cláusula de tratamiento de datos biométricos; rechazado con `HTTP 400 Bad Request`.
- **3.3 Enrolamiento Exitoso:** Almacenamiento del descriptor vectorial 128D, generación de evento de auditoría en BD y emisión de cookie de sesión de aprendiz (`sena_aprendiz_session`).
- **3.4 Verificación de Estado Biométrico:** Consulta en `/api/aprendiz/check-face-status` retornando `has_face: true`.

### Suite 4: Verificación Facial 128D y Marcación de Asistencia QR
- **4.1 Lectura de Información de Sesión:** Consulta vía `GET /api/aprendiz/session-info?token=...` validando vigencia y datos del ambiente.
- **4.2 Detección de Impostor Facial:** Envío de vector divergente (distancia euclidiana $> 0.55$); rechazo biométrico con `HTTP 401/403`.
- **4.3 Coincidencia Facial Legítima:** Envío del vector biométrico registrado; verificación aprobada con distancia $< 0.05$ en $< 200\text{ ms}$.
- **4.4 Control de Geocerca GPS (Haversine):** Envío de coordenadas fuera del perímetro permitido ($> 100\text{ m}$); rechazo estricto con `HTTP 403 Forbidden` (*Geocerca violada*).
- **4.5 Marcación Exitosa:** Envío simultáneo de vector biométrico coincidente, token rotativo válido y coordenadas GPS dentro del ambiente; asistencia guardada como `Presente` / `puntual`.
- **4.6 Prevención de Duplicados:** Segundo intento de registro del mismo aprendiz en la misma sesión; rechazado con `HTTP 409 Conflict`.
- **4.7 Detección de QR Rotado/Fraudulento:** Intento con token rotativo adulterado; rechazo con `HTTP 410 Gone`.

### Suite 5: QR Tardío, Cierre de Sesión y Faltas Automáticas
- **5.1 Generación de QR Tardío (`late_qr`):** Creación de sesión hija vinculada a la sesión principal dentro de la ventana de gracia.
- **5.2 Marcación en Sesión Tardía:** Registro de una segunda aprendiz (*Brenda Carolina Galeano*); almacenamiento clasificado como `Tarde` / `qr_tardio`.
- **5.3 Cierre de Sesión por el Instructor:** Ejecución de `/api/instructor/sessions/[id]/finish`.
- **5.4 Generación Idempotente de Faltas Automáticas:** El backend auditó la ficha de 30 aprendices y generó automáticamente registros de `Falta` con tipo `ausencia_automatica` para los 28 aprendices que no registraron marcación.
- **5.5 Bloqueo Post-Cierre:** Intento de marcación en sesión finalizada; denegado con `HTTP 410 Gone`.

### Suite 6: Roster, Novedades y Ajustes Manuales
- **6.1 Consulta del Roster:** Verificación de los 30 aprendices de la Ficha `3413974` vía `/api/instructor/roster?ficha_code=3413974`.
- **6.2 Registro Manual de Tardanza:** Ajuste manual de un aprendiz (*Martín Julián Torres*) con estado `Justificado` y observaciones institucionales.

### Suite 7: Flujo Transaccional de Excusas y Concurrencia Optimista
- **7.1 Radicación de Excusa Unidía (1 día):** Carga de certificado médico PDF; enrutada automáticamente a la bandeja del Instructor.
- **7.2 Radicación de Excusa Multidía (3 días):** Carga de incapacidad PNG; enrutada a Coordinación Académica con notificación en abanico (*fan-out*).
- **7.3 Restricción de Autoridad:** Intento del Instructor de resolver la excusa multidía; rechazado por falta de competencia funcional.
- **7.4 Aprobación de Excusa Unidía por el Instructor:** Procesamiento con éxito e incremento de versión de `1` a `2`.
- **7.5 Prueba de Bloqueo Optimista (Lost Update Prevention):** Reintento de modificación enviando `version: 1` sobre un registro que ya avanzó a versión `2`; respuesta esperada con `HTTP 409 Conflict`.
- **7.6 Aprobación de Excusa Multidía por el Coordinador:** Resolución válida por Coordinación e incremento de versión.

### Suite 8: Auditoría y Reportes
- **8.1 Historial de Instructor:** Comprobación de sesiones y asistencias históricas en `/api/instructor/history`.
- **8.2 Historial Global de Coordinación:** Consulta agregada de sesiones en `/api/coordinador/history`.
- **8.3 Historial Personal del Aprendiz:** Consulta de kardex individual en `/api/aprendiz/my-attendance?document=1077726131`.
- **8.4 Persistencia de Trazabilidad (`audit_events`):** Comprobación en base de datos de eventos inmutables registrados con rol, IP, navegador, identificador y metadatos JSON.

### Suite 9: Verificación de Interfaces de Usuario (UI Health Check)
- Renderizado con código `HTTP 200 OK` y estructura HTML completa para:
  - `/login` (Acceso principal)
  - `/scan` (Escáner de cámara QR)
  - `/aprendiz/acceso` (Portal de validación de identidad)
  - `/aprendiz/primera-vez` (Módulo de captura biométrica)
  - `/instructor/dashboard` (Panel de mando de sesión activa)
  - `/coordinador/dashboard` (Panel global directivo)
  - `/aprendiz/dashboard` (Portal de auto-consulta de asistencia)

---

## 4. Hallazgos Encontrados, Diagnóstico y Soluciones

Durante el diseño y ejecución iterativa de la suite de pruebas E2E se identificaron los siguientes hallazgos técnicos en la arquitectura de la aplicación:

### Hallazgo 1: Obligatoriedad de Aceptación de Términos en Autenticación (`accept_terms`)
- **Descripción:** El esquema Zod `LoginSchema` (`src/domain/user.domain.ts`) exige de manera estricta `accept_terms: true`. Cualquier intento de autenticación que omita este parámetro o lo envíe en `false` retorna `HTTP 400 Bad Request`.
- **Diagnóstico:** Excelente práctica legal en cumplimiento de la Ley 1581 de 2012 (Habeas Data en Colombia). No se debe autenticar a ningún usuario institucional sin registro explícito de consentimiento de tratamiento de datos.
- **Acción:** La suite de pruebas modeló pruebas negativas para verificar que el servidor rechaza peticiones sin términos y pruebas positivas con el consentimiento firmado.

### Hallazgo 2: Enrutamiento y Método HTTP en Información de Sesión (`/api/aprendiz/session-info`)
- **Descripción:** Al intentar consultar la información de la sesión mediante `POST`, el servidor retornó `HTTP 405 Method Not Allowed`.
- **Diagnóstico:** El controlador `src/app/api/aprendiz/session-info/route.ts` expone únicamente el verbo `GET` recibiendo el token vía parámetro de búsqueda (`?token=...`).
- **Solución Aplicada:** Se ajustó la prueba E2E para consumir el endpoint bajo el estándar RESTful `GET`, validando la respuesta con éxito.

### Hallazgo 3: Convención de Parámetros en Roster de Aprendices (`/api/instructor/roster`)
- **Descripción:** Al consultar aprendices pasando `?ficha_id=4`, el endpoint retornó `HTTP 400 Bad Request` indicando que el código de ficha es obligatorio.
- **Diagnóstico:** La API espera específicamente `?ficha_code=3413974` (`src/app/api/instructor/roster/route.ts`) para desacoplar el identificador interno autonumérico de la clave natural de negocio que maneja el SENA.
- **Solución Aplicada:** Se estandarizó el llamado usando `ficha_code`, retornando la lista completa de los 30 aprendices matriculados.

### Hallazgo 4: Contrato de Retorno en Estado Biométrico (`/api/aprendiz/check-face-status`)
- **Descripción:** La API retorna la llave `{ has_face: true }` y no `{ has_face_registered: true }`.
- **Diagnóstico:** En `src/app/api/aprendiz/check-face-status/route.ts`, la variable calculada es `hasFace = Boolean(face_descriptor_json) || Boolean(face_asset_public_id)`.
- **Solución Aplicada:** Verificación asertiva alineada con el contrato JSON oficial del backend.

### Hallazgo 5: Eficacia Comprobada del Bloqueo Optimista (ADR-008)
- **Descripción:** Se verificó que cuando un usuario intenta aprobar o rechazar una excusa con un número de versión anterior al que reside en PostgreSQL, la base de datos no modifica ninguna fila y el servicio lanza `ConcurrencyConflictError`, traduciéndose en `HTTP 409 Conflict`.
- **Impacto:** Protege completamente el sistema contra la anomalía de "Actualización Perdida" (*Lost Update*), garantizando que dos instructores o directivos no sobreescriban decisiones concurrentes.

### Hallazgo 6: Resiliencia de Conexión DNS en PostgreSQL Pooler
- **Descripción:** En plataformas Windows con Node.js $\ge 20$, las resoluciones DNS sobre endpoints CNAME de Neon (`ep-*-pooler.*.neon.tech`) pueden presentar fluctuaciones si se intenta resolver en IPv6 cuando no hay enrutamiento activo.
- **Solución Aplicada:** Se configuró `dns.setDefaultResultOrder('ipv4first')` y una rutina de reconexión con retroceso exponencial en la suite de pruebas, garantizando 100% de estabilidad de red.

---

## 5. Conclusiones y Estado del Proyecto

1. **Estado del Despliegue:** El proyecto se encuentra 100% operativo en entorno local, compilado con Next.js 14 en modo producción (`next start`) y conectado a una base de datos PostgreSQL aislada y migrada.
2. **Confiabilidad:** Las 48 pruebas E2E demuestran que el sistema respeta todas las invariantes de negocio: autenticación segura, rotación de códigos QR cada 30 segundos, geocercas por ambiente, biometría facial 128D, generación automática de inasistencias y control de concurrencia optimista.
3. **Automatización:** Se añadió el script permanente `"test:e2e": "node tests/e2e/e2e-runner.js"` en el archivo `package.json`, permitiendo al equipo ejecutar toda la suite en cualquier momento con un solo comando.

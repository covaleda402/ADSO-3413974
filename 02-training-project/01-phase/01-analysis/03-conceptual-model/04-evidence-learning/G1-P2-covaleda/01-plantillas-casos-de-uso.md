# 01 · Especificación Extendida de Casos de Uso Críticos
## Proyecto Formativo: Nuvora — Ecosistema Digital San Pedro Plaza
**Ficha SENA:** 3413974 · ADSO · Regional Huila  
**Aprendiz:** `covaleda402`  
**Guía 1:** Modelo Conceptual (Análisis) — **Producto 2:** Modelo de Análisis y Verificación (G1-P2)  
**Criterio de Evaluación:** C2 de `Rubricas_G1.md` (RAP 592373 - Modelar las funciones del software)  

---

## 1. Alcance y Criterio de Selección de Casos de Uso Críticos

Para dar cumplimiento estricto a la Sección 5.1 (ítem b) y al Criterio C2 de la rúbrica oficial de la Guía 1, se seleccionan los **tres (3) casos de uso más críticos y de mayor impacto transaccional** del ecosistema Nuvora en el Centro Comercial San Pedro Plaza:

1. **CU03: Generar cupón digital de descuento (Módulo Consumidor):** Núcleo de atracción de tráfico hacia la plazoleta; gestiona la emisión limitada de códigos QR, control de unicidad diaria y autenticación obligatoria.
2. **CU05: Gestionar promociones y franjas horarias relámpago (Módulo Locatario):** Núcleo de parametrización comercial; permite a los restaurantes configurar descuentos con límites de cupos y horarios valle para dinamizar ventas.
3. **CU07: Canjear cupón de descuento en caja (Módulo Punto de Venta):** Núcleo operativo y de seguridad; ejecuta la validación atómica en menos de 1.5 segundos, previene el doble canje concurrente y registra la auditoría inmutable.

Cada plantilla incorpora: precondiciones formales, flujo principal numerado de 8 pasos (superando el mínimo de 6 exigido), flujos alternos documentados, excepciones operativas con control de errores y postcondiciones de éxito y fallo.

---

## 2. Plantilla Extendida 1 · CU03: Generar Cupón Digital de Descuento

| Campo | Especificación Formal del Caso de Uso |
| :--- | :--- |
| **Identificador y Nombre** | **CU03: Generar cupón digital de descuento** |
| **Requisitos que atiende** | `RF-13`, `RF-14`, `RF-15` (`RNF-03`) |
| **Actor Principal** | **Visitante / Consumidor** |
| **Actores Secundarios** | Servicio de Identidad de Nuvora / Repositorio Central del Negocio |
| **Objetivo de Negocio** | Permitir al visitante obtener un cupón promocional único para redimir en un local de la plazoleta de comidas de San Pedro Plaza, garantizando el límite de 1 cupón diario por promoción (Regla RN-01). |
| **Tipo de Caso de Uso** | Crítico / Transaccional de Cara al Consumidor |
| **Relaciones Asociadas** | `«include»` a **CU04 (Autenticar usuario en la plataforma)** |
| **Precondiciones** | 1. El visitante accede a la aplicación de Nuvora desde su dispositivo móvil.<br>2. La promoción solicitada se encuentra publicada en estado `Activa`.<br>3. Existen cupos disponibles para la promoción en la fecha actual (`cupos disponibles > 0`). |
| **Disparador** | El visitante presiona el botón *"Obtener Cupón de Descuento"* sobre una oferta activa del catálogo. |
| **Reglas de negocio** | `RN-01` (máximo 1 cupón por promoción cada 24 h), `RN-02` (vigencia estricta de 2 horas desde la emisión), `RN-05` (validación contra hora oficial del servidor). |
| **Pantalla del prototipo** | [`M-01 Catálogo por Presupuesto` y `M-02 Billetera Digital`](./05-prototipos-mockups.md) |

### Flujo Principal de Eventos (Camino Feliz):
1. **Selección de la Oferta:** El visitante visualiza el catálogo de promociones de San Pedro Plaza y pulsa sobre una oferta de su interés.
2. **Verificación de Disponibilidad:** El sistema verifica en línea que la promoción esté activa y cuente con cupos disponibles.
3. **Solicitud de Emisión:** El visitante presiona la opción *"Obtener Cupón de Descuento"*.
4. **Validación de Identidad (`«include» CU04`):** El sistema invoca obligatoriamente el caso de uso `CU04`, verificando la sesión activa e identidad del visitante.
5. **Control de Límite Diario (Regla RN-01):** El sistema comprueba en el historial de cupones que el usuario no haya generado otro cupón activo para la misma promoción durante las últimas 24 horas.
6. **Generación de Código Único (Regla RN-02):** El sistema genera un identificador alfanumérico aleatorio único de 8 caracteres (ej. `NUV-8K42`) junto con su credencial verificable y fija una vigencia estricta de 2 horas según el reloj oficial del sistema.
7. **Registro Transaccional:** El sistema registra el nuevo cupón en estado `Emitido` y descuenta una unidad del inventario de cupos disponibles de la promoción (`cupos disponibles - 1`).
8. **Presentación en Billetera:** El sistema exhibe en la vista del visitante el código QR de verificación, el código alfanumérico visible y un reloj regresivo de 2 horas en la sección "Mis Cupones".

### Flujos Alternativos:
* **FA-01: Usuario sin sesión iniciada al momento de la solicitud:**
  * En el paso 4, si el visitante no tiene sesión activa, el sistema conserva temporalmente su selección y lo redirige al flujo de autenticación o registro rápido (`CU04`).
  * Una vez autenticado, el sistema retoma automáticamente el flujo en el paso 5 sin que el visitante deba buscar nuevamente la oferta.
* **FA-02: Acceso tras filtrado previo por presupuesto (`CU02`):**
  * En el paso 1, el visitante llega a la promoción desde los resultados del filtro monetario (ej. $15.000 COP); el sistema resalta el valor con descuento dentro del rango elegido.

### Flujos de Excepción (Manejo de Errores):
* **EX-01: Cupos agotados concurrentemente por otro usuario:**
  * Si en el paso 5 o 7 otro visitante toma el último cupo disponible (`cupos disponibles = 0`), el sistema cancela la emisión, actualiza la promoción a estado `Agotada` y notifica al usuario: *"Lo sentimos, los cupos para esta oferta acaban de agotarse. Te invitamos a explorar otras promociones de la plazoleta"*.
* **EX-02: Límite diario alcanzado por el usuario (Regla RN-01):**
  * Si en el paso 5 se detecta que el usuario ya emitió un cupón vigente para esa promoción dentro de las últimas 24 horas, el sistema detiene la emisión y muestra una alerta informativa: *"Ya has reclamado tu cupón disponible para esta promoción. Podrás solicitar otro pasado el período vigente"*.
* **EX-03: Interrupción de conectividad durante la confirmación:**
  * Si en el paso 7 la conexión móvil se interrumpe antes de confirmarse la operación, el sistema revierte la reserva parcial y ofrece *"Reintentar solicitud"* sin consumir el límite del usuario.

### Postcondiciones:
* **Postcondición de Éxito:** El cupón queda registrado en estado `Emitido` asociado al visitante, se descuenta un cupo disponible, el código de verificación queda listo en la billetera y comienza la ventana de 2 horas.
* **Postcondición de Fallo:** No se descuentan cupos, no se emite ningún cupón y el visitante permanece en la vista de la oferta con el motivo informado.

---

## 3. Plantilla Extendida 2 · CU05: Gestionar Promociones del Local y Franjas Relámpago

| Campo | Especificación Formal del Caso de Uso |
| :--- | :--- |
| **Identificador y Nombre** | **CU05: Gestionar promociones del local** |
| **Requisitos que atiende** | `RF-09`, `RF-10`, `RF-11`, `RF-12` |
| **Actor Principal** | **Locatario / Administrador de Tienda** |
| **Actores Secundarios** | Repositorio de Ofertas y Catálogo de Nuvora |
| **Objetivo de Negocio** | Permitir al comerciante dar de alta, modificar, pausar y parametrizar ofertas con cupos limitados y franjas relámpago para dinamizar el consumo en horarios de baja afluencia. |
| **Tipo de Caso de Uso** | Administrativo / Comercial de Gestión |
| **Relaciones Asociadas** | `«extend»` desde **CU06 (Parametrizar franjas horarias relámpago)** |
| **Precondiciones** | 1. El locatario ha iniciado sesión con credenciales válidas y rol `Locatario`.<br>2. El establecimiento comercial se encuentra en estado `Activo` en el directorio de San Pedro Plaza.<br>3. El locatario tiene registrado al menos un producto en su menú. |
| **Disparador** | El locatario selecciona *"Crear Nueva Promoción"* desde su panel de administración del local. |
| **Reglas de negocio** | `RN-03` (respeto de cupones ya emitidos si la oferta cambia de estado), `RN-05` (franjas relámpago dentro del horario del centro comercial 10:00 a. m.–9:00 p. m.). |
| **Pantalla del prototipo** | Flujo administrativo del panel comercial (`CU05` / `CU06`) vinculado en [`05-prototipos-mockups.md`](./05-prototipos-mockups.md) |

### Flujo Principal de Eventos (Camino Feliz):
1. **Acceso al Módulo:** El locatario ingresa a su panel administrativo y selecciona *"Crear Nueva Promoción"*.
2. **Formulario de Parámetros:** El sistema presenta el formulario de configuración solicitando: título comercial, producto del menú, porcentaje o monto de descuento, fechas de vigencia y límite de cupos disponibles.
3. **Selección de Producto y Beneficio:** El locatario selecciona el combo o plato gastronómico y establece el descuento aplicable.
4. **Activación de Franja Relámpago (`«extend» CU06`):** De manera opcional, el locatario activa *"Oferta Relámpago Horas Valle"* y define los días y el intervalo horario (ej. martes a jueves de 2:30 p. m. a 5:30 p. m.).
5. **Validación de Reglas de Negocio:** El sistema valida que el precio resultante sea inferior al precio ordinario y que las franjas horarias estén dentro del horario comercial del centro comercial (10:00 a. m. a 9:00 p. m., Regla RN-05).
6. **Fijación de Cupos y Stock:** El locatario asigna el cupo máximo disponible para la campaña (ej. 25 cupones).
7. **Confirmación y Publicación:** El locatario confirma mediante *"Publicar Promoción"*.
8. **Publicación en Catálogo:** El sistema registra la promoción y sus franjas horarias asociadas en estado `Activa`, habilitándola en el directorio de ofertas de Nuvora.

### Flujos Alternativos:
* **FA-01: Guardado en modo Borrador:**
  * En el paso 7, el locatario decide no publicar de inmediato y elige *"Guardar como Borrador"*. El sistema conserva la configuración en estado `Borrador` sin hacerla visible al público.
* **FA-02: Promoción estándar sin franja relámpago:**
  * En el paso 4, el locatario omite la extensión `CU06`; el sistema establece validez continua durante todo el rango de fechas autorizado.

### Flujos de Excepción (Manejo de Errores):
* **EX-01: Inconsistencia financiera en el valor de la oferta:**
  * Si en el paso 5 el beneficio configurado deja un valor igual o superior al precio regular del plato, el sistema impide el guardado y notifica: *"El valor con descuento ($COP) debe ser estrictamente menor al precio base del producto"*.
* **EX-02: Solapamiento de franjas horarias relámpago:**
  * Si en el paso 5 el sistema detecta otra oferta activa para el mismo producto en el mismo rango horario, notifica: *"Ya existe una oferta relámpago programada para este producto en ese horario. Ajuste la franja o pause la anterior"*.
* **EX-03: Incoherencia en fechas de vigencia:**
  * Si la fecha de finalización es anterior o igual a la fecha de inicio, el sistema informa: *"La fecha de finalización debe ser posterior a la fecha de inicio de la promoción"*.

### Postcondiciones:
* **Postcondición de Éxito:** La promoción queda registrada en estado `Activa` (o `Borrador`) con sus franjas asociadas y visible en el catálogo durante las ventanas válidas.
* **Postcondición de Fallo:** No se publican cambios en el catálogo y los datos ingresados permanecen editables para corrección.

---

## 4. Plantilla Extendida 3 · CU07: Canjear Cupón de Descuento en Caja

| Campo | Especificación Formal del Caso de Uso |
| :--- | :--- |
| **Identificador y Nombre** | **CU07: Canjear cupón de descuento en caja** |
| **Requisitos que atiende** | `RF-16`, `RF-17`, `RF-18`, `RF-20` (`RNF-01`, `RNF-04`) |
| **Actor Principal** | **Cajero / Validador en Punto de Venta** |
| **Actores Secundarios** | Cliente / Consumidor (Portador) · Servicio Central de Validación Nuvora |
| **Objetivo de Negocio** | Validar la autenticidad, vigencia, pertenencia al local y unicidad de uso de un cupón presentado en el mostrador, aplicando el descuento en menos de 1.5 segundos e impidiendo el doble canje (Reglas RN-04 y RN-07). |
| **Tipo de Caso de Uso** | Crítico / Operativo de Redención Inmediata |
| **Relaciones Asociadas** | `«include»` a **CU08 (Verificar código QR criptográfico)**<br>`«extend»` desde **CU09 (Digitar código de cupón manualmente)** |
| **Precondiciones** | 1. El cajero ha iniciado sesión en la estación de validación de su establecimiento comercial.<br>2. La estación de caja dispone de cámara funcional o teclado numérico habilitado.<br>3. El cliente presenta en su dispositivo móvil el código QR o el código de respaldo generado en Nuvora. |
| **Disparador** | El cajero selecciona *"Escanear Cupón"* en la terminal de punto de venta al momento del cobro. |
| **Reglas de negocio** | `RN-02` (vigencia máxima de 2 horas), `RN-04` (unicidad e imposibilidad de doble canje), `RN-05` (reloj oficial del servidor), `RN-07` (coincidencia estricta con el local del cajero). |
| **Pantalla del prototipo** | [`M-03 Terminal de Validación POS en Caja`](./05-prototipos-mockups.md) |

### Flujo Principal de Eventos (Camino Feliz):
1. **Activación de Lectura:** El cajero selecciona *"Escanear Cupón"* en la pantalla de punto de venta.
2. **Lectura Óptica:** El cajero apunta el lector óptico hacia el código QR exhibido en el celular del cliente.
3. **Decodificación del Identificador:** El sistema lee la imagen y extrae el código único y la credencial de verificación del cupón.
4. **Validación Central (`«include» CU08`):** El sistema envía la solicitud por canal cifrado al validador central ejecutando `CU08`.
5. **Verificación de Reglas de Negocio (Tiempo < 1.5 s):** El sistema bloquea de manera exclusiva el registro del cupón para evitar usos simultáneos y comprueba:
   - Que el cupón exista y sea auténtico.
   - Que la promoción pertenezca exactamente al establecimiento del cajero autenticado (Regla RN-07).
   - Que el estado actual del cupón sea `Emitido`.
   - Que la hora oficial del sistema no supere el límite de 2 horas desde la emisión (Regla RN-02).
   - Que, si aplica a franja relámpago, la hora del sistema esté dentro del intervalo autorizado (Regla RN-05).
6. **Marcado Irreversible de Canje (Regla RN-04):** Al aprobarse todas las validaciones, el sistema transiciona atómicamente el estado del cupón a `Redimido` y libera el bloqueo.
7. **Asiento de Auditoría Inmutable:** El sistema genera un asiento definitivo en la bitácora de auditoría con referencia del cupón, cajero validador, comercio, hora exacta de redención, terminal utilizada y valor descontado.
8. **Confirmación Visual y Cierre:** La terminal del cajero emite confirmación sonora y visual en tarjeta verde indicando producto, descuento aplicado y valor neto final a cobrar en caja física.

### Flujos Alternativos:
* **FA-01: Digitación manual de contingencia (`«extend» CU09`):**
  * En el paso 2, si el lector óptico no logra enfocar o la pantalla móvil presenta reflejos o deterioro, el cajero activa *"Ingreso Manual"* (`CU09`).
  * El cajero digita los 8 caracteres alfanuméricos visibles (`NUV-8K42`) y pulsa *"Validar"*, retomando directamente en el paso 4.

### Flujos de Excepción (Manejo de Errores y Antifraude):
* **EX-01: Cupón ya redimido previamente (Doble canje / Intento con captura de pantalla):**
  * Si en el paso 5 el sistema verifica estado `Redimido`, rechaza la operación y despliega alerta roja: *"ALERTA DE SEGURIDAD: Este cupón ya fue canjeado previamente. No aplique el descuento"*. El intento fallido queda asentado en auditoría.
* **EX-02: Cupón vencido por expiración de tiempo (Límite de 2 horas superado - RN-02):**
  * Si en el paso 5 el tiempo transcurrido supera los 120 minutos desde la emisión, el sistema actualiza el cupón a `Expirado` y muestra: *"Cupón caducado. El límite de 2 horas para redimir esta promoción ha expirado"*.
* **EX-03: Cupón perteneciente a otro restaurante de la plazoleta (RN-07):**
  * Si el código pertenece a otro establecimiento comercial, el sistema rechaza el canje e informa: *"Cupón no válido en este establecimiento. Esta oferta corresponde a [Nombre del Local]"*.
* **EX-04: Cupón fuera de franja horaria relámpago (RN-05):**
  * Si la hora oficial está fuera de la ventana horaria autorizada de la campaña, el sistema rechaza: *"Oferta relámpago inactiva en este horario"*.

### Postcondiciones:
* **Postcondición de Éxito:** El cupón queda marcado irreversiblemente como `Redimido`, se asienta la auditoría contable del canje, el cajero descuenta el monto en su factura física y el visitante ve el cupón como canjeado.
* **Postcondición de Fallo:** No se aplica descuento comercial, el cupón conserva su estado original (o cambia a `Expirado` si caducó) y se registra el motivo del rechazo.


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
| **Actor Principal** | **Visitante / Consumidor** |
| **Actores Secundarios** | Sistema de Autenticación JWT / Servidor de Base de Datos PostgreSQL |
| **Objetivo de Negocio** | Permitir al visitante obtener un cupón promocional único para redimir en un local de la plazoleta de comidas de San Pedro Plaza, garantizando el límite de 1 cupón diario por persona (Regla RN-01). |
| **Tipo de Caso de Uso** | Crítico / Transaccional de Cara al Consumidor |
| **Relaciones Asociadas** | `«include»` a **CU04 (Autenticar usuario en la plataforma)**<br>`«extend»` desde **CU02 (Filtrar productos por presupuesto)** |
| **Precondiciones** | 1. El visitante accede a la PWA de Nuvora desde su dispositivo móvil.<br>2. La promoción solicitada se encuentra en estado `Activa` en la base de datos.<br>3. Existen cupos disponibles para la promoción en la fecha actual (`cupos_restantes > 0`). |

### Flujo Principal de Eventos (Camino Feliz):
1. **Selección de la Oferta:** El visitante visualiza el catálogo de promociones de San Pedro Plaza y pulsa sobre una oferta de su interés.
2. **Verificación de Disponibilidad:** El sistema consulta el servidor y comprueba en tiempo real que la promoción esté activa y cuente con cupos disponibles.
3. **Solicitud de Emisión:** El visitante presiona el botón interactivo *"Obtener Cupón de Descuento"*.
4. **Validación de Identidad (`«include» CU04`):** El sistema invoca obligatoriamente el caso de uso `CU04`, validando el token de sesión JWT del visitante.
5. **Control de Límite Diario (Regla RN-01):** El sistema verifica en la base de datos que el usuario no haya generado otro cupón para el mismo local o categoría gastronómica durante el día calendario en curso.
6. **Generación Criptográfica (Regla RN-05):** El sistema genera un identificador alfanumérico aleatorio único de 8 caracteres (ej. `SPP-7K2X9M`) y calcula la hora exacta de caducidad fijando una ventana estricta de 2 horas según el reloj oficial del servidor.
7. **Persistencia Transaccional:** El sistema registra el nuevo cupón en la tabla `cupon` con estado `Emitido`, descontando atómicamente un cupo en la promoción (`cupos_restantes = cupos_restantes - 1`).
8. **Renderizado de Billetera:** El sistema muestra en pantalla el código QR dinámico, el código alfanumérico visible y un temporizador regresivo de 2 horas en la sección "Mis Cupones".

### Flujos Alternativos:
* **FA-01: Usuario sin sesión iniciada al momento de la solicitud:**
  * En el paso 4, si el visitante no tiene sesión activa, el sistema guarda en memoria la intención de cupón y redirige a la pantalla de inicio de sesión o registro rápido.
  * Una vez autenticado exitosamente mediante JWT, el sistema retoma automáticamente el flujo en el paso 5 sin que el visitante deba buscar nuevamente la oferta.
* **FA-02: Acceso mediante filtro de presupuesto (`«extend» CU02`):**
  * En el paso 1, el visitante llega a la promoción tras haber ingresado un monto monetario en el filtro interactivo (ej. $15.000 COP); el sistema resalta el cupón que optimiza su presupuesto.

### Flujos de Excepción (Manejo de Errores):
* **EX-01: Cupos agotados concurrentemente por otro usuario:**
  * Si en el paso 5, durante la concurrencia, otro usuario toma el último cupo disponible (`cupos_restantes = 0`), el sistema aborta la transacción, actualiza la promoción a estado `Agotada` y notifica al usuario: *"Lo sentimos, los cupos para esta oferta acaban de agotarse. Te invitamos a explorar otras promociones de la plazoleta"*.
* **EX-02: Límite diario alcanzado por el usuario (Regla RN-01):**
  * Si en el paso 5 se detecta que el usuario ya emitió un cupón hoy para ese comercio, el sistema detiene la emisión y muestra una alerta informativa: *"Ya has reclamado tu cupón diario para este restaurante. Podrás solicitar uno nuevo mañana a partir de las 8:00 a. m."*.
* **EX-03: Falla de conectividad de red durante la persistencia:**
  * Si en el paso 7 la conexión móvil se interrumpe antes de recibir la confirmación, el sistema ejecuta un rollback y presenta el botón *"Reintentar solicitud"* sin penalizar el límite del usuario.

### Postcondiciones:
* **Postcondición de Éxito:** Se crea un registro en tabla `cupon` con estado `Emitido`, se decrementa el stock de cupos, el código QR queda disponible en la billetera del cliente y el reloj de 2 horas inicia su cuenta regresiva.
* **Postcondición de Fallo:** No se descuentan cupos, no se crea registro en la base de datos y el visitante permanece en la vista de la oferta con un mensaje claro del motivo.

---

## 3. Plantilla Extendida 2 · CU05: Gestionar Promociones del Local y Franjas Relámpago

| Campo | Especificación Formal del Caso de Uso |
| :--- | :--- |
| **Identificador y Nombre** | **CU05: Gestionar promociones del local** |
| **Actor Principal** | **Locatario / Administrador de Tienda** |
| **Actores Secundarios** | Servidor de Aplicaciones Nuvora / Base de Datos PostgreSQL |
| **Objetivo de Negocio** | Permitir al comerciante dar de alta, modificar, pausar y parametrizar ofertas con cupos limitados y franjas relámpago para dinamizar el consumo en horarios de baja afluencia. |
| **Tipo de Caso de Uso** | Administrativo / Comercial de Gestión |
| **Relaciones Asociadas** | `«extend»` desde **CU06 (Parametrizar franjas horarias relámpago)** |
| **Precondiciones** | 1. El locatario ha iniciado sesión con credenciales válidas y rol `Locatario`.<br>2. El establecimiento comercial se encuentra en estado `Activo` en el directorio de San Pedro Plaza.<br>3. El locatario tiene registrado al menos un producto en su menú. |

### Flujo Principal de Eventos (Camino Feliz):
1. **Acceso al Módulo:** El locatario ingresa a su panel administrativo y pulsa en *"Crear Nueva Promoción"*.
2. **Formulario de Parámetros:** El sistema presenta el formulario de configuración solicitando: título comercial, producto base del menú, porcentaje de descuento o precio de oferta, fecha de inicio, fecha de fin y límite de cupos diarios.
3. **Selección de Producto y Precios:** El locatario selecciona el combo o plato gastronómico y digita el valor promocional.
4. **Activación de Franja Relámpago (`«extend» CU06`):** El locatario activa la opción *"Oferta Relámpago Horas Valle"* y parametriza los días de aplicación (ej. martes a jueves) y el intervalo de horas valle (ej. 2:30 p.m. a 5:30 p.m.).
5. **Validación de Reglas de Negocio:** El sistema valida que el precio de oferta sea estrictamente menor al precio regular (Regla RN-02) y que las horas relámpago se encuentren dentro del horario habilitado de la plazoleta (10:00 a.m. a 9:00 p.m., Regla RN-03).
6. **Fijación de Cupos y Stock:** El locatario asigna el cupo máximo por jornada (ej. 25 cupones diarios).
7. **Confirmación y Publicación:** El locatario presiona *"Publicar Promoción"*.
8. **Persistencia e Indexación:** El sistema almacena la oferta en la tabla `promocion` y las restricciones horarias en `franja_horaria`, dejándola en estado `Activa` y actualizando en tiempo real el directorio público de Nuvora.

### Flujos Alternativos:
* **FA-01: Guardado en modo Borrador:**
  * En el paso 7, el locatario decide no publicar de inmediato y selecciona *"Guardar como Borrador"*. El sistema persiste la configuración en estado `Borrador` sin hacerla visible para los visitantes.
* **FA-02: Promoción estándar sin franja relámpago:**
  * En el paso 4, el locatario omite la configuración horaria; el sistema establece la promoción como de validez continua durante todos los días del rango de fechas fijado.

### Flujos de Excepción (Manejo de Errores):
* **EX-01: Inconsistencia financiera en el valor de la oferta:**
  * Si en el paso 5 el precio promocional ingresado es igual o superior al precio original del producto, el sistema bloquea el guardado, resalta el campo numérico y muestra: *"El precio promocional ($COP) debe ser inferior al precio regular registrado en el menú"*.
* **EX-02: Solapamiento de franjas horarias relámpago:**
  * Si en el paso 5 el sistema detecta que el locatario ya tiene otra oferta activa para el mismo producto en el mismo rango horario, el sistema notifica: *"Ya existe una oferta relámpago programada para este producto en ese horario. Debe modificar la franja o pausar la anterior"*.
* **EX-03: Incoherencia en fechas de vigencia:**
  * Si la fecha de finalización es anterior a la fecha de inicio, el sistema muestra: *"La fecha de expiración debe ser posterior a la fecha de inicio de la promoción"*.

### Postcondiciones:
* **Postcondición de Éxito:** Se crea el registro en `promocion` en estado `Activa` con sus franjas vinculadas, visible en el catálogo de San Pedro Plaza durante los horarios permitidos.
* **Postcondición de Fallo:** No se publican cambios en el catálogo público y los datos permanecen en el formulario para corrección del usuario.

---

## 4. Plantilla Extendida 3 · CU07: Canjear Cupón de Descuento en Caja

| Campo | Especificación Formal del Caso de Uso |
| :--- | :--- |
| **Identificador y Nombre** | **CU07: Canjear cupón de descuento en caja** |
| **Actor Principal** | **Cajero / Validador en Punto de Venta** |
| **Actores Secundarios** | Cliente / Consumidor (Portador) · Motor Transaccional PostgreSQL |
| **Objetivo de Negocio** | Validar la autenticidad, vigencia y unicidad de un cupón presentado por el cliente en el mostrador del restaurante, aplicando el descuento en menos de 1.5 segundos e impidiendo el doble canje fraudulento (Regla RN-04). |
| **Tipo de Caso de Uso** | Crítico / Operativo de Redención Inmediata |
| **Relaciones Asociadas** | `«include»` a **CU08 (Verificar código QR criptográfico)**<br>`«extend»` desde **CU09 (Digitar código de cupón manualmente)** |
| **Precondiciones** | 1. El cajero ha iniciado sesión en el módulo operativo de caja de su restaurante.<br>2. El dispositivo de caja cuenta con cámara funcional o teclado numérico habilitado.<br>3. El cliente presenta en su celular el código QR generado en Nuvora. |

### Flujo Principal de Eventos (Camino Feliz):
1. **Activación de Escaneo:** El cajero pulsa el botón *"Escanear Cupón"* en la interfaz rápida de punto de venta.
2. **Lectura Óptica:** El cajero apunta la cámara del dispositivo hacia el código QR exhibido en el celular del cliente.
3. **Captura y Decodificación:** El sistema procesa la imagen, decodifica el código QR y extrae el identificador criptográfico (`codigo_alfa`).
4. **Validación Transaccional (`«include» CU08`):** El sistema despacha una solicitud atómica HTTPS al servidor ejecutando `CU08`.
5. **Verificación de Reglas en Servidor (Tiempo < 1.5 s):** El servidor ejecuta una transacción ACID con bloqueo de fila (`SELECT ... FOR UPDATE`) y comprueba simultáneamente:
   - Que el código exista en la tabla `cupon`.
   - Que el cupón pertenezca al `id_local` asignado al cajero en sesión.
   - Que el estado actual del cupón sea estrictamente `Emitido`.
   - Que la hora oficial del servidor no supere las 2 horas de vigencia desde su emisión (Regla RN-05).
   - Que si la oferta es relámpago, la hora oficial del servidor coincida con la franja habilitada.
6. **Marcado Atómico de Canje (Regla RN-04):** Al superar todas las validaciones, el servidor actualiza inmediatamente el estado del cupón a `Redimido` y fija el timestamp de canje.
7. **Registro Inmutable de Auditoría:** El sistema inserta un registro en la tabla `bitacora_canje` con: `id_cupon`, `id_cajero`, `timestamp_canje`, `ip_origen` y `monto_descuento`.
8. **Respuesta Visual y Cierre:** La pantalla del cajero emite un sonido de confirmación y despliega una tarjeta visual verde con los datos del pedido: nombre del plato, porcentaje de descuento y valor final a cobrar en caja física.

### Flujos Alternativos:
* **FA-01: Digitación manual de contingencia (`«extend» CU09`):**
  * En el paso 2, si la cámara del cajero no enfoca o la pantalla del cliente presenta brillo insuficiente o roturas, el cajero pulsa *"Ingreso Manual"* (`CU09`).
  * El cajero tipea los 8 caracteres alfanuméricos mediante el teclado táctil de caja y presiona *"Validar"*, continuando directamente en el paso 4.

### Flujos de Excepción (Manejo de Errores y Antifraude):
* **EX-01: Cupón ya redimido previamente (Doble canje / Fraude con captura de pantalla):**
  * Si en el paso 5 el servidor detecta que el cupón está en estado `Redimido`, bloquea la operación y muestra una alerta roja parpadeante: *"ALERTA DE SEGURIDAD: Este cupón ya fue canjeado hoy a las [Hora] en este restaurante. No aplique el descuento"*. Se registra la alerta en auditoría.
* **EX-02: Cupón vencido por expiración de tiempo (Límite de 2 horas superado):**
  * Si en el paso 5 la hora del servidor supera los 120 minutos desde la emisión, el sistema marca el cupón como `Vencido` y muestra un aviso ámbar: *"Cupón caducado. El tiempo límite de 2 horas para redimir esta promoción ha expirado"*.
* **EX-03: Cupón perteneciente a otro restaurante de la plazoleta:**
  * Si en el paso 5 el código corresponde a un restaurante diferente (ej. cupón de *El Corralito* presentado en *Delicias del Huila*), el sistema alerta en amarillo: *"Cupón no válido en este establecimiento. Esta promoción pertenece a [Nombre del Otro Local]"*.
* **EX-04: Cupón fuera de franja horaria relámpago:**
  * Si el cupón corresponde a una oferta relámpago pero la hora de redención no coincide con la ventana autorizada (ej. 2:30 p.m. a 5:30 p.m.), el sistema rechaza: *"Oferta relámpago inactiva en este horario"*.

### Postcondiciones:
* **Postcondición de Éxito:** El cupón queda marcado irreversiblemente como `Redimido`, el registro de auditoría queda sellado, el cajero aplica el descuento en la factura física y la pantalla del cliente se actualiza a "Cupón Canjeado".
* **Postcondición de Fallo:** El cupón mantiene su estado (o pasa a `Vencido`), no se otorga descuento comercial y el incidente queda registrado en la bitácora técnica.


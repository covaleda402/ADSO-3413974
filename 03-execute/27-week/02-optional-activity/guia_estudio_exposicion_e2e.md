# Guía Pedagógica de Estudio y Sustentación: Pruebas E2E y Arquitectura del Sistema

**Programa:** Análisis y Desarrollo de Software (ADSO)  
**Ficha:** 3413974 - Centro de Formación SENA  
**Aprendiz / Ponente:** Jose Esneider Covaleda Hortua  
**Proyecto:** Sistema Integral de Control de Asistencia y Gestión Biométrica SENA  
**Uso de este Documento:** Material de estudio personal, guía conceptual y libreto de exposición para sustentar ante instructores y evaluadores.

---

## 1. Contexto Institucional: ¿Qué problema resuelve este sistema?

En los centros de formación del SENA, el control de asistencia tradicional presenta debilidades críticas:
1. **Llamadas a lista manuales o firmas en hojas de papel:** Consumen entre 15 y 20 minutos de clase, son vulnerables a firmas falsificadas y carecen de trazabilidad digital inmediata.
2. **Códigos QR estáticos tradicionales:** Si un instructor proyecta un código QR estático o envía un enlace, un aprendiz puede tomarle una foto con el celular, enviarla por WhatsApp a un compañero ausente y este puede registrar asistencia desde su casa.
3. **Suplantación de identidad:** Un compañero puede ingresar el número de documento de otro para marcarle asistencia.
4. **Descontrol en el trámite de excusas médicas:** Las incapacidades físicas se entregan días después, se traspapelan, o dos instructores distintos toman decisiones contradictorias sobre una misma ausencia.

### La Solución Tecnológica Desarrollada
Un **Monolito Modular** de alta confiabilidad construido con **Next.js 14**, **TypeScript** y **PostgreSQL** que combina cuatro barreras de seguridad simultáneas:
1. **Verificación Facial Biométrica 128D** en el navegador del aprendiz ($< 200\text{ ms}$).
2. **Códigos QR Dinámicos Rotativos** mediante criptografía HMAC-SHA256 (cambian cada 30 segundos).
3. **Geocercas GPS** calculadas con la fórmula de Haversine para garantizar que el aprendiz esté físicamente en el aula.
4. **Flujo de Excusas con Bloqueo Concurrente Optimista** (evita decisiones contradictorias simultáneas).

---

## 2. Arquitectura de Software: Monolito Modular en Capas

El software adopta el patrón de **Monolito Modular con Gobernanza Estricta**. Esto significa que todo el sistema reside en una sola base de código para facilitar su despliegue y mantenimiento, pero internamente está desacoplado en capas con responsabilidades bien delimitadas:

```
┌─────────────────────────────────────────────────────────────┐
│ 1. CAPA DE PRESENTACIÓN & CONTROLADORES (Next.js App Router)│
│    Rutas de UI (/login, /instructor, /aprendiz) y Route     │
│    Handlers (/api/*). Controladores delgados sin lógica.    │
└──────────────────────────────┬──────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────┐
│ 2. CAPA DE DOMINIO & VALIDACIÓN (Zod Schemas + TypeScript)  │
│    Reglas de tipado, invariantes y validación de datos      │
│    (LoginSchema, AttendanceRegisterSchema, ExcuseSchema).   │
└──────────────────────────────┬──────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────┐
│ 3. CAPA DE SERVICIOS (Lógica de Negocio Pura)               │
│    AuthService, BiometricService, SessionService,           │
│    AttendanceService, ExcuseService.                        │
└──────────────────────────────┬──────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────┐
│ 4. CAPA DE REPOSITORIOS (Acceso a Datos)                    │
│    UserRepository, FichaRepository, AttendanceRepository,    │
│    ExcuseRepository, AuditRepository. Consultas SQL puras.  │
└──────────────────────────────┬──────────────────────────────┘
                               │
┌──────────────────────────────▼──────────────────────────────┐
│ 5. BASE DE DATOS RELACIONAL (PostgreSQL Serverless - Neon)  │
│    Esquema relacional en Tercera Forma Normal (3FN),       │
│    transacciones ACID y claves foráneas en cascada.         │
└─────────────────────────────────────────────────────────────┘
```

### ¿Por qué esta arquitectura es superior para el SENA?
- **Separación de responsabilidades:** Si mañana se cambia el motor de base de datos o el frontend, la lógica de negocio alojada en los *Servicios* no sufre modificaciones.
- **Mantenibilidad:** Cada desarrollador del equipo sabe exactamente dónde buscar un error (si falla una consulta SQL, se revisa el repositorio; si falla una regla de negocio, se revisa el servicio).
- **Seguridad:** Los controladores jamás ejecutan consultas SQL directamente; todo pasa por validación de esquemas Zod antes de tocar la lógica del sistema.

---

## 3. Los 4 Pilares de Seguridad e Innovación Técnica

### Pilar 1: Verificación Facial Biométrica 128D en el Cliente
- **¿Cómo funciona?** Cuando el aprendiz activa la cámara de su teléfono o portátil, la librería `@vladmandic/face-api` (basada en redes neuronales convolucionales ligeras con WebAssembly/WebGL) detecta los puntos de referencia faciales (*landmarks*) y genera un **vector de incrustación de 128 dimensiones** (`Float64Array`).
- **¿Por qué en el cliente y no en el servidor?** Enviar fotos de alta resolución al servidor colapsaría el ancho de banda y la memoria RAM del servidor ante 30 aprendices escaneando a la vez. Al procesar la red neuronal en el cliente, el navegador solo envía al servidor 128 números decimales (un payload minúsculo de apenas $\approx 1\text{ KB}$).
- **Algoritmo de Coincidencia (Distancia Euclidiana):**  
  El servidor compara el vector candidato $A$ contra el vector registrado en la matrícula $B$ usando la fórmula euclidiana en espacio de 128 dimensiones:
  
  $$d(A, B) = \sqrt{\sum_{i=1}^{128} (A_i - B_i)^2}$$

- **Umbral de Decisión:** Si $d(A, B) \le 0.55$, el sistema considera que es la misma persona. Si $d > 0.55$, se rechaza por discrepancia biométrica (intento de suplantación).
- **Tiempo de Ejecución:** La comparación matemática vectorial toma menos de **5 milisegundos** en el servidor.

---

### Pilar 2: Códigos QR Dinámicos Rotativos (Anti-Fraude por WhatsApp)
- **Problema:** En los sistemas tradicionales, un estudiante en clase le toma una foto al QR y la envía por mensajería a quien está fuera del centro de formación.
- **Solución SENA:** El código QR proyectado en la pantalla no es estático; cambia cada **30 segundos** sin requerir recargar la página.
- **Mecanismo Criptográfico (HMAC-SHA256):**  
  Cada 30 segundos, el servidor y el cliente calculan una ventana temporal:
  
  $$\text{Slot} = \left\lfloor \frac{\text{Tiempo Actual en ms}}{30000} \right\rfloor$$
  
  El token rotativo se genera cifrando ese slot con el secreto único de la sesión del instructor:
  
  $$\text{Token Rotativo} = \text{HMAC-SHA256}(\text{SessionToken}, \text{"sena\_rotative\_slot:"} + \text{Slot})[0..32]$$

- **Tolerancia de Latencia (Jitter):** Para evitar que un aprendiz legítimo con internet móvil lento sea rechazado si el código rota justo cuando presiona el botón, el servidor admite tres ventanas temporales continuas: el slot actual ($0$), el inmediatamente anterior ($-1$) y el posterior ($+1$).
- **Comparación Segura contra Ataques de Tiempo:** Se usa `crypto.timingSafeEqual` para que un atacante no pueda adivinar el token midiendo los microsegundos que tarda la CPU en comparar cadenas de texto.

---

### Pilar 3: Geocercas GPS con la Fórmula de Haversine
- **Problema:** Un aprendiz podría tener la foto del QR y su propio rostro, pero estar fuera de la institución educativa.
- **Solución:** Cada Ambiente de Formación tiene una coordenada geográfica registrada (latitud y longitud) y un radio máximo permitido (por ejemplo, 100 metros para el Aula de Software).
- **Fórmula de Haversine:** Calcula la distancia exacta en metros entre el aprendiz $(\phi_1, \lambda_1)$ y el centro del aula $(\phi_2, \lambda_2)$ considerando la curvatura esférica de la Tierra (radio medio terrestre $R = 6.371.000\text{ m}$):

  $$a = \sin^2\left(\frac{\Delta\phi}{2}\right) + \cos(\phi_1)\cos(\phi_2)\sin^2\left(\frac{\Delta\lambda}{2}\right)$$
  $$c = 2 \cdot \text{atan2}\left(\sqrt{a}, \sqrt{1-a}\right)$$
  $$\text{Distancia} = R \cdot c$$

- Si la distancia es superior al radio asignado, el servidor rechaza la marcación con código `HTTP 403 Forbidden` (*Geocerca violada*).

---

### Pilar 4: Control de Concurrencia Optimista en Excusas (ADR-008)
- **Problema ("Lost Update" / Sobreescritura Ciega):** Imagine que un aprendiz radica una excusa médica. El Instructor Carlos y la Coordinadora Diana abren el sistema a las 8:00 AM para revisarla. Carlos decide *Aprobarla* a las 8:01 AM. Segundos después, Diana, que aún tenía la pantalla abierta sin recargar, hace clic en *Rechazar*. En una base de datos sin control concurrente, el rechazo de Diana sobreescribiría la aprobación de Carlos sin que nadie se entere.
- **Solución con Bloqueo Optimista:**  
  La tabla `excuse_requests` tiene una columna entera llamada `version` (inicia en `1`).
  Cuando se envía la resolución, la consulta SQL exige coincidencia exacta de versión:
  
  ```sql
  UPDATE excuse_requests
  SET status = 'approved',
      version = version + 1
  WHERE id = $1 AND version = $2 AND status = 'pending';
  ```
  
  - La primera persona que aprueba actualiza la fila e incrementa la versión a `2`.
  - Cuando la segunda persona intenta guardar enviando la `version: 1` que tenía en su pantalla, la condición `WHERE version = 1` no coincide con ninguna fila.
  - El servidor detecta cero filas afectadas y arroja un error `HTTP 409 Conflict`. El usuario desfasado es informado inmediatamente de que la excusa ya fue resuelta por otro directivo.

---

## 4. ¿Qué son las Pruebas End-to-End (E2E) y por qué son cruciales?

### La Pirámide de Pruebas de Software

```
            / \
           /   \        <- E2E (End-to-End) [48 Pruebas Realizadas]
          / E2E \          Valida flujos completos de principio a fin:
         /───────\         HTTP -> Rutas -> BD -> Cookies -> Cripto.
        /         \
       /Integración\    <- Pruebas de Integración
      /─────────────\      Valida que dos componentes hablen bien entre sí.
     /   Unitarias   \  <- Pruebas Unitarias
    /─────────────────\    Valida funciones matemáticas y aisladas en memoria.
```

- **Pruebas Unitarias:** Verifican funciones pequeñas de forma aislada (por ejemplo, que la función `calculateDistanceMeters` devuelva un número).
- **Pruebas E2E (Fin a Fin):** Levantan el servidor real, se conectan a la base de datos real, envían peticiones HTTP reales por la red, evalúan las cookies de sesión del navegador, validan la seguridad criptográfica y auditan los registros guardados en las tablas.
- **Importancia:** Una aplicación puede tener 100% de pruebas unitarias aprobadas y aun así fallar en producción si la cookie de sesión no viaja, si una migración SQL tiene una restricción rota o si el tiempo de respuesta agota el timeout de red. Las pruebas E2E son la garantía definitiva de que el sistema funciona para el usuario final.

---

## 5. Resumen de las 9 Suites de Pruebas Ejecutadas

| Suite | Área Evaluada | Casos Clave Probados | Resultado |
|---|---|---|---|
| **Suite 1** | Autenticación y RBAC | Login de Instructor, Login de Coordinador, Aceptación obligatoria de términos legales, Detección de documentos erróneos, Bloqueo de acceso no autorizado. | 8/8 PASS |
| **Suite 2** | Ciclo de Sesiones QR | Consulta de fichas y ambientes, Creación de sesión para Ficha 3413974, Regla de sesión única activa (bloqueo de duplicados). | 5/5 PASS |
| **Suite 3** | Onboarding Biométrico | Comprobación de identidad oficial, Consentimiento informado obligatorio, Enrolamiento de vector facial 128D, Consulta de estado biométrico. | 4/4 PASS |
| **Suite 4** | Verificación Facial y Asistencia | Lectura de QR, Rechazo de impostor con vector divergente, Aprobación de aprendiz legítimo ($< 0.05$), Violación de geocerca GPS ($> 100\text{ m}$), Prevención de marcación duplicada (409), Rechazo de token rotativo expirado/falso. | 7/7 PASS |
| **Suite 5** | QR Tardío y Cierre | Generación de late_qr, Marcación clasificada como `Tarde`, Cierre de sesión, **Generación automática de 28 faltas para los aprendices inasistentes**, Bloqueo de sesión cerrada. | 5/5 PASS |
| **Suite 6** | Roster y Novedades | Consulta de los 30 aprendices de la Ficha 3413974, Registro manual de tardanza justificada con nota médica. | 2/2 PASS |
| **Suite 7** | Excusas y Concurrencia | Radicación de excusa Unidía (PDF) hacia el instructor, Radicación Multidía (PNG) hacia coordinación, Bloqueo al instructor por falta de competencia, Aprobación con incremento de versión, **Detonación de conflicto 409 por bloqueo optimista**. | 6/6 PASS |
| **Suite 8** | Auditoría y Reportes | Historial de sesiones de instructor, Historial global de coordinación, Kardex personal del aprendiz, Comprobación de registros inmutables en `audit_events`. | 4/4 PASS |
| **Suite 9** | Interfaces de Usuario | Health Check HTTP 200 de todas las pantallas web (`/login`, `/scan`, `/aprendiz/acceso`, `/aprendiz/primera-vez`, Dashboards). | 7/7 PASS |

---

## 6. Guion de Sustentación para Jose Esneider (Paso a Paso)

Utiliza este guion cronometrado para realizar una exposición fluida y profesional (aproximadamente 8 a 10 minutos):

### Minuto 0 a 2: Introducción y Planteamiento del Problema
> *"Buenos días, estimados instructores y compañeros. Mi nombre es Jose Esneider Covaleda Hortua, aprendiz del programa de Análisis y Desarrollo de Software (ADSO), Ficha 3413974.*  
> *Hoy presento el Sistema Integral de Control de Asistencia y Gestión Biométrica para el SENA.*  
> *Actualmente, los controles de asistencia tradicionales en nuestras aulas presentan dos grandes vulnerabilidades: el fraude por suplantación y el traspaso de códigos QR por fotos de WhatsApp. Si un código QR no rota, cualquier aprendiz puede marcar asistencia desde su casa.*  
> *Para resolver esto, diseñamos un sistema basado en cuatro barreras de seguridad: biometría facial en el navegador, códigos QR rotativos cada 30 segundos mediante HMAC-SHA256, geocercas GPS por ambiente y un control de concurrencia optimista para el trámite de excusas."*

### Minuto 2 a 4: Arquitectura del Software y Tecnologías
> *"Arquitectónicamente, el sistema fue concebido bajo el estándar de **Monolito Modular** en Next.js 14 con TypeScript y PostgreSQL Serverless.*  
> *Separamos estrictamente la aplicación en cuatro capas:*
> 1. *Capa de Presentación: con controladores delgados que solo reciben la petición.*
> 2. *Capa de Dominio: con esquemas de validación Zod que impiden que entre basura al sistema.*
> 3. *Capa de Servicios: donde reside toda la lógica de negocio pura.*
> 4. *Capa de Repositorios: donde ejecutamos consultas SQL optimizadas en 3FN hacia la base de datos.*  
> *Esto garantiza que el sistema sea mantenible, testeable y altamente escalable."*

### Minuto 4 a 7: Demostración de las 4 Barreras de Seguridad y las Pruebas E2E
> *"Para garantizar que la aplicación no falle en un escenario real de producción con cientos de aprendices, no nos conformamos únicamente con pruebas visuales. Desarrollamos y ejecutamos una suite completa de **48 pruebas End-to-End (E2E)** automatizadas.*  
> *Permítanme destacar cuatro pruebas críticas que superó la suite con una tasa de éxito del 100%:*
> 1. *En la **Suite 4**, probamos el motor biométrico. Cuando simulamos un impostor con un vector facial divergente, el sistema calculó una distancia euclidiana superior a 0.55 y rechazó el acceso inmediatamente en menos de 200 milisegundos.*
> 2. *En esa misma suite, probamos la **Geocerca GPS**. Enviamos coordenadas fuera del aula de software y el algoritmo de Haversine bloqueó la marcación arrojando un error 403 de geocerca violada.*
> 3. *En la **Suite 5**, evaluamos la automatización del cierre de sesión. Al finalizar la clase, el backend detectó automáticamente que de los 30 aprendices de nuestra Ficha 3413974, dos habían asistido y generó de forma automática e idempotente los 28 registros de 'Falta' para los inasistentes.*
> 4. *En la **Suite 7**, demostramos el **Bloqueo Optimista**. Cuando simulamos que dos directivos intentaban actualizar una misma excusa con la versión desfasada, el sistema impidió la sobreescritura arrojando con precisión un código HTTP 409 Conflict."*

### Minuto 7 a 8: Conclusiones
> *"En conclusión, el Sistema de Asistencia SENA no es un prototipo visual superficial; es una solución de software robusta, blindada contra fraudes, con persistencia transaccional y validada exhaustivamente mediante pruebas de ingeniería.*  
> *Agradezco su atención y quedo a disposición para responder cualquier pregunta técnica."*

---

## 7. Preguntas Difíciles que pueden hacer los Instructores y Respuestas Modelo

### Pregunta 1: "¿Por qué prefirieron ejecutar la inferencia de reconocimiento facial en el cliente con Face-API en vez de subir las fotos a un servidor o una API en la nube?"
- **Respuesta Técnica:**  
  *"Por tres razones fundamentales de ingeniería: costo, latencia y privacidad. Si enviamos 30 o 40 fotos pesadas en alta resolución simultáneamente a un backend cada vez que inicia una clase, sobrecargaríamos el ancho de banda del centro de formación y colapsaríamos la memoria del servidor procesando redes neuronales convolucionales pesadas.  
  Al usar `@vladmandic/face-api` con aceleración WebGL/WebAssembly en el cliente, el dispositivo del aprendiz realiza el cómputo pesado y solo transmite al servidor un vector matemático de 128 números decimales (apenas $\approx 1\text{ KB}$). Además, protege la privacidad del aprendiz bajo la Ley 1581 de Habeas Data, ya que no estamos transmitiendo constantemente fotos por la red, sino descriptores numéricos normalizados."*

### Pregunta 2: "¿Qué pasa si un estudiante usa una aplicación de GPS falso ('Fake GPS') en su celular?"
- **Respuesta Técnica:**  
  *"Excelente pregunta. La geocerca GPS no es el único mecanismo de seguridad; es una capa de defensa en profundidad. Para que un intento de fraude tuviera éxito, el atacante tendría que vulnerar tres barreras simultáneas e independientes:  
  1. Tendría que suplantar el GPS.  
  2. Tendría que poseer el token rotativo HMAC-SHA256 que cambia cada 30 segundos en la pantalla del aula.  
  3. Tendría que poner físicamente su rostro frente a la cámara para superar la prueba euclidiana de 128 dimensiones contra el descriptor registrado en su matrícula.  
  Por lo tanto, incluso si falsificara el GPS, sin el rostro real frente al lente y sin el código dinámico del aula, el sistema deniega el registro."*

### Pregunta 3: "¿Cómo funciona exactamente el Bloqueo Optimista en PostgreSQL y por qué es mejor que un Bloqueo Pesimista (`SELECT FOR UPDATE`)?"
- **Respuesta Técnica:**  
  *"El Bloqueo Pesimista bloquea físicamente las filas de la base de datos con un cerrojo a nivel de tabla o registro (`FOR UPDATE`), lo que disminuye drásticamente la concurrencia y puede causar bloqueos mutuos (*Deadlocks*) si un usuario deja abierta una ventana sin presionar ningún botón.  
  El Bloqueo Optimista asume que los conflictos son poco frecuentes y no bloquea lecturas. Se basa en una columna `version INT`. Cuando el instructor carga la excusa, lee que está en `version: 1`. Al guardar la decisión, ejecuta un `UPDATE ... WHERE id = $1 AND version = 1`. Si la consulta actualiza 1 fila, todo fue bien y la versión sube a 2. Pero si alguien más ya la actualizó antes, la fila ya está en `version: 2`, por lo que el `UPDATE` afecta 0 filas. El código detecta esto y arroja de inmediato un `HTTP 409 Conflict`, obligando al segundo usuario a refrescar la vista sin perder datos."*

### Pregunta 4: "¿Por qué decidieron estructurar las pruebas en 9 suites E2E en lugar de limitarse a probar manualmente en el navegador?"
- **Respuesta Técnica:**  
  *"Las pruebas manuales son lentas, subjetivas, propensas al error humano y no garantizan que un cambio nuevo no rompa algo viejo (*regresión*). Ejecutar manualmente 48 escenarios complejos (simular fallos de geocerca, tokens vencidos, ataques concurrentes, validación de esquemas y comprobación de base de datos) tomaría más de tres horas por cada cambio de código.  
  Con nuestra suite automatizada en Node.js, las 48 pruebas se ejecutan de manera determinística en apenas 25 segundos, comprobando códigos HTTP, encabezados, cookies de autenticación, integridad en PostgreSQL y respuestas en tiempo real antes de desplegar a producción."*

# Prototipos y Mockups Iniciales · Sistema Nuvora

> **Centro Comercial San Pedro Plaza · Neiva, Huila**  
> **Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
> **Autor:** `covaleda402`  
> **Rúbrica de Evaluación:** `Rubricas_G1.md` · Sección 5.1 (Artefacto e) y Sección 5.2 (Criterio C5 - 10 Puntos)

---

## 1. Introducción y Alcance de la Interfaz

El presente documento especifica el diseño conceptual y los prototipos de interfaz de usuario (UI) para las **tres pantallas críticas** del ecosistema Nuvora, cubriendo el ciclo de vida completo de atracción, retención y redención de beneficios en la plazoleta de comidas del Centro Comercial San Pedro Plaza.

Cada pantalla atiende directamente a los casos de uso modelados en las plantillas extendidas (`01-plantillas-casos-de-uso.md`) y en los diagramas de actividades (`02-diagramas-actividades.drawio` / `.svg`), eliminando pantallas huérfanas y asegurando una trazabilidad del 100% con los requisitos del sistema.

---

## 2. Pantalla 1 (M-01) · Catálogo Gastronómico y Filtro por Presupuesto

- **Identificador de Pantalla:** `M-01_CATALOGO_PRESUPUESTO`
- **Casos de Uso Atendidos:** `CU01` (Consultar catálogo de locales y menús), `CU02` (Filtrar productos por presupuesto), `CU03` (Generar cupón digital de descuento).
- **Requisitos Satisfechos:** `RF-05`, `RF-06`, `RF-07`, `RF-08`, `RF-13`.
- **Actor Primario:** Visitante / Consumidor.
- **Dispositivo Objetivo:** Mobile Web Responsive (360px a 420px de ancho) / Terminal Autoservicio Kiosko.

### 2.1 Maqueta Visual (Wireframe UI)

```text
+-------------------------------------------------------------+
|  [=] NUVORA  San Pedro Plaza                    (2) [Perfil]|
+-------------------------------------------------------------+
|  ¿Cuánto deseas gastar hoy en tu almuerzo?                  |
|  [ $ 15.000 ]    [ $ 25.000 ]*    [ $ 35.000 ]    [ > $ 40k]|
+-------------------------------------------------------------+
|  Categorías:  ( Todos )*  ( Carnes )  ( Típica )  ( Postres )|
|  [ Buscar local o plato...                             (Q) ]|
+-------------------------------------------------------------+
|  OFERTAS DISPONIBLES EN TU RANGO ($ 20.000 - $ 25.000 COP)  |
|                                                             |
|  +-------------------------------------------------------+  |
|  | [IMAGEN: Bandeja Paisa Especial]                      |  |
|  | DON JEDIONDO GOURMET · Local 214 · Plazoleta Sur      |  |
|  | Plato: Bandeja Paisa + Bebida Natural 16 oz           |  |
|  | Precio Habitual: $ 30.000 COP                         |  |
|  | Precio con Cupón: $ 22.500 COP  [-25% OFF]            |  |
|  | Stock restante hoy: [ 14 cupones disponibles ]        |  |
|  | Horario válido: Lun-Vie 11:30 am a 3:30 pm            |  |
|  |                                                       |  |
|  | [   OBTENER CUPÓN DIGITAL (-25%)   ]                  |  |
|  +-------------------------------------------------------+  |
|                                                             |
|  +-------------------------------------------------------+  |
|  | [IMAGEN: Combo Hamburguesa Artesanal Doble]           |  |
|  | RÚSTICA BURGER · Local 208 · Zona Central             |  |
|  | Plato: Combo Rústico Doble Carne + Papas Caseras      |  |
|  | Precio Habitual: $ 28.000 COP                         |  |
|  | Precio con Cupón: $ 23.800 COP  [-15% OFF]            |  |
|  | Stock restante hoy: [ 8 cupones disponibles ]         |  |
|  | Horario válido: Todos los días 12:00 m a 8:00 pm      |  |
|  |                                                       |  |
|  | [   OBTENER CUPÓN DIGITAL (-15%)   ]                  |  |
|  +-------------------------------------------------------+  |
+-------------------------------------------------------------+
|  [Inicio]          [Explorar]        [(2) Mis Cupones]      |
+-------------------------------------------------------------+
```

### 2.2 Especificación de Componentes e Interacción

1. **Selector de Rango Presupuestal:** Chips interactivos de un solo toque que filtran en tiempo real los menús de los locales sin recargar la página (consulta dinámica en vivo).
2. **Tarjeta de Promoción:** Muestra información clara sin ambigüedades: nombre comercial, local físico, ahorro monetario exacto en pesos colombianos (`COP`), stock en tiempo real y franja horaria aplicable.
3. **Disparador de Caso de Uso (`CU03`):** Al presionar el botón `[ OBTENER CUPÓN DIGITAL ]`, el sistema valida si el visitante tiene sesión iniciada (Flujo Alterno `FA-01`, `CU04`) y si cumple el límite diario de la promoción (Excepción `EX-02`, `RN-01`).

---

## 3. Pantalla 2 (M-02) · Billetera Digital de Cupones Activos

- **Identificador de Pantalla:** `M-02_BILLETERA_CUPONES`
- **Casos de Uso Atendidos:** `CU03` (Generar cupón digital de descuento), `CU04` (Autenticar usuario en la plataforma).
- **Requisitos Satisfechos:** `RF-13`, `RF-14`, `RF-15`.
- **Actor Primario:** Visitante / Consumidor.
- **Dispositivo Objetivo:** Mobile Web / Smartphone del Cliente.

### 3.1 Maqueta Visual (Wireframe UI)

```text
+-------------------------------------------------------------+
|  [<- Volver]         MIS CUPONES NUVORA         [Ayuda (?)]  |
+-------------------------------------------------------------+
|  Estado de Billetera: [ 2 de 3 cupones activos en uso ]     |
+-------------------------------------------------------------+
|                                                             |
|  +=======================================================+  |
|  | CUPÓN VIGENTE · VALIDEZ EN CAJA                       |  |
|  | Don Jediondo Gourmet - Local 214                      |  |
|  | 25% OFF en Bandeja Paisa Especial                     |  |
|  |-------------------------------------------------------|  |
|  |                                                       |  |
|  |                 +-------------------+                 |  |
|  |                 | # # # # # # # # # |                 |  |
|  |                 | #   #   #   #   # |  <- QR Dinámico |  |
|  |                 | # #   # # #   # # |     Firmado     |  |
|  |                 | #   #   #   #   # |     HMAC-SHA256 |  |
|  |                 | # # # # # # # # # |                 |  |
|  |                 +-------------------+                 |  |
|  |                                                       |  |
|  |          Código de Respaldo: [ NUV-8K42 ]             |  |
|  |      (Presentar si la pantalla no puede leerse)       |  |
|  |                                                       |  |
|  |  [!] TIEMPO RESTANTE PARA CANJEAR:                    |  |
|  |  +-------------------------------------------------+  |
|  |  |   [RELOJ]  01 h : 42 min : 18 seg               |  |
|  |  +-------------------------------------------------+  |
|  |  Vence hoy a las: 02:15 PM · San Pedro Plaza          |  |
|  |-------------------------------------------------------|  |
|  |  Condiciones: Válido únicamente consumiendo en mesa   |  |
|  |  o para llevar en el local emisor. No acumulable.     |  |
|  |                                                       |  |
|  |  [ Ver Cómo Llegar al Local 214 en el Mapa ]          |  |
|  +=======================================================+  |
|                                                             |
|  +-------------------------------------------------------+  |
|  | Cupón 2: El Corral · 10% en Vaquero Mediano           |  |
|  | Vence en: 00 h : 22 min : 05 seg  [Ver QR]            |  |
|  +-------------------------------------------------------+  |
+-------------------------------------------------------------+
|  [Inicio]          [Explorar]        [(2) Mis Cupones]*     |
+-------------------------------------------------------------+
```

### 3.2 Especificación de Componentes e Interacción

1. **Código QR Dinámico:** Matriz bidimensional que contiene un token cifrado temporal con verificación criptográfica. Se refresca en segundo plano para evitar capturas de pantalla estáticas compartidas fraudulentamente.
2. **Código Alfanumérico de Respaldo (`NUV-8K42`):** Elemento clave para garantizar la continuidad operativa cuando el lente óptico del cajero sufra averías o el brillo del teléfono del usuario impida el escaneo (atiende directamente el **Flujo Alterno FA-01 / CU09**).
3. **Temporizador Regresivo de 2 Horas:** Contador descendente en pantalla sincronizado con el reloj oficial del sistema. Al llegar a `00:00:00`, el cupón conmuta automáticamente a estado `EXPIRADO` (Regla `RN-02`).

---

## 4. Pantalla 3 (M-03) · Terminal de Validación POS en Caja

- **Identificador de Pantalla:** `M-03_TERMINAL_POS_CAJA`
- **Casos de Uso Atendidos:** `CU07` (Canjear cupón de descuento en caja), `CU08` (Verificar código QR criptográfico), `CU09` (Digitar código de cupón manualmente).
- **Requisitos Satisfechos:** `RF-16`, `RF-17`, `RF-18`, `RF-20`.
- **Actor Primario:** Locatario / Cajero del Punto de Venta.
- **Dispositivo Objetivo:** Tablet de Caja / PC de Mostrador con Escáner Óptico o Cámara Web (Resolución mínima 1024x768).

### 4.1 Maqueta Visual (Wireframe UI - Escenario Canje Exitoso)

```text
+---------------------------------------------------------------------------------+
|  NUVORA POS v1.0 · COMERCIO: DON JEDIONDO (LOCAL 214) · CAJERO: OPERADOR POS 01 |
+---------------------------------------------------------------------------------+
|  ESTACIÓN DE CANJE Y LECTURA                                                    |
|                                                                                 |
|  [ ÁREA DE LECTURA DE CÁMARA / ESCÁNER ÓPTICO ]                                |
|  +----------------------------------------+  Entrada Manual (FA-01 / CU09):    |
|  |      /--------------------------\      |  [ NUV-8K42              ] [BUSCAR] |
|  |      |   ESCANEANDO CÓDIGO QR   |      |                                     |
|  |      |    [===== LÁSER =====]   |      |  Estado Lector: CONECTADO (ÓPTICO)  |
|  |      \--------------------------/      |                                     |
|  +----------------------------------------+                                     |
|                                                                                 |
|  RESULTADO DE VALIDACIÓN TRANSACCIONAL EN TIEMPO REAL:                          |
|  +===========================================================================+  |
|  | [OK] CUPÓN VÁLIDO Y ACTIVO · TRANSACCIÓN AUTORIZADA                       |  |
|  |---------------------------------------------------------------------------|  |
|  | Beneficiario:   Visitante Demo (@visitante_sp)                           |  |
|  | Promoción:      25% Descuento Almuerzo Ejecutivo (Bandeja Paisa)          |  |
|  | Código Cupón:   NUV-8K42                                                  |  |
|  | Tiempo Emisión: Generado hace 18 minutos (Vence en 01:42:00)              |  |
|  |---------------------------------------------------------------------------|  |
|  | Subtotal Cuenta Comercial:       $ 30.000 COP                             |  |
|  | Descuento Nuvora (25%):        - $  7.500 COP                             |  |
|  | TOTAL FINAL A COBRAR EN CAJA:    $ 22.500 COP                             |  |
|  |                                                                           |  |
|  | [   APLICAR DESCUENTO Y FINALIZAR CANJE (ENTER)   ]     [ CANCELAR (ESC) ]|  |
|  +===========================================================================+  |
+---------------------------------------------------------------------------------+
|  Resumen del Turno: 24 Canjes Aplicados Hoy · Total Descontado: $ 182.000 COP   |
+---------------------------------------------------------------------------------+
```

### 4.2 Maqueta Visual (Alerta de Excepción EX-01 - Intento de Re-Canje o Fraude)

```text
+---------------------------------------------------------------------------------+
|  [!] ALERTA DE SEGURIDAD NUVORA POS · RECHAZO DE TRANSACCIÓN                    |
|  +===========================================================================+  |
|  | [X] ERROR: ESTE CUPÓN YA FUE CANJEADO PREVIAMENTE                         |  |
|  |---------------------------------------------------------------------------|  |
|  | Código Ingresado:   NUV-8K42                                              |  |
|  | Estado en Sistema:  CANJEADO (Invalido para nuevo uso)                    |  |
|  | Fecha Canje Original: 25/Nov/2026 a las 12:31:05 PM                       |  |
|  | Validado en Caja:   Caja Principal # 1 (Local 214)                        |  |
|  |                                                                           |  |
|  | MOTIVO DEL RECHAZO:                                                       |  |
|  | Se evitó un intento de doble descuento mediante bloqueo atómico en BD.    |  |
|  | No aplique el descuento en la factura física del cliente.                 |  |
|  |                                                                           |  |
|  |                  [ ENTENDIDO / REGRESAR AL ESCÁNER ]                      |  |
|  +===========================================================================+  |
+---------------------------------------------------------------------------------+
```

### 4.3 Especificación de Componentes e Interacción

1. **Visor de Escaneo Híbrido:** Permite captura directa por cámara web, escáner láser USB tipo pistola o digitalización manual de los 8 caracteres.
2. **Panel de Liquidación Financiera:** Calcula automáticamente la deducción porcentual sobre el subtotal bruto y estampa el valor neto exacto que el cajero debe cobrar en efectivo o datáfono.
3. **Mecanismo de Prevención de Fraude:** Al pulsar `[ APLICAR DESCUENTO Y FINALIZAR CANJE ]`, el sistema ejecuta una validación exclusiva atómica contra doble canje. Si detecta que el estado ya es `CANJEADO`, aborta la operación, registra el incidente de auditoría y despliega la alerta en color rojo (Excepción `EX-01`).

---

## 5. Matriz de Coherencia: Pantallas vs. Casos de Uso y Requisitos

| Código Pantalla | Nombre de Pantalla | Caso de Uso Atendido | Requisitos Satisfechos | Rol de Usuario |
|---|---|---|---|---|
| `M-01` | Catálogo por Presupuesto | `CU01`, `CU02`, `CU03` | `RF-05`, `RF-06`, `RF-07`, `RF-08`, `RF-13` | Visitante / Consumidor |
| `M-02` | Billetera Digital con QR | `CU03`, `CU04` | `RF-13`, `RF-14`, `RF-15` | Visitante / Consumidor |
| `M-03` | Terminal de Validación POS | `CU07`, `CU08`, `CU09` | `RF-16`, `RF-17`, `RF-18`, `RF-20` | Locatario / Cajero |

---

## 6. Conclusiones y Cumplimiento de Criterios

- **Cero Pantallas Huérfanas:** Cada una de las 3 interfaces responde a eventos y flujos de negocio modelados previamente en los diagramas de actividades.
- **Rótulo Explícito:** Cada interfaz cuenta con su identificador, caso de uso y descripción funcional en el encabezado.
- **Soporte a Contingencias Reales:** La pantalla de caja contempla tanto la lectura óptica ideal como la digitación manual y la detección inmediata de duplicidad o vencimiento.


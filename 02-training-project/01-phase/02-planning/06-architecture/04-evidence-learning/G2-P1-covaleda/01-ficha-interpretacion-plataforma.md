# Ficha de Interpretación del Análisis y Plataforma Tecnológica (A1)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Ubicación de Implementación:** Plazoleta de Comidas · Centro Comercial San Pedro Plaza (Neiva, Huila)  
**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro de Formación:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** Jose Esneider Covaleda Hortua (`covaleda402`)  
**Fase del Proyecto:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593103 (Criterio C1)  
**Ruta de Entrega:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-covaleda/`  
**Normativa y Evaluación:** `Rubricas_G2.md` (Sección 2.1 y Sección 2.2 · Nivel 100)

---

## 1. Contexto Operativo y Problema de Negocio

El Centro Comercial San Pedro Plaza en Neiva (Huila) cuenta con una plazoleta gastronómica de más de 25 establecimientos comerciales y un flujo peatonal que supera los 12.000 visitantes durante los fines de semana. El análisis evidenció:
1. **Picos de congestión y asimetría horaria:** Saturación extrema entre las 12:30 p. m. y 1:45 p. m., con capacidad ociosa en horas valle (2:00 p. m. a 5:30 p. m.).
2. **Fricción por presupuesto:** Visitantes recorriendo locales sin saber qué ofertas se ajustan a su capacidad económica en pesos colombianos (`COP`).
3. **Fraude en cupones estáticos:** Pérdidas económicas por reutilización indebida de capturas de pantalla de WhatsApp.

**Solución de Diseño:** Una arquitectura de software desacoplada, orientada a objetos y de alta concurrencia, que ofrece un catálogo digital filtrable por presupuesto, emisión de cupones efímeros con QR dinámico firmado criptográficamente (HMAC-SHA256, validez de 2 horas) y una terminal de canje POS en caja con verificación transaccional atómica ACID (`SELECT ... FOR UPDATE`).

---

## 2. Requisitos Seleccionados del Sistema (SRS Nuvora)

### 2.1 Requisitos Funcionales Críticos (≥ 8 Requisitos con ID)

| ID Requisito | Denominación del Requisito Funcional | Descripción Operativa y Regla de Negocio Asociada | Actor Primario |
|:---:|---|---|:---:|
| **RF-01** | Autenticación y Control de Acceso por Roles (RBAC) | El sistema autentica usuarios mediante credenciales seguras y expide tokens JWT efímeros tipados por rol (`Visitante`, `Locatario`, `Administrador`). | Todos |
| **RF-03** | Gestión de Perfil y Preferencias Gastronómicas | Permite al visitante parametrizar sus gustos culinarios y canales de notificación para ofertas personalizadas. | Visitante |
| **RF-04** | Directorio y Catálogo Gastronómico de Locales | Despliega los comercios activos categorizados por tipo de comida, horarios y menús vigentes. | Visitante |
| **RF-07** | Motor de Filtrado por Rango de Presupuesto (`COP`) | Calcula y filtra combinaciones de platos y promociones cuyo valor total sea menor o igual al presupuesto ingresado. | Visitante |
| **RF-09** | Creación y Parametrización de Ofertas y Promociones | Permite al locatario publicar campañas con porcentaje de descuento, fechas de vigencia y stock máximo asignado. | Locatario |
| **RF-10** | Restricción de Promociones por Franjas Horarias | Asocia a cada promoción ventanas horarias válidas (días de semana y horas valle), bloqueando emisiones fuera de franja. | Locatario |
| **RF-13** | Emisión de Cupón Digital con Token QR Dinámico | Genera una instancia única de cupón con código alfanumérico (8 caracteres) y QR firmado criptográficamente con validez estricta de 2 horas. | Visitante |
| **RF-14** | Control de Límite Diario de Cupones por Usuario | Restringe la emisión a un máximo de 3 cupones activos simultáneos o 1 cupón diario por local (Regla RN-01). | Sistema |
| **RF-16** | Validación y Canje Atómico en Terminal POS | Permite al cajero escanear el QR o digitar el código alfanumérico, validando vigencia, pertenencia al local y estado activo. | Locatario / Cajero |
| **RF-17** | Bloqueo de Concurrencia y Prevención de Doble Canje | Ejecuta una transacción atómica con bloqueo a nivel de fila (`SELECT ... FOR UPDATE`) impidiendo que un cupón sea canjeado dos veces en milisegundos. | Sistema |
| **RF-18** | Bitácora Inmutable de Auditoría de Redenciones | Registra cada intento de canje (exitoso o rechazado) con fecha, hora, IP, terminal POS, monto descontado y hash transaccional. | Sistema |
| **RF-20** | Tablero de Analítica Comercial y Tasa de Redención | Consolida métricas de cupones emitidos vs redimidos, horarios de mayor afluencia y efectividad de campañas. | Administrador |

### 2.2 Requisitos No Funcionales (≥ 3 Requisitos con Métrica Objetiva)

| ID Requisito | Característica ISO/IEC 25010 | Descripción Técnica y Métrica Verificable |
|:---:|---|---|
| **RNF-01** | **Rendimiento y Tiempo de Respuesta** | La validación del cupón y confirmación transaccional en la terminal POS en caja debe responder en un **tiempo $\le 1.5$ segundos** bajo una carga concurrente de hasta 150 transacciones por minuto en hora pico de almuerzo. |
| **RNF-02** | **Seguridad y Criptografía** | Las contraseñas deben ser dispersadas mediante algoritmo **bcrypt (factor de costo $\ge 12$)** con sal única. Las comunicaciones cliente-servidor deben viajar cifradas exclusivamente sobre **TLS 1.3 (HTTPS / WSS)**. El token QR debe sellarse con firma **HMAC-SHA256**. |
| **RNF-03** | **Disponibilidad y Concurrencia ACID** | El backend debe garantizar una disponibilidad de servicio de **$\ge 99.5\%$** en el horario operativo del centro comercial (10:00 a. m. a 10:00 p. m.), con aislamiento transaccional estricto *Read Committed* y bloqueo pesimista de fila para asegurar cero inconsistencias contables. |
| **RNF-04** | **Usabilidad y Accesibilidad** | La interfaz web móvil (*PWA*) debe ser completamente responsiva (*Mobile-First*), operable a una sola mano, con contraste certificado **WCAG 2.1 AA** para visualización clara bajo la iluminación de la plazoleta y soporte de contingencia offline básica. |

---

## 3. Actores y Restricciones del Sistema

### 3.1 Actores del Sistema
1. **Visitante / Consumidor:** Usuario de la plazoleta que consulta el directorio, filtra por presupuesto, emite cupones digitales y los presenta en caja.
2. **Locatario / Cajero:** Personal comercial del local que configura promociones y opera la terminal POS web para validar y canjear cupones.
3. **Administrador del Centro Comercial:** Responsable de habilitar locales, auditar métricas globales y vigilar el cumplimiento de términos.
4. **Sistema Automatizado Nuvora (Servicio de Expiración):** Agente de fondo programado que transiciona cupones a estado `Expirado` al cumplirse las 2 horas de emisión.

### 3.2 Restricciones de Diseño e Infraestructura
* **Presupuesto y Despliegue:** Arquitectura contenerizada basada en microservicios modulares orquestados con Docker Compose sobre un servidor VPS Linux de recursos moderados (4 vCPU, 8 GB RAM).
* **Conectividad:** Entorno inalámbrico comercial susceptible a fluctuaciones de señal Wi-Fi; se exige mecanismo de contingencia por código alfanumérico manual (8 caracteres) y timeouts configurados a 3 segundos.
* **Separación de Capas:** Prohibición estricta de consultas directas de base de datos desde la capa de presentación; desacoplamiento total mediante API Gateway y servicios de aplicación.

---

## 4. Definición y Justificación de la Plataforma Tecnológica

### 4.1 Lenguaje Orientado a Objetos: TypeScript / Node.js (Framework NestJS)
Se selecciona **TypeScript** bajo el framework empresarial **NestJS** como plataforma de backend orientado a objetos, sustentado en tres (3) condiciones concretas del caso:

1. **Arquitectura Orientada a Objetos Robusta y Principios SOLID:** NestJS implementa de forma nativa los patrones de diseño esenciales (Inyección de Dependencias, Módulos, Controladores, Servicios y Fachadas), facilitando una arquitectura en capas limpia (*Clean Architecture*) donde las clases de dominio están 100% desacopladas de la persistencia y de la interfaz HTTP.
2. **Modelo Asíncrono no Bloqueante de Alto Rendimiento (Event-Loop):** La plazoleta concentra más de 12.000 personas los fines de semana. El motor asíncrono de Node.js procesa solicitudes de lectura y emisión masiva de forma ultrarrápida sin sobrecargar memoria por hilos bloqueados, cumpliendo holgadamente el RNF-01 ($\le 1.5$ s).
3. **Tipado Estricto de Datos y Coherencia Full-Stack:** TypeScript aporta tipado estático en tiempo de compilación para entidades, DTOs (*Data Transfer Objects*) e interfaces de patrones GoF, reduciendo a cero los errores por tipos nulos o inconsistentes entre el backend y los componentes visuales PWA.

### 4.2 Tipo de Base de Datos: Relacional SQL (Motor PostgreSQL 15+)
Se selecciona un motor **Relacional SQL (PostgreSQL)** en lugar de bases de datos NoSQL, sustentado en tres (3) condiciones críticas del caso:

1. **Integridad Transaccional ACID y Bloqueo Pesimista de Filas:** La redención de cupones implica dinero, descuentos comerciales e inventarios estrictos. PostgreSQL garantiza aislamiento transaccional con la instrucción `SELECT ... FOR UPDATE`, asegurando que dos cajeros en terminales distintas no puedan canjear la misma instancia de cupón en una condición de carrera (*race condition*).
2. **Estructura Relacional Fija y Restricciones Referenciales Fuertes:** El dominio de Nuvora posee relaciones mandatorias estrictas (`Usuario` $\rightarrow$ `Cupon` $\rightarrow$ `Promocion` $\rightarrow$ `Local Comercial`), que exigen claves foráneas compuestas, restricciones `UNIQUE`, `CHECK` de vigencia de fechas y acciones referenciales `ON DELETE RESTRICT` que solo un motor relacional garantiza a nivel de motor.
3. **Auditoría Financiera Inmutable y Consultas Analíticas Relacionales:** Los locatarios del centro comercial liquidan cuentas mensualmente. PostgreSQL permite mantener tablas de bitácora inmutables particionadas con sellos de tiempo (`TIMESTAMPTZ`) y funciones de agregación analítica relacional sin inconsistencias de lectura eventual.

---

## 5. Catálogo de Entregables de Diseño (Producto 1)

Para dar cumplimiento exhaustivo a los requisitos del Criterio C1 al C7 de la Rúbrica G2-P1, se estructuran los siguientes artefactos:

| Código | Artefacto Obligatorio | Formato de Archivo | Propósito y Contenido Principal |
|:---:|---|---|---|
| **A1** | Ficha de Interpretación y Plataforma | `01-ficha-interpretacion-plataforma.md` | Selección de requisitos, justificación técnica y restricciones. |
| **A2** | Diagrama de Clases de Diseño | `02-diagrama-clases.drawio` / `.svg` | $\ge 8$ clases con visibilidad, tipos, métodos, agregación y herencia/interfaz con polimorfismo. |
| **A3** | Patrones de Diseño GoF Aplicados | `03-patrones-diseno.md` | Implementación de Estrategia (`IEstrategiaDescuento`) y Fachada (`CanjeCuponFacade`). |
| **A4** | Arquitectura del Software y RNF | `04-arquitectura-decisiones-rnf.md` + `.drawio` / `.svg` | Estilo en capas sin saltos, tabla de decisiones frente a RNF y alternativa descartada. |
| **A5** | Vista de Componentes | `05-vista-componentes.md` + `.drawio` / `.svg` | $\ge 5$ componentes con interfaces provistas/requeridas, dependencias y mapeo de clases. |
| **A6** | Vista de Despliegue | `06-vista-despliegue.md` + `.drawio` / `.svg` | $\ge 3$ nodos con artefactos, protocolos, puertos y decisiones de RNF. |
| **A7** | Matriz de Trazabilidad Análisis $\rightarrow$ Diseño | `07-matriz-trazabilidad-analisis-diseno.md` | Mapeo cruzado del 100% de los requisitos hacia clases, tablas y componentes. |
| **IDX** | Índice y Control de Entrega | `README.md` | Índice formal de la entrega bajo la plantilla oficial SENA. |

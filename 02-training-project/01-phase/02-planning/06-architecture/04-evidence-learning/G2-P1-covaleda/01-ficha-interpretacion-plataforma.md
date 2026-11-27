# Ficha de Interpretación del Análisis y Plataforma Tecnológica (A1)
## Proyecto Formativo: Nuvora (antes MercaGo) — Plataforma Transaccional Gastronómica
**Ubicación de Implementación:** Plazoleta de Comidas · Centro Comercial San Pedro Plaza (Neiva, Huila)  
**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro de Formación:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** `covaleda402`  
**Fase del Proyecto:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593103 (Criterio C1)  
**Ruta de Entrega:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-covaleda/`  
**Normativa y Referencia:** `Guia_Aprendizaje_Diseno.pdf`, `Rubricas_G2.md` (Sección 2.1 y 2.2 · Nivel 100) y `Plantillas_G2.md`

---

## 1. Contexto Operativo y Problema de Negocio

El Centro Comercial San Pedro Plaza en Neiva (Huila) cuenta con una plazoleta gastronómica de más de 20 opciones y un flujo peatonal masivo que supera los 12.000 visitantes en fines de semana. A partir del **SRS colaborativo del equipo formativo (`SRS_MercaGo_SanPedroPlaza.md`, v2.0)** y el **Informe de Análisis de Guía 1 (`G1-P2-covaleda/07-informe-analisis-trazabilidad.md`)**, se evidenciaron:
1. **Picos de congestión y horas valle:** Baja afluencia los días martes a jueves entre 2:30 p. m. y 5:30 p. m., con alto desperdicio de volantes físicos (88.6 % los desecha).
2. **Fricción por presupuesto (`COP`):** El 77.1 % de los visitantes elige su almuerzo dentro de un presupuesto fijo y recorre varios locales comparando cartas manualmente.
3. **Descontrol y riesgo de fraude en ofertas estáticas:** Los comercios necesitan validar cupones en menos de **1.5 segundos** en punto de venta (POS) sin usar pasarelas de pago en línea ni logística de domicilios.

**Solución de Diseño:** Arquitectura orientada a objetos en 4 capas limpias (*Clean Layered Architecture*) con catálogo filtrable por presupuesto, emisión de cupones efímeros con código QR criptográfico (HMAC-SHA256, vigencia máxima de 2 horas según RN-02) y terminal POS en caja con transacción ACID y bloqueo pesimista (`SELECT ... FOR UPDATE`, RN-04).

---

## 2. Requisitos Seleccionados del Sistema (Trazados al SRS v2.0 del Equipo)

### 2.1 Requisitos Funcionales Seleccionados (14 Críticos de los 20 RF del SRS · Mínimo Exigible $\ge 8$)

| ID Requisito | Denominación Oficial en el SRS | Descripción Operativa y Regla de Negocio Asociada | Actor Primario |
|:---:|---|---|---|
| **RF-01** | Registro de Visitantes | Permite al visitante registrarse con nombre completo, correo electrónico válido y contraseña dispersada con sal y hash (cumpliendo Ley 1581 de 2012). | Visitante |
| **RF-02** | Inicio de Sesión y Manejo de Tokens | Autentica usuarios de los distintos roles (`Visitante`, `Locatario`, `Cajero`, `Administrador`) expidiendo un token firmado JWT con expiración controlada. | Todos |
| **RF-04** | Gestión de Perfil de Local | Permite al locatario actualizar los datos públicos de su establecimiento (razón social, número de local, teléfono, horario de atención y estado operativo). | Locatario |
| **RF-05** | Catálogo General de Locales y Plazoleta | Presenta la lista organizada de comercios del Centro Comercial San Pedro Plaza clasificados por categoría gastronómica sin exigir registro previo (RN-06). | Visitante |
| **RF-07** | Algoritmo de Búsqueda y Filtro por Presupuesto | Calcula y filtra productos y combos cuyo valor en pesos colombianos (`$COP`) sea menor o igual al tope ingresado por el usuario, ordenados de menor a mayor precio. | Visitante |
| **RF-09** | Creación de Promociones | Permite al locatario crear ofertas asignando título descriptivo, producto, porcentaje/valor de descuento, stock máximo y vigencia calendario. | Locatario |
| **RF-10** | Parametrización de Franjas Horarias | Condiciona la activación de ofertas relámpago a días de la semana y rangos de hora específicos (ej. mar-jue 15:00 a 17:30), validados contra reloj del servidor (RN-05). | Locatario |
| **RF-13** | Generación Criptográfica de Cupón | Genera una instancia única con código alfanumérico corto (8 caracteres) y token firmado, aplicando el límite de 1 cupón activo por promoción cada 24 h (RN-01). | Visitante |
| **RF-14** | Renderizado de Código QR Dinámico | Muestra en la pantalla móvil el código QR del cupón acompañado de un contador regresivo visible de la ventana máxima de 2 horas (RN-02). | Visitante |
| **RF-16** | Interfaz Operativa de Caja | Provee al cajero una pantalla rápida optimizada para escanear QR con cámara o digitar manualmente el código alfanumérico de respaldo en caso de falla óptica. | Cajero / Locatario |
| **RF-17** | Validación Transaccional Inmediata | Verifica en servidor existencia, coincidencia estricta de local (`cupon.promocion.local_id == cajero.local_id`, RN-07), estado `ACTIVO`/`EMITIDO`, franja y bloqueo pesimista `SELECT ... FOR UPDATE` (RN-04). | Cajero / Sistema |
| **RF-18** | Respuesta Visual de Redención y Marcado | Marca atómicamente el cupón como canjeado y despliega aviso verde de confirmación o aviso rojo con motivo exacto de rechazo (`YA UTILIZADO`, `EXPIRADO`, `OTRO LOCAL`). | Cajero / Sistema |
| **RF-19** | Dashboard de Métricas para el Locatario | Consolida vistas, cupones emitidos vs. redimidos y tasa de conversión porcentual por campaña a través de `ReporteComercial`. | Locatario / Admin |
| **RF-20** | Bitácora Inmutable de Auditoría | Registra cada redención con identificador del cupón, cajero, IP origen, fecha/hora exacta, monto descontado y firma hash de integridad. | Sistema / Admin |

### 2.2 Requisitos No Funcionales (10 RNF del SRS · Mínimo Exigible $\ge 3$ con Métrica)

| ID Requisito | Característica ISO/IEC 25010 | Descripción Técnica y Métrica Verificable (SRS v2.0) |
|:---:|---|---|
| **RNF-01** | **Rendimiento en Punto de Venta** | La validación y respuesta en la interfaz del cajero tras escanear el código QR debe responder en un **tiempo $\le 1.5$ segundos** bajo red 4G/Wi-Fi comercial con hasta 150 tx/min en hora pico. |
| **RNF-02** | **Seguridad de Credenciales y Tránsito** | Todas las contraseñas se protegen mediante **hash y sal irreversible (`bcrypt`, factor de costo $\ge 12$)**. Las comunicaciones cliente-servidor operan exclusivamente sobre **HTTPS / WSS con TLS 1.3**. |
| **RNF-03** | **Seguridad Criptográfica de Cupones** | Los códigos y tokens QR de cupones se generan con entropía criptográfica (`crypto.randomBytes` + firma **HMAC-SHA256**) impidiendo enumeración secuencial o falsificación. |
| **RNF-04** | **Integridad Transaccional y Concurrencia (ACID)** | PostgreSQL garantiza aislamiento *Read Committed* y bloqueo pesimista de fila (`SELECT ... FOR UPDATE`) para neutralizar condiciones de carrera ante intentos simultáneos de doble canje. |
| **RNF-05** | **Usabilidad y Diseño Mobile-First** | La interfaz visitante y POS está adaptada al 100 % para móviles (viewports 360px a 430px), con controles táctiles $\ge 48 \times 48$ px y contraste accesible **WCAG 2.1 AA**. |
| **RNF-06** | **Disponibilidad Operativa** | La plataforma mantiene una disponibilidad mínima del **$\ge 99.0\%$ a $99.5\%$** durante el horario comercial de San Pedro Plaza (8:00 a. m. a 10:00 p. m.). |
| **RNF-07** | **Mantenibilidad (Separación de Capas)** | Arquitectura limpia en 4 capas desacopladas (Presentación, Aplicación, Dominio e Infraestructura) sin mezcla de lógica SQL dentro de controladores ni vistas. |
| **RNF-08** | **Resiliencia en Conectividad y Hardware** | Ante fallas de cámara o intermitencia Wi-Fi en caja, la terminal POS habilita ingreso manual alfanumérico de 8 caracteres y reintentos idempotentes sin recargar pantalla. |
| **RNF-09** | **Protección de Datos Personales (Habeas Data)** | Cumplimiento de la **Ley Estatutaria 1581 de 2012** solicitando autorización explícita y finalidad de tratamiento al momento del registro. |
| **RNF-10** | **Compatibilidad de Navegadores** | Operación homogénea sobre las versiones estables de Google Chrome, Mozilla Firefox, Apple Safari y Microsoft Edge. |

---

## 3. Actores y Restricciones del Sistema

### 3.1 Actores del Sistema
1. **Visitante / Consumidor:** Consulta el catálogo público, filtra por presupuesto en COP, emite cupones QR con vigencia de 2 horas y los presenta en caja.
2. **Locatario (Administrador de Local):** Administra los datos del establecimiento, menús, promociones y franjas horarias relámpago; consulta reportes de conversión.
3. **Cajero / Validador en Punto de Venta:** Opera la terminal web POS para escanear QR o digitar códigos manuales de contingencia y aplicar descuentos válidos *(en diseño de clases y RBAC de base de datos se autentica bajo el rol `LOCATARIO`)*.
4. **Administrador de Plataforma (Centro Comercial):** Habilita locales comerciales, categorías y audita métricas globales e integridad de la bitácora.

### 3.2 Restricciones del Caso
* **Sin Pasarelas de Pago ni Domicilios (Alcance MVP):** El recaudo monetario ocurre presencialmente en la caja física del establecimiento; el software valida y registra el descuento sin comisiones bancarias ni logística externa.
* **Infraestructura Contenerizada de Costo Acotado:** Servidor VPS Linux (4 vCPU, 8 GB RAM) con contenedores Docker (Backend + Redis) conectado por red privada VPC a PostgreSQL 15+.
* **Entorno Wi-Fi Comercial Variable:** Exige cargas útiles JSON ligeras, caché de catálogo en memoria y contingencia alfanumérica en POS.

---

## 4. Definición y Justificación de la Plataforma Tecnológica

### 4.1 Lenguaje Orientado a Objetos: TypeScript / Node.js (Framework NestJS)
Se selecciona **TypeScript** con **NestJS** sustentado en tres (3) condiciones concretas del caso:
1. **Soporte Nativo para Patrones GoF y Clean Architecture:** NestJS incorpora inyección de dependencias, interfaces, decoradores e inversión de control, facilitando el encapsulamiento del patrón `Strategy` (`IEstrategiaDescuento`) y `Facade` (`CanjeCuponFacade`) sin acoplar dominio con base de datos (atendiendo **RNF-07**).
2. **Concurrencia Asíncrona en Horas Pico de Plazoleta:** Durante almuerzos de fin de semana con más de 12.000 visitantes, el *Event-Loop* no bloqueante de Node.js atiende consultas masivas de catálogo y validaciones de caja cumpliendo el tiempo máximo de respuesta **$\le 1.5$ s (RNF-01)**.
3. **Tipado Estático Full-Stack:** Al compartir DTOs e interfaces tipadas con el frontend React/PWA, se previenen inconsistencias de tipos en cálculos de descuentos en COP, fechas límite y estados del cupón.

### 4.2 Tipo de Base de Datos: Relacional SQL (Motor PostgreSQL 15+)
Se selecciona **PostgreSQL 15+** (motor relacional SQL) sustentado en tres (3) condiciones críticas del caso:
1. **Atomicidad ACID y Bloqueo Pesimista de Filas (`SELECT ... FOR UPDATE`):** Para evitar pérdidas económicas por doble redención simultánea de capturas QR en distintas cajas (**RN-04, RNF-04**), se requiere bloqueo transaccional estricto que una base NoSQL de consistencia eventual no garantiza.
2. **Integridad Referencial Fuerte y Claves Compuestas:** El dominio posee jerarquías obligatorias (`usuario` $\rightarrow$ `local_comercial` $\rightarrow$ `promocion` $\rightarrow$ `franja_horaria` como entidad débil con PK compuesta y `cupon` asociativo N:M) que requieren `FK`, `UNIQUE`, `CHECK` e acciones `ON DELETE RESTRICT/CASCADE`.
3. **Auditoría Inmutable y Analítica SQL Exacta:** Las liquidaciones comerciales de `ReporteComercial` y `BitacoraCanje` demandan precisión decimal (`NUMERIC(12,2)` sin errores de punto flotante) y sellos `TIMESTAMPTZ` verificables contra la hora oficial del servidor (**RN-05**).

---

## 5. Catálogo de Entregables de Diseño (Producto 1)

| Código | Artefacto Obligatorio | Archivo(s) en la Carpeta | Propósito y Contenido Principal |
|:---:|---|---|---|
| **A1** | Ficha de Interpretación y Plataforma | `01-ficha-interpretacion-plataforma.md` | Selección de 14 RF y 10 RNF trazados al SRS, actores, restricciones y justificación técnica. |
| **A2** | Diagrama de Clases de Diseño | `02-diagrama-clases.drawio` / `.svg` | 15 clasificadores (12 clases, 1 abstracta, 1 interfaz, 3 estrategias), alta cohesión, visibilidad, composición, agregación y polimorfismo. |
| **A3** | Patrones de Diseño GoF Aplicados | `03-patrones-diseno.md` | Justificación e integración en clases de **Strategy** y **Facade** (distintos de Singleton). |
| **A4** | Arquitectura del Software y RNF | `04-arquitectura-decisiones-rnf.md` + `.drawio` / `.svg` | Estilo *Clean Layered Architecture* en 4 capas sin saltos, tabla de decisiones frente a RNF y alternativas descartadas. |
| **A5** | Vista de Componentes | `05-vista-componentes.md` + `.drawio` / `.svg` | 6 componentes modulares con interfaces provistas/requeridas, dependencias dirigidas y mapeo de clases. |
| **A6** | Vista de Despliegue | `06-vista-despliegue.md` + `.drawio` / `.svg` | 3 nodos físicos (Cliente, Aplicación VPS, Persistencia VPC) con protocolos, puertos y decisiones de RNF. |
| **A7** | Matriz de Trazabilidad Análisis $\rightarrow$ Diseño | `07-matriz-trazabilidad-analisis-diseno.md` | Cobertura bidireccional del 100 % (20/20 RF) sin clases huérfanas. |
| **IDX** | Índice y Control de Autoría | `README.md` | Índice formal bajo `Plantilla_README_Entrega_G2.md` con atribución transparente del equipo e IA. |

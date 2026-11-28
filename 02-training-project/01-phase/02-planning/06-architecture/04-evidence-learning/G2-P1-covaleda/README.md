# README de Entrega · Guía 2: Producto 1 (G2-P1)
## Artefactos de Diseño del Software — Proyecto Nuvora

**Ruta en el repositorio:**  
`02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-covaleda/`

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Fecha Límite Oficial:** Sábado 28 de noviembre de 2026 a las 6:00 a. m.  
**Normativa y Evaluación:** `Guia_Aprendizaje_Diseno.pdf`, `Rubricas_G2.md` (Secciones 1 y 2 · RAP 593103 · Peso: 25 %) y `Plantillas_G2.md`

---

## 1. Datos de la Entrega

| Campo | Valor |
|---|---|
| **Producto** | P1 (Artefactos de diseño de software) |
| **Usuario de GitHub del autor** | `covaleda402` |
| **Ficha** | 3413974 |
| **Caso elegido (nombre del proyecto)** | Nuvora (evolución del SRS del proyecto formativo MercaGo — Centro Comercial San Pedro Plaza, Neiva) |
| **Enlace al informe de análisis o SRS del caso (ruta en mi fork)** | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md) · *(Insumo base del equipo fuera del repositorio: `SRS_MercaGo_SanPedroPlaza.md` v2.0)* |
| **Cuenta de GitHub con la que hago los commits** | `covaleda402` |

---

## 2. Origen del Insumo y Trabajo en Equipo

| Pregunta | Respuesta |
|---|---|
| **¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas?** | **Sí.** El documento SRS base del proyecto formativo (`SRS_MercaGo_SanPedroPlaza.md`, v2.0, cuyo caso es San Pedro Plaza) fue elaborado colaborativamente por nuestro **equipo formativo de tres (3) aprendices** de la Ficha 3413974 (los nombres personales se omiten cumpliendo la política de privacidad de repositorio público). Como fuente oficial publicada en este fork, el análisis formal de Nuvora está consolidado en [`G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md). |
| **¿Qué parte del SRS es tuya?** | Dentro del SRS compartido del equipo, mi aporte principal correspondió a la definición de las **Reglas de Negocio (RN-01 a RN-07)**, los requerimientos del frente administrativo de **Locatarios y Promociones (RF-09 a RF-12)** y del módulo de **Validación y Redención POS en Caja (RF-16 a RF-18)**, así como la interpretación integral de los 20 RF y 10 RNF para el diseño. **Subconjunto asumido en G2-P1 ($\ge 8$ RF):** Diseño y trazo **los 20 requisitos funcionales (`RF-01` a `RF-20`)** y **los 10 RNF (`RNF-01` a `RNF-10`)** con decisiones propias de arquitectura orientada a objetos, patrones `Strategy` y `Facade` y vistas 4+1. |
| **¿Los artefactos de esta entrega los hiciste tú solo?** | **Sí.** La totalidad de los artefactos de diseño de software de esta carpeta `G2-P1-covaleda` (Ficha A1, Diagrama de Clases de 15 clasificadores A2, Patrones Strategy/Facade A3, Arquitectura en 4 capas A4, Vista de Componentes A5, Vista de Despliegue A6 y Matriz de Trazabilidad A7 en `.md`, `.drawio` y `.svg`) fueron elaborados de manera **100 % individual** por `covaleda402`. |
| **¿Otro aprendiz usó o te compartió archivos de esta entrega?** | **Solo el insumo inicial del proyecto:** Un compañero del equipo compartió el borrador consolidado del documento base `SRS_MercaGo_SanPedroPlaza.md` (no alojado en GitHub) como marco de requisitos del equipo del año. **En cuanto a los archivos de diseño de esta entrega G2-P1, No:** ningún otro aprendiz me compartió ni utilizó artefactos de diseño de esta carpeta. |

---

## 3. Qué Reutilicé, Qué Ajusté y Qué Hice Nuevo

> **Uso de guías, rúbricas y plantillas oficiales del instructor:** Para estructurar, diseñar y verificar esta entrega se consultaron y aplicaron estrictamente las instrucciones, formatos de tablas y criterios de nivel 100 de los documentos oficiales suministrados por el instructor en `02-training-project/01-phase/02-planning/06-architecture/`: **`Guia_Aprendizaje_Diseno.pdf`**, **`Rubricas_G2.md`**, **`Plantillas_G2.md`** y **`Plantilla_README_Entrega_G2.md`**. Estos documentos se usaron exclusivamente como **marco normativo, metodológico y de formato**; en ningún artefacto se copió el caso de ejemplo (*Biblioteca de barrio*) ni el código/material de `design-software/` como trabajo propio.

| Artefacto Obligatorio | Archivo en esta Carpeta | Origen (Ruta en mi fork o «nuevo») | Qué Ajusté o Agregué |
|---|---|---|---|
| **A1. Ficha de interpretación y plataforma** | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md` + SRS base del equipo (`SRS_MercaGo_SanPedroPlaza.md`) | Seleccioné 14 RF críticos y los 10 RNF con sus ID exactos del SRS; justifiqué TypeScript/NestJS (POO) y PostgreSQL 15+ (relacional) con 3 condiciones verificables del caso. |
| **A2. Diagrama de clases de diseño** | [`02-diagrama-clases.drawio`](./02-diagrama-clases.drawio) y [`.svg`](./02-diagrama-clases.svg) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/03-modelo-dominio.drawio` | Transformé el modelo conceptual en diagrama UML de diseño con **15 clasificadores** (10 clases concretas de dominio/fachada incluyendo `ReporteComercial`, 1 abstracta `Usuario`, 1 interfaz `IEstrategiaDescuento` y 3 estrategias concretas), visibilidad, tipos, métodos con parámetros, composición, agregación, alta cohesión (Regla 5) y topología sin cruces. |
| **A3. Patrones de diseño GoF** | [`03-patrones-diseno.md`](./03-patrones-diseno.md) | **Nuevo** | Incorporé e integré en el diagrama de clases dos patrones GoF distintos de Singleton: **Strategy** (liquidación polimórfica de descuentos) y **Facade** (`CanjeCuponFacade` para orquestación transaccional ACID en caja). |
| **A4. Arquitectura del software y RNF** | [`04-arquitectura-decisiones-rnf.md`](./04-arquitectura-decisiones-rnf.md) + [`.drawio`](./04-arquitectura-software.drawio) / [`.svg`](./04-arquitectura-software.svg) | **Nuevo** | Definí la arquitectura en 4 capas limpias (*Clean Layered Architecture*) sin saltos, tabla de decisiones frente a 4 RNF críticos, alternativas descartadas y comunicación REST/WSS. |
| **A5. Vista de componentes** | [`05-vista-componentes.md`](./05-vista-componentes.md) + [`.drawio`](./05-vista-componentes.drawio) / [`.svg`](./05-vista-componentes.svg) | **Nuevo** | Diseñé 6 componentes modulares en NestJS con interfaces provistas y requeridas explícitas, dependencias dirigidas hacia datos y mapeo completo de clases y RF. |
| **A6. Vista de despliegue** | [`06-vista-despliegue.md`](./06-vista-despliegue.md) + [`.drawio`](./06-vista-despliegue.drawio) / [`.svg`](./06-vista-despliegue.svg) | **Nuevo** | Modelé topología física en 3 nodos (Dispositivos Cliente, Servidor VPS Docker/Nginx/NestJS/Redis, Servidor VPC PostgreSQL) con protocolos/puertos (HTTPS 443, WSS 443, TCP 5432, TCP 6379) y respaldos frente a RNF. |
| **A7. Matriz de trazabilidad análisis $\rightarrow$ diseño** | [`07-matriz-trazabilidad-analisis-diseno.md`](./07-matriz-trazabilidad-analisis-diseno.md) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md` | Mapeé bidireccionalmente el 100 % de los 20 RF del SRS hacia los 15 clasificadores del diagrama de clases, tablas 3FN, componentes y patrones, certificando cero clases huérfanas. |

**Qué reutilicé (resumen):**  
Reutilicé el marco funcional base de 20 Requisitos Funcionales, 10 Requisitos No Funcionales y 7 Reglas de Negocio documentado en el SRS del equipo (`SRS_MercaGo_SanPedroPlaza.md`) y refinado en mi análisis de Guía 1 (`G1-P2-covaleda`), junto con los conceptos de dominio de la plazoleta de San Pedro Plaza.

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen):**  
Evolucioné las entidades puras del análisis hacia clases de diseño orientadas a objetos con encapsulamiento (`-`, `+`), firmas completas de métodos y tipos de retorno, separando la responsabilidad de reportes (`ReporteComercial`) y persistencia fuera de las entidades de negocio para garantizar alta cohesión según la Regla 5 de `Rubricas_G2.md`. Asimismo, alineé todos los IDs `RF-01` a `RF-20` con el SRS oficial del proyecto.

**Qué hice completamente nuevo (resumen):**  
Construí desde cero los dos patrones de diseño GoF (`Strategy` y `Facade`), la arquitectura de software en 4 capas limpias con inversión de dependencias (DIP), los diagramas editables `.drawio` y vectoriales `.svg` de clases, arquitectura, componentes y despliegue físico de red, y la matriz de trazabilidad bidireccional completa.

---

## 4. Autoverificación de Mínimos (RMA - Rúbrica G2-P1 Nivel 100)

- [x] **A1 Ficha de interpretación:** $\ge 8$ RF (14 seleccionados de los 20 RF del SRS) y $\ge 3$ RNF (10 incluidos) con ID; plataforma tecnológica POO (TypeScript/NestJS) y BD relacional (PostgreSQL 15+) justificadas con 3 condiciones concretas cada una.
- [x] **A2 Diagrama de clases:** $\ge 8$ clases (15 clasificadores diseñados: 10 clases concretas de dominio/fachada, 1 clase abstracta, 1 interfaz y 3 estrategias concretas), tipos, visibilidad, métodos con parámetros, multiplicidades en el 100 % de asociaciones, composición/agregación, herencia e interfaz, alta cohesión sin mezcla de áreas distintas y cero clases huérfanas.
- [x] **A3 Patrones de diseño:** $\ge 2$ patrones GoF distintos de Singleton reflejados en el diagrama (**Strategy** con 3 implementaciones y **Facade** orquestando subsistemas POS).
- [x] **A4 Arquitectura del software:** Estilo en 4 capas limpias sin saltos, diagrama editable + SVG limpio, tabla de decisiones con 4 RNF, estilo de comunicación REST/WSS y alternativas descartadas justificadas.
- [x] **A5 Vista de componentes:** $\ge 5$ componentes (6 componentes diseñados) con interfaces provistas y requeridas nombradas, dependencias con dirección correcta y mapeo a clases/requisitos.
- [x] **A6 Vista de despliegue:** $\ge 3$ nodos (Cliente, Aplicación, Datos) con artefactos alojados, protocolos/puertos (`HTTPS 443`, `WSS 443`, `TCP 5432`, `TCP 6379`) y decisiones de RNF.
- [x] **A7 Matriz de trazabilidad:** 100 % de los 20 RF mapeados en ambos sentidos (sin clases huérfanas).
- [x] **Formatos:** Fuente editable (`.drawio`) e imagen exportada (`.svg`) de cada uno de los 4 diagramas entregados y sincronizados en la carpeta.

---

## 5. Historial de Commits (Control de Autoría en 2 Días Distintos)

| Día | Qué avancé (hash y mensaje real del commit) |
|---|---|
| **Día 1: Jueves 26 de noviembre de 2026** | [`67abf3c`](https://github.com/covaleda402/ADSO-3413974/commit/67abf3c) — `feat(g2-p1): entrega base artefactos de diseno de software nuvora (clases, patrones, vistas 4+1, trazabilidad)` |
| **Día 2: Viernes 27 de noviembre de 2026** *(Entrega de cierre)* | [`8b50c58`](https://github.com/covaleda402/ADSO-3413974/commit/8b50c58) / [`463b96c`](https://github.com/covaleda402/ADSO-3413974/commit/463b96c) — Entrega final A1–A7, refactor de cohesión (`ReporteComercial`), declaración transparente del SRS/rol `LOCATARIO`, más pulido final en flechas de despliegue y etiquetas `.drawio`/`.svg`. |

---

## 6. Uso de Inteligencia Artificial (Declaración Obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Asistente IA (Antigravity / Gemini) | Apoyo en la estructuración de las plantillas Markdown de `Plantillas_G2.md`, trazado ortogonal XML/SVG para los diagramas y validación cruzada de consistencia entre requisitos del SRS y criterios de `Rubricas_G2.md`. | Revisé y edité manualmente el diagrama de despliegue en Draw.io exportando su SVG, audité los renderizados en Draw.io detectando desbordamientos de contenedores `swimlane` y cruces de líneas para corregirlos al 100 %, verifiqué el cumplimiento de la Regla 5 (separando `ReporteComercial` de `Locatario`), alineé los 20 IDs de requisitos frente al SRS de nuestro equipo (`SRS_MercaGo_SanPedroPlaza.md`) y confirmé la aplicación correcta de los patrones `Strategy` y `Facade` para explicarlos en sustentación oral. |

---

## 7. Enlaces

- **Informe de análisis / SRS del caso:** [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md) *(derivado del insumo colaborativo del equipo `SRS_MercaGo_SanPedroPlaza.md` v2.0)*
- **Carpeta de esta entrega en GitHub:** https://github.com/covaleda402/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-covaleda
- **Otros enlaces de apoyo (normativa y guías oficiales del instructor usadas como referencia):**
  - Guía de Aprendizaje: [`Guia_Aprendizaje_Diseno.pdf`](../../01-learning-guide/Guia_Aprendizaje_Diseno.pdf)
  - Rúbricas Oficiales G2: [`Rubricas_G2.md`](../../03-support-material/Rubricas_G2.md)
  - Plantillas Oficiales G2: [`Plantillas_G2.md`](../../03-support-material/Plantillas_G2.md)

### Índice de Artefactos de la Carpeta (`G2-P1-covaleda`)

* **Ficha de Interpretación y Plataforma (A1):** [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md)
* **Diagrama de Clases UML - Vectorial (A2):** [`02-diagrama-clases.svg`](./02-diagrama-clases.svg)
* **Diagrama de Clases UML - Fuente Draw.io (A2):** [`02-diagrama-clases.drawio`](./02-diagrama-clases.drawio)
* **Especificación de Patrones GoF (A3):** [`03-patrones-diseno.md`](./03-patrones-diseno.md)
* **Arquitectura del Software y RNF (A4):** [`04-arquitectura-decisiones-rnf.md`](./04-arquitectura-decisiones-rnf.md)
* **Diagrama de Arquitectura - Vectorial (A4):** [`04-arquitectura-software.svg`](./04-arquitectura-software.svg)
* **Diagrama de Arquitectura - Fuente Draw.io (A4):** [`04-arquitectura-software.drawio`](./04-arquitectura-software.drawio)
* **Vista de Componentes - Especificación (A5):** [`05-vista-componentes.md`](./05-vista-componentes.md)
* **Vista de Componentes - Vectorial (A5):** [`05-vista-componentes.svg`](./05-vista-componentes.svg)
* **Vista de Componentes - Fuente Draw.io (A5):** [`05-vista-componentes.drawio`](./05-vista-componentes.drawio)
* **Vista de Despliegue - Especificación (A6):** [`06-vista-despliegue.md`](./06-vista-despliegue.md)
* **Vista de Despliegue - Vectorial (A6):** [`06-vista-despliegue.svg`](./06-vista-despliegue.svg)
* **Vista de Despliegue - Fuente Draw.io (A6):** [`06-vista-despliegue.drawio`](./06-vista-despliegue.drawio)
* **Matriz de Trazabilidad Análisis $\rightarrow$ Diseño (A7):** [`07-matriz-trazabilidad-analisis-diseno.md`](./07-matriz-trazabilidad-analisis-diseno.md)

---

## 8. Declaración de Autoría

Declaro que los artefactos de esta carpeta son de mi autoría individual, que el origen colaborativo del SRS base del equipo y lo que reutilicé del análisis o de otras fuentes está indicado con exactitud en las secciones 2 y 3, que me basé en las guías, plantillas y rúbricas oficiales del instructor sin entregar material del instructor ni de otros aprendices como propio, y que estoy preparado para sustentar y explicar cada clase, patrón y decisión arquitectónica en la verificación oral ante el instructor.

Usuario de GitHub: `covaleda402`  Fecha: 27 de noviembre de 2026

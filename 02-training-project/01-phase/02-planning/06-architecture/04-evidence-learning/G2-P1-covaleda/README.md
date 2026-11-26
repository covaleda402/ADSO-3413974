# README de Entrega · Guía 2: Producto 1 (G2-P1)
## Artefactos de Diseño del Software — Proyecto Nuvora

**Ruta en el repositorio:**  
`02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-covaleda/`

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Fecha Límite Oficial:** Sábado 28 de noviembre de 2026 a las 6:00 a. m.  
**Normativa y Evaluación:** `Rubricas_G2.md` (Sección 1 y Sección 2 · RAP 593103 · Peso: 25 %)

---

## 1. Datos de la Entrega

| Campo | Valor |
|---|---|
| **Producto** | P1 (Artefactos de diseño de software) |
| **Usuario de GitHub del autor** | `covaleda402` |
| **Ficha** | 3413974 |
| **Caso elegido (nombre del proyecto)** | Nuvora — Plataforma Transaccional Gastronómica (San Pedro Plaza, Neiva) |
| **Enlace al informe de análisis o SRS del caso** | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md) |
| **Cuenta de GitHub con la que hago los commits** | `covaleda402` |

---

## 2. Origen del Insumo y Trabajo en Equipo

| Pregunta | Respuesta |
|---|---|
| ¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas? | El análisis base fue desarrollado de forma individual por `covaleda402` para el caso del Centro Comercial San Pedro Plaza. |
| ¿Qué parte del SRS es tuya? | El 100 % del SRS, los 20 requisitos funcionales (RF-01 al RF-20) y los requisitos no funcionales (RNF-01 al RNF-10). |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí.** La totalidad de los artefactos de diseño, diagramas y matrices fueron elaborados individualmente por `covaleda402`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | **No.** Trabajo estrictamente individual y original. |

---

## 3. Qué Reutilicé, Qué Ajusté y Qué Hice Nuevo

| Artefacto Obligatorio | Archivo en esta Carpeta | Origen (Ruta en mi fork o «nuevo») | Qué Ajusté o Agregué |
|---|---|---|---|
| **A1. Ficha de interpretación y plataforma** | [`01-ficha-interpretacion-plataforma.md`](./01-ficha-interpretacion-plataforma.md) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md` | Reutilicé los 20 RFs y RNF del análisis; ajusté y formalicé la justificación técnica de POO (NestJS) y BD relacional (PostgreSQL) con 3 condiciones concretas cada una. |
| **A2. Diagrama de clases de diseño** | [`02-diagrama-clases.drawio`](./02-diagrama-clases.drawio) y [`.svg`](./02-diagrama-clases.svg) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/03-modelo-dominio.drawio` | Transformé el modelo de dominio conceptual en un diagrama de diseño orientado a objetos con 11 clases, visibilidad (`+`, `-`), tipos de datos de retorno, métodos con parámetros, agregación, composición y polimorfismo con 3 implementaciones. |
| **A3. Patrones de diseño GoF** | [`03-patrones-diseno.md`](./03-patrones-diseno.md) | **Nuevo** | Diseñé e incorporé dos patrones GoF distintos de Singleton: **Strategy** (para liquidación polimórfica de descuentos) y **Facade** (para orquestación transaccional del canje POS). |
| **A4. Arquitectura del software y RNF** | [`04-arquitectura-decisiones-rnf.md`](./04-arquitectura-decisiones-rnf.md) + [`.drawio`](./04-arquitectura-software.drawio) / [`.svg`](./04-arquitectura-software.svg) | **Nuevo** | Definí la arquitectura en 4 capas limpias sin saltos, tabla de decisiones con 4 RNF atendidos, alternativas descartadas y estilos de comunicación REST / WSS. |
| **A5. Vista de componentes** | [`05-vista-componentes.md`](./05-vista-componentes.md) + [`.drawio`](./05-vista-componentes.drawio) / [`.svg`](./05-vista-componentes.svg) | **Nuevo** | Diseñé 6 componentes de software modulares con interfaces provistas y requeridas, dependencias con dirección y mapeo hacia clases y requisitos. |
| **A6. Vista de despliegue** | [`06-vista-despliegue.md`](./06-vista-despliegue.md) + [`.drawio`](./06-vista-despliegue.drawio) / [`.svg`](./06-vista-despliegue.svg) | **Nuevo** | Diseñé la topología física en 3 nodos (Cliente, Aplicación/VPS, Datos/VPC aislada) con protocolos HTTPS 443, TCP 5432 y decisiones frente a RNF. |
| **A7. Matriz de trazabilidad análisis $\rightarrow$ diseño** | [`07-matriz-trazabilidad-analisis-diseno.md`](./07-matriz-trazabilidad-analisis-diseno.md) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md` | Mapeé el 100 % de los 20 RFs hacia clases, tablas, componentes y decisiones de diseño, certificando cero clases huérfanas. |

**Qué reutilicé (resumen):**  
Reutilicé el núcleo conceptual de requisitos de Nuvora desarrollado en la Guía 1 (20 Requisitos Funcionales y 10 Requisitos No Funcionales) y las entidades base del modelo de negocio gastronómico del Centro Comercial San Pedro Plaza.

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen):**  
Ajusté el modelo conceptual hacia una especificación técnica de diseño orientada a objetos: incorporé visibilidad estricta, firmas de métodos con parámetros, contratos de interfaz, separación estricta de responsabilidades (evitando mezcla de UI y persistencia) y tipado estático en TypeScript.

**Qué hice completamente nuevo (resumen):**  
Construí desde cero la arquitectura en capas limpias sin saltos, la implementación de los patrones GoF Strategy y Facade, los diagramas y especificaciones de componentes y despliegue físico con protocolos de red, y la matriz de trazabilidad bidireccional exhaustiva.

---

## 4. Autoverificación de Mínimos (RMA - Rúbrica G2-P1 Nivel 100)

- [x] **A1 Ficha de interpretación:** $\ge 8$ RF (20 incluidos) y $\ge 3$ RNF con ID; plataforma tecnológica POO y BD relacional justificadas con 3 condiciones del caso.
- [x] **A2 Diagrama de clases:** $\ge 8$ clases (11 clases diseñadas), tipos, visibilidad, métodos con parámetros/retorno, multiplicidades en el 100% de asociaciones, composición/agregación y herencia/interfaz con $\ge 2$ implementaciones polimórficas.
- [x] **A3 Patrones de diseño:** $\ge 2$ patrones GoF distintos de Singleton aplicados en el diagrama (**Strategy** con 3 implementaciones y **Facade** orquestando subsistemas).
- [x] **A4 Arquitectura del software:** Estilo en 4 capas limpias sin saltos, diagrama formal y tabla de decisiones con 4 RNF y alternativas descartadas justificadas.
- [x] **A5 Vista de componentes:** $\ge 5$ componentes (6 componentes diseñados) con interfaces provistas y requeridas, dependencias con dirección y mapeo de clases.
- [x] **A6 Vista de despliegue:** $\ge 3$ nodos (Cliente, Aplicación, Datos) con artefactos alojados, protocolos/puertos (HTTPS 443, TCP 5432) y decisiones de RNF.
- [x] **A7 Matriz de trazabilidad:** 100 % de los requisitos funcionales mapeados a clases, tablas y componentes, sin clases huérfanas.
- [x] **Formatos:** Fuente editable (`.drawio`) e imagen exportada (`.svg`) de cada diagrama entregados en la carpeta.

---

## 5. Historial de Commits (Control de Autoría en 2 Días Distintos)

| Día | Qué avancé (mensaje del commit) |
|---|---|
| **Día 1: Jueves 26 de noviembre de 2026** | `feat(G2-P1): entrega inicial de artefactos de diseno, clases, patrones gof, arquitectura, componentes y despliegue nuvora dia 1` |
| **Día 2: Viernes 27 de noviembre de 2026** | `docs(G2-P1): optimizacion de diagramas vectoriales, ajustes formativos y verificacion de consistencia cruzada dia 2` |

---

## 6. Uso de Inteligencia Artificial (Declaración Obligatoria)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| Asistente IA (Antigravity Senior Architecture Auditor) | Apoyo en la estructuración modular de plantillas Markdown, generación de esquemas de trazado ortogonal para diagramas Draw.io/SVG y validación cruzada de consistencia entre RNF y decisiones de arquitectura. | Revisión manual de todas las multiplicidades del diagrama de clases, comprobación de la no existencia de tipos primitivos de BD en la capa de dominio, verificación de la firma criptográfica HMAC-SHA256 y auditoría de no mezcla de responsabilidades en las clases. |

---

## 7. Enlaces a los Artefactos de la Entrega

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

Declaro que los artefactos de esta carpeta son de mi autoría individual, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado con exactitud en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que estoy completamente preparado para sustentar y explicar cada clase, patrón y decisión arquitectónica en la verificación oral ante el instructor.

**Usuario de GitHub:** `covaleda402`  
**Firma:** Jose Esneider Covaleda Hortua  
**Fecha:** 26 de noviembre de 2026

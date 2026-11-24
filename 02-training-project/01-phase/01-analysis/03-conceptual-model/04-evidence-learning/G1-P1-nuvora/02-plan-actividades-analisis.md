# 02 · Plan de Actividades de Análisis de Software
## Proyecto Formativo: Nuvora — Ecosistema Digital San Pedro Plaza
**Ficha SENA:** 3413974 · ADSO · Regional Huila  
**Aprendiz:** Jose Esneider Covaleda Hortua  

---

## 1. Cronograma y Plan de Actividades de la Fase de Análisis

Para dar cumplimiento estricto al Criterio C2 de la Guía 1 (RAP 592375), se definen **ocho (8) actividades de análisis priorizadas**, coherentes con el marco de trabajo **Scrum** y el alcance técnico del proyecto formativo:

| # | Actividad de Análisis | Prioridad | Responsable Principal | Fecha Inicio | Fecha Fin | Entregable Concreto y Verificable |
| :---: | :--- | :---: | :--- | :---: | :---: | :--- |
| **ACT-01** | **Levantamiento y Caracterización de Requisitos de Campo**<br>Simulación de entrevistas y encuestas semiestructuradas en locales de la plazoleta y pasillos de San Pedro Plaza. | Alta (P1) | Paula Claros Nañez | 10/11/2026 | 13/11/2026 | Documento de Informe de Trabajo de Campo y Ficha Técnica del Muestreo (35 encuestas y 6 entrevistas transcritas). |
| **ACT-02** | **Formulación del Documento de Especificación de Requisitos (SRS v2.0)**<br>Redacción de 20 Requerimientos Funcionales (RF01-RF20), 10 No Funcionales (RNF01-RNF10) y 7 Reglas de Negocio (RN-01 a RN-07). | Alta (P1) | Jose Esneider Covaleda / Edwin Esquivel | 14/11/2026 | 16/11/2026 | Archivo formal `SRS_MercaGo_SanPedroPlaza.md` aprobado por el equipo bajo estándar IEEE 830. |
| **ACT-03** | **Modelado de Casos de Uso del Negocio y Frontera del Sistema**<br>Identificación de actores primarios y casos de uso con relaciones `«include»` y `«extend»`. | Alta (P1) | Jose Esneider Covaleda Hortua | 17/11/2026 | 18/11/2026 | Diagrama de Casos de Uso UML en formato editable (`.drawio`) y renderizado vectorial (`.svg`). |
| **ACT-04** | **Construcción de la Matriz de Trazabilidad Requisito → Caso de Uso**<br>Mapeo bidireccional entre los 20 requisitos funcionales y los casos de uso para garantizar cobertura superior al 90%. | Alta (P1) | Jose Esneider Covaleda Hortua | 19/11/2026 | 20/11/2026 | Matriz tabular de cobertura funcional con justificación de inclusión. |
| **ACT-05** | **Diseño de Wireframes y Flujos de Experiencia de Usuario (UX/UI)**<br>Bocetado de las pantallas críticas (Catálogo por Presupuesto, Billetera QR y Pantalla de Validación de Caja). | Media (P2) | Paula Sofia Claros Nañez | 18/11/2026 | 21/11/2026 | Prototipo inicial de 3 pantallas clave en Figma rotuladas con su Caso de Uso correspondiente. |
| **ACT-06** | **Modelado Conceptual de Datos y Dominio del Negocio**<br>Definición de clases conceptuales puras (sin métodos) y Modelo Entidad-Relación (MER) con relaciones N:M resueltas. | Alta (P1) | Edwin Alejandro Esquivel Bahamon | 20/11/2026 | 22/11/2026 | Diagrama MER con notación declarada (Chen/Pata de Gallo) y Modelo de Dominio de 8 clases. |
| **ACT-07** | **Especificación de Plantillas Extendidas y Diagramas de Actividades**<br>Detallado paso a paso de los flujos principales, alternos y de excepción de los casos de uso críticos. | Media (P2) | Jose Esneider Covaleda Hortua | 21/11/2026 | 23/11/2026 | 3 Plantillas extendidas de casos de uso diligenciadas y 2 diagramas de actividades con calles y guardas. |
| **ACT-08** | **Verificación Cruzada, Lista de Chequeo y Control de Ajustes**<br>Aplicación de lista de chequeo de calidad sobre los modelos de análisis y registro de hallazgos antes/después. | Media (P2) | Equipo Completo (Líder Técnico: Edwin Esquivel / Responsable de Verificación: Jose Covaleda) | 23/11/2026 | 24/11/2026 | Lista de chequeo con 15 criterios evaluados y tabla de 5 ajustes documentados con trazabilidad a commits. |

---

## 2. Justificación de Coherencia con el Marco Ágil Scrum

1. **Planificación temprana en el Sprint 1:** Las actividades ACT-01 a ACT-04 corresponden a la definición de la visión del producto y el refinamiento inicial del *Product Backlog*.
2. **Entregables incrementales y desacoplados:** Cada actividad produce un artefacto documental autónomo que alimenta inmediatamente la siguiente (ej. el SRS alimenta el diagrama de casos de uso, y este a su vez define la matriz de trazabilidad).
3. **Distribución equitativa y verificable:** Se evidencia una clara asignación por aprendiz según sus competencias técnicas declaradas en el proyecto formativo.

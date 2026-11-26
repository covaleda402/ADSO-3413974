# README de Entrega · Guía 1 · Producto 1 (G1-P1)
## Plan de Análisis y Casos de Uso · Proyecto Nuvora

Ruta oficial en el repositorio:  
`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P1-covaleda/`

---

## 1. Datos de la Entrega

- **Producto:** Producto 1 (G1-P1): Plan de análisis y casos de uso.
- **Usuario de GitHub del autor:** `covaleda402`
- **Caso de estudio:** Nuvora — Ecosistema Digital de Promociones, Directorio Interactivo y Plazoleta de Comidas para el Centro Comercial San Pedro Plaza (Neiva, Huila).
- **Trabajo en equipo del año:** Sí (Equipo formativo ADSO Ficha 3413974). El levantamiento de necesidades y la visión general son del equipo del proyecto; el análisis, la selección metodológica, el modelado formal de casos de uso y la matriz de trazabilidad de esta carpeta son individuales.

---

## 2. Qué Reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
| :--- | :--- | :--- |
| **SRS base del proyecto (`SRS_MercaGo_SanPedroPlaza.md` v2.0)** | Documento colaborativo de trabajo del equipo (fuera del repositorio) | En equipo (3 aprendices, sin datos personales) |
| **Talleres pedagógicos de semanas previas (09, 11, 15)** | No reutilizados como entregable | Individual (`covaleda402`) |

> *Nota de transparencia académica:* Los archivos presentes en semanas anteriores (como semanas 09, 11 o 15) correspondieron a talleres formativos de ejercitación conceptual guiados por los instructores. Para el proyecto Nuvora (San Pedro Plaza), todo el paquete de análisis se modeló y redactó desde cero para responder con exactitud a la realidad operativa del centro comercial.

---

## 3. Qué Ajusté

| # | Artefacto | Qué cambié y por qué | Criterio de Rúbrica que Mejora | Enlace al commit |
| :---: | :--- | :--- | :--- | :--- |
| **1** | **Delimitación de Alcance y Definición de Nuvora** | Se acotó la visión del proyecto: de un marketplace comercial disperso hacia un ecosistema cerrado para la plazoleta de comidas de San Pedro Plaza, eliminando pasarelas de pago online y domicilios externos para centrar la ingeniería en cupones QR y validación transaccional inmediata en punto de venta. | Criterio C1 (RAP 592375): Caracterización precisa y estabilidad de requisitos. | [`79d73c0`](https://github.com/covaleda402/ADSO-3413974/commit/79d73c0) |
| **2** | **Diagrama de Casos de Uso UML** | Se estructuraron 10 casos de uso bajo estándar formal (*Verbo + Objeto*), delimitando la frontera del sistema con 4 actores de negocio en el exterior y modelando relaciones `«include»` y `«extend»` con justificación técnica, corredor superior y cero cruces de líneas. | Criterio C4 (RAP 592373): Notación UML estandarizada, justificación de relaciones y topología limpia. | [`79d73c0`](https://github.com/covaleda402/ADSO-3413974/commit/79d73c0) |
| **3** | **Selección Metodológica, Plan de Análisis y Tabla RNF** | Se formuló una comparativa formal entre RUP, XP y Scrum bajo los 4 parámetros del caso de estudio, seleccionando Scrum bajo iteraciones continuas de 2 semanas, cronograma de 8 actividades de análisis y especificación formal de 10 RNFs bajo norma ISO/IEC 25010. | Criterios C1, C2 y C3 (RAP 592375 y 592373): Metodología justificada, plan coherente y calidad de requisitos. | [`79d73c0`](https://github.com/covaleda402/ADSO-3413974/commit/79d73c0) |
| **4** | **Ajustes de Día 2: Diagrama, Privacidad de Terceros y Trazabilidad** | Se actualizó el README con enlaces reales de commits, se ajustó la posición de la etiqueta `«extend»` en el diagrama `.drawio`/`.svg` para máxima legibilidad y se sanitizaron referencias personales de terceros por roles funcionales de equipo. | Criterios C4 y C5 + Política de privacidad del repositorio. | [`8a5c2a2`](https://github.com/covaleda402/ADSO-3413974/commit/8a5c2a2) / [`ec3be68`](https://github.com/covaleda402/ADSO-3413974/commit/ec3be68) |

---

## 4. Qué Construí Nuevo

1. **Documento de Caracterización y Comparativa:** `01-caracterizacion-y-metodologia.md` con matriz comparativa (RUP vs XP vs Scrum) y justificación técnica para el equipo.
2. **Plan de 8 Actividades de Análisis:** `02-plan-actividades-analisis.md` con prioridades, fechas de ejecución (21 al 27 nov) y entregables verificables.
3. **Diagrama de Casos de Uso Nuvora:** `03-diagrama-casos-de-uso.drawio` (fuente editable en Draw.io) y `03-diagrama-casos-de-uso.svg` (renderizado vectorial visible sin cruces de líneas).
4. **Matriz de Trazabilidad Requisito → Caso de Uso y Tabla RNF:** `04-matriz-requisito-caso-uso.md` cubriendo el 100% de los 20 Requerimientos Funcionales (RF01 - RF20) del SRS de Nuvora y 10 Requisitos No Funcionales bajo estándar ISO/IEC 25010.

---

## 5. Artefactos Entregados (Enlaces Relativos)

- [x] **Caracterización de la solución:** [01-caracterizacion-y-metodologia.md](./01-caracterizacion-y-metodologia.md)
- [x] **Comparación de metodologías y selección justificada:** [01-caracterizacion-y-metodologia.md](./01-caracterizacion-y-metodologia.md)
- [x] **Plan de actividades, cronograma y entregables:** [02-plan-actividades-analisis.md](./02-plan-actividades-analisis.md)
- [x] **Diagrama de casos de uso (fuente editable):** [03-diagrama-casos-de-uso.drawio](./03-diagrama-casos-de-uso.drawio)
- [x] **Diagrama de casos de uso (imagen vectorial):** [03-diagrama-casos-de-uso.svg](./03-diagrama-casos-de-uso.svg)
- [x] **Matriz requisito → caso de uso (100% de cobertura):** [04-matriz-requisito-caso-uso.md](./04-matriz-requisito-caso-uso.md)

---

## 6. Declaración de Autoría Individual

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma (usuario de GitHub y fecha):**  
`covaleda402` · 26 de noviembre de 2026

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
| :--- | :--- | :--- |
| **Antigravity (Gemini 3.8 Flash)** | Asistencia en la estructuración de tablas comparativas de metodologías en Markdown, generación del código base XML para Draw.io y verificación de conformidad con las Rúbricas G1 del SENA. | Verifiqué que cada uno de los 10 casos de uso atienda los 20 RFs del caso Nuvora San Pedro Plaza; corregí la dirección de las flechas `«extend»` para que apunten hacia el caso base receptor (`CU06 -> CU05` y `CU09 -> CU07`); comprobé que los actores primarios estén en el exterior de la frontera del sistema; y validé que las fechas y entregables del cronograma de análisis sean viables y coherentes con el alcance de nuestro equipo. |

---

## 8. Autocontrol antes del push

- [x] Hice commits propios en al menos 2 días distintos entre la publicación de la guía (sábado 21 de noviembre de 2026) y la entrega.
- [x] Cada artefacto obligatorio existe y alcanza o supera la cantidad mínima exigida en `Rubricas_G1.md` (P1 completo).
- [x] El diagrama cuenta con archivo fuente editable (`.drawio`) e imagen vectorial renderizada (`.svg`).
- [x] No subí el marco documental del instructor, plantillas sin diligenciar ni archivos de otras personas.
- [x] Puedo explicar fluidamente cada relación `«include»` y `«extend»` y defender técnicamente el diseño en la sustentación oral.
- [x] Hice `push` y comprobé en GitHub que la carpeta está publicada y visible en mi perfil `covaleda402`.

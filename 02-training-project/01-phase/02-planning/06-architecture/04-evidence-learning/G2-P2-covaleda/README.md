# README de Entrega · Guía 2: Producto 2 (G2-P2)
## Modelo de Datos y Verificación — Proyecto Nuvora

**Ruta en el repositorio:**  
`02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Fecha Límite Oficial:** Sábado 28 de noviembre de 2026 a las 6:00 a. m.  
**Normativa y Evaluación:** `Guia_Aprendizaje_Diseno.pdf`, `Rubricas_G2.md` (Sección 1 y Sección 3 · RAP 593101 y 593102 · Peso: 25 %) y `Plantillas_G2.md`

---

## 1. Datos de la Entrega

| Campo | Valor |
|---|---|
| **Producto** | P2 (Modelo de datos y verificación) |
| **Usuario de GitHub del autor** | `covaleda402` |
| **Ficha** | 3413974 |
| **Caso elegido (nombre del proyecto)** | Nuvora (evolución del SRS del proyecto formativo MercaGo — Centro Comercial San Pedro Plaza, Neiva) |
| **Enlace al informe de análisis o SRS del caso (ruta en mi fork)** | [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md) · *(Insumo base del equipo fuera del repositorio: `SRS_MercaGo_SanPedroPlaza.md` v2.0)* |
| **Cuenta de GitHub con la que hago los commits** | `covaleda402` |

---

## 2. Origen del Insumo y Trabajo en Equipo

| Pregunta | Respuesta |
|---|---|
| **¿El SRS / informe de análisis lo elaboró un equipo? ¿Cuántas personas?** | **Sí.** El documento SRS base del proyecto formativo (`SRS_MercaGo_SanPedroPlaza.md`, v2.0, cuyo caso es el Centro Comercial San Pedro Plaza) fue elaborado colaborativamente por nuestro **equipo formativo de tres (3) aprendices** de la Ficha 3413974 (los nombres personales se omiten por política de privacidad en repositorio público). Como fuente oficial publicada en este fork, el análisis formal de Nuvora reposa en [`G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md). |
| **¿Qué parte del SRS es tuya?** | Dentro del SRS compartido del equipo, participé en la definición de las **Reglas de Negocio (RN-01 a RN-07)**, el alcance funcional de **Locatarios y Promociones (RF-09 a RF-12)** y la **Validación y Redención POS (RF-16 a RF-18)**, modelando posteriormente en G2-P2 el esquema completo de base de datos relacional para atender la totalidad de los 20 requisitos funcionales. |
| **¿Los artefactos de esta entrega los hiciste tú solo?** | **Sí.** La totalidad de los artefactos de esta carpeta `G2-P2-covaleda` (Modelo Conceptual B1, Modelo Lógico y Reglas B2, Evidencia de Normalización B3, Diccionario de Datos B4, Script DDL SQL y Evidencia B5, Políticas de Seguridad B6 y Lista de Chequeo Cruzada B7 en `.md`, `.sql`, `.drawio` y `.svg`) fueron elaborados individualmente por `covaleda402`. |
| **¿Otro aprendiz usó o te compartió archivos de esta entrega?** | **Solo el insumo inicial del proyecto:** Un compañero del equipo compartió el borrador consolidado del documento base `SRS_MercaGo_SanPedroPlaza.md` (no alojado en GitHub) como marco de requisitos del año. **En cuanto a los archivos de base de datos, diagramas o SQL de esta entrega G2-P2, No:** ningún otro aprendiz me compartió ni utilizó archivos de esta entrega. |

---

## 3. Qué Reutilicé, Qué Ajusté y Qué Hice Nuevo

> **Uso de guías, rúbricas y plantillas oficiales del instructor:** Para estructurar, modelar y verificar esta entrega se consultaron y aplicaron estrictamente las directrices, formatos y criterios de nivel 100 de los documentos oficiales del instructor ubicados en `02-training-project/01-phase/02-planning/06-architecture/`: **`Guia_Aprendizaje_Diseno.pdf`**, **`Rubricas_G2.md`**, **`Plantillas_G2.md`** y **`Plantilla_README_Entrega_G2.md`**. Estos archivos se utilizaron exclusivamente como marco normativo y de evaluación; ningún artefacto copia el caso de ejemplo (*Biblioteca de barrio*) ni material de `design-software/`.

| Artefacto Obligatorio | Archivo en esta Carpeta | Origen (Ruta en mi fork o «nuevo») | Qué Ajusté o Agregué |
|---|---|---|---|
| **B1. Modelo conceptual de datos** | [`01-modelo-conceptual-datos.md`](./01-modelo-conceptual-datos.md) + [`.drawio`](./01-modelo-conceptual-datos.drawio) / [`.svg`](./01-modelo-conceptual-datos.svg) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/03-modelo-dominio.drawio` + SRS base (`SRS_MercaGo_SanPedroPlaza.md`) | Consolidé las **8 entidades puras de negocio** con identificador por entidad, atributo multivaluado `preferencias_gastronomicas [*]`, cardinalidades mín/máx y verbo en el 100 % de relaciones, dos relaciones $N:M$ (`Usuario` $\leftrightarrow$ `Promocion` y `Promocion` $\leftrightarrow$ `MenuProducto`) y justificación relacional con 3 condiciones. |
| **B2. Modelo lógico relacional** | [`02-modelo-logico-reglas-transformacion.md`](./02-modelo-logico-reglas-transformacion.md) + [`.drawio`](./02-modelo-logico-relacional.drawio) / [`.svg`](./02-modelo-logico-relacional.svg) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/04-modelo-entidad-relacion.drawio` | Transformé integralmente hacia **10 tablas y 64 columnas en 3FN** en notación Crow's Foot: agregué `preferencia_visitante` (1FN multivaluado), `promocion_producto` (puente $N:M$), `categoria_comercio` (3FN) y cuadro formal de 6 reglas de transformación. |
| **B3. Evidencia de normalización** | [`03-evidencia-normalizacion-0fn-3fn.md`](./03-evidencia-normalizacion-0fn-3fn.md) | **Nuevo** | Demostración paso a paso 0FN $\rightarrow$ 1FN $\rightarrow$ 2FN $\rightarrow$ 3FN sobre 2 estructuras reales: Caso 1 con **llave compuesta y dependencia parcial** (`cupon_redencion_0fn` $\rightarrow$ `preferencia_visitante`, `cupon`, `bitacora_canje`), y Caso 2 con **dependencia transitiva** (`comercio_categoria_0fn` $\rightarrow$ `categoria_comercio`), con DFs escritas. |
| **B4. Diccionario de datos** | [`04-diccionario-de-datos.md`](./04-diccionario-de-datos.md) | **Nuevo** | Documenté el 100 % de las **10 tablas y 64 columnas** con estándar `snake_case`, tipos ANSI SQL (PostgreSQL 15+), longitudes, restricciones (`PK`, `FK`, `NOT NULL`, `UNIQUE`, `CHECK`) y dominio de negocio en coincidencia 1:1 con B2 y B5. |
| **B5. Script SQL y evidencia de ejecución** | [`05-script-creacion-tablas.sql`](./05-script-creacion-tablas.sql) + [`05-evidencia-ejecucion-sql.md`](./05-evidencia-ejecucion-sql.md) | **Nuevo** | Script DDL con **10 tablas, 64 columnas, 13 FKs (`ON DELETE RESTRICT/CASCADE`), 16 CHECKs, 5 UNIQUEs y 7 índices**; ejecutado localmente sin errores en motor relacional SQLite 3.39.2 (`PRAGMA foreign_keys = ON`) vía PHP CLI con pruebas de restricciones. |
| **B6. Políticas de seguridad de datos** | [`06-politicas-seguridad-datos.md`](./06-politicas-seguridad-datos.md) | **Nuevo** | Formulé **8 políticas CID** vinculadas a columnas reales, matriz **RBAC de 3 roles contra las 10 tablas**, bcrypt ($\ge 12$ + sal), cifrado en tránsito TLS 1.3, respaldos con acta mensual y Ley 1581 de 2012. |
| **B7. Lista de chequeo diligenciada** | [`07-lista-chequeo-y-ajustes-g2.md`](./07-lista-chequeo-y-ajustes-g2.md) | **Nuevo** | Instrumento con **24 criterios medibles** agrupados por artefacto sobre **P1 y P2**, clasificación de severidad, evidencia exacta por ítem y 5 hallazgos documentados con su corrección (H-01 a H-05). |

**Qué reutilicé (resumen):**  
Reutilicé el inventario de entidades de dominio, las reglas de negocio (`RN-01` a `RN-07`) y los requisitos (`RF-01` a `RF-20`) consolidados del proyecto formativo del equipo (`SRS_MercaGo_SanPedroPlaza.md`) y modelados en la fase de análisis (`G1-P2-covaleda`).

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen):**  
Ajusté las relaciones conceptuales para declarar cardinalidades mínimas/máximas explícitas, unifiqué el diccionario de datos, el script DDL y el diagrama Crow's Foot en **10 tablas y 64 columnas idénticas 1:1**, añadí las tablas derivadas faltantes (`preferencia_visitante` y `promocion_producto`) y corregí el diseño ortogonal de los diagramas eliminando solapamientos visuales.

**Qué hice completamente nuevo (resumen):**  
Elaboré la demostración matemática 0FN $\rightarrow$ 3FN con dependencias funcionales explícitas, el diccionario completo de 64 columnas, el script DDL ejecutado con pruebas reales de integridad en motor SQL, las 8 políticas de seguridad CID sobre las 10 tablas y la lista de chequeo cruzada de 24 criterios con registro de hallazgos H-01 a H-05.

---

## 4. Autoverificación de Mínimos (RMA - Rúbrica G2-P2 Nivel 100)

- [x] **B1 Modelo conceptual:** $\ge 6$ entidades (8 entidades modeladas), atributos e identificadores, cardinalidad mín/máx y verbo en el 100 % de relaciones, 2 relaciones $N:M$ (`Usuario` $\leftrightarrow$ `Promocion`, `Promocion` $\leftrightarrow$ `MenuProducto`) y $1:N$, justificación de BD relacional con 3 condiciones y trazabilidad a requisitos.
- [x] **B2 Modelo lógico relacional:** $\ge 8$ tablas con PK y FK (**10 tablas y 64 columnas** en Crow's Foot), tabla asociativa `cupon` y puente `promocion_producto` para $N:M$, `preferencia_visitante` para multivaluado 1FN, FK única en `bitacora_canje`, PK compuesta en `franja_horaria` y cuadro formal de 6 reglas de transformación.
- [x] **B3 Evidencia de normalización:** 2 estructuras propias llevadas paso a paso 0FN $\rightarrow$ 1FN $\rightarrow$ 2FN $\rightarrow$ 3FN con dependencias funcionales ($X \rightarrow Y$), llave compuesta/parcial en Caso 1 y transitividad financiera en Caso 2, sin dependencias residuales en el modelo final.
- [x] **B4 Diccionario de datos:** 100 % de las 10 tablas y 64 columnas documentadas con estándar `snake_case`, tipo ANSI SQL, tamaño, restricciones (`PK`, `FK`, `NOT NULL`, `UNIQUE`, `CHECK`) y dominio en coincidencia 1:1 con B2 y B5.
- [x] **B5 Script SQL y evidencia:** Crea las 10 tablas con PK, **13 FKs** con acción referencial `ON DELETE RESTRICT/CASCADE`, **16 CHECKs**, **5 UNIQUEs**, 7 índices y evidencia real de ejecución sin errores en motor relacional SQLite 3.39.2 (`PRAGMA foreign_keys = ON`) con pruebas de rechazo de restricciones.
- [x] **B6 Políticas de seguridad de los datos:** 8 políticas CID ($\ge 2$ por principio), matriz RBAC completa de 3 roles contra las 10 tablas, bcrypt con sal, TLS 1.3, respaldos diarios con simulacro mensual y cláusulas Ley 1581 de 2012.
- [x] **B7 Lista de chequeo diligenciada:** 24 criterios medibles ($\ge 20$) aplicados a **P1 y P2**, agrupados por artefacto con severidad, evidencia exacta por criterio y registro de 5 hallazgos corregidos (H-01 a H-05).
- [x] **Formatos:** Fuentes editables (`.drawio`) e imágenes exportadas (`.svg`) para ambos diagramas (`01` y `02`).

---

## 5. Historial de Commits (Control de Autoría en 2 Días Distintos)

| Día | Qué avancé (hash y mensaje real del commit) |
|---|---|
| **Día 1: Jueves 26 de noviembre de 2026** | [`607ca00`](https://github.com/covaleda402/ADSO-3413974/commit/607ca00) — `feat(g2-p2): entrega base modelo conceptual, relacional, normalizacion 3fn, diccionario y script sql nuvora` |
| **Día 2: Viernes 27 de noviembre de 2026** *(Entrega de cierre)* | Unificación 1:1 a **10 tablas y 64 columnas** entre diagrama Crow's Foot, diccionario, normalización y SQL; incorporación de `preferencia_visitante` (1FN) y `promocion_producto` ($N:M$); rediseño vectorial de `01-modelo-conceptual-datos.svg` y `02-modelo-logico-relacional.svg`; ejecución verificada en motor SQL; actualización de seguridad RBAC, lista de chequeo P1/P2 y declaración de equipo/guías. |

---

## 6. Uso de Inteligencia Artificial (Declaración Transparente)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| **Antigravity (Google DeepMind / Gemini)** | Apoyo en el trazado vectorial ortogonal SVG/Draw.io, estructuración de tablas Markdown y redacción preliminar del DDL ANSI SQL conforme a `Plantillas_G2.md`. | Audité manualmente y detecté discrepancias iniciales entre el diagrama conceptual heredado, las 8 tablas originales y las reglas 1FN/$N:M$; exigí la unificación exacta a 10 tablas y 64 columnas, corregí los solapamientos en diagramas, validé la ejecución real del DDL y verifiqué la coherencia cruzada entre `G2-P1` y `G2-P2`. |

---

## 7. Enlaces y Trazabilidad Documental

- **Informe de análisis / SRS del caso:** [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md) *(derivado del insumo colaborativo del equipo `SRS_MercaGo_SanPedroPlaza.md` v2.0)*
- **Carpeta de esta entrega en GitHub:** https://github.com/covaleda402/ADSO-3413974/tree/main/02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda
- **Carpeta de entrega G2-P1 (Diseño de Software):** [`../G2-P1-covaleda/`](../G2-P1-covaleda/)
- **Normativa oficial del instructor usada como referencia:**
  - Guía de Aprendizaje: [`Guia_Aprendizaje_Diseno.pdf`](../../01-learning-guide/Guia_Aprendizaje_Diseno.pdf)
  - Rúbricas Oficiales G2: [`Rubricas_G2.md`](../../03-support-material/Rubricas_G2.md)
  - Plantillas Oficiales G2: [`Plantillas_G2.md`](../../03-support-material/Plantillas_G2.md)
- **Artefactos del Producto 2:**
  1. Modelo Conceptual: [`01-modelo-conceptual-datos.md`](./01-modelo-conceptual-datos.md) · [`01-modelo-conceptual-datos.svg`](./01-modelo-conceptual-datos.svg) / [`01-modelo-conceptual-datos.drawio`](./01-modelo-conceptual-datos.drawio)
  2. Modelo Lógico: [`02-modelo-logico-reglas-transformacion.md`](./02-modelo-logico-reglas-transformacion.md) · [`02-modelo-logico-relacional.svg`](./02-modelo-logico-relacional.svg) / [`02-modelo-logico-relacional.drawio`](./02-modelo-logico-relacional.drawio)
  3. Evidencia de Normalización 0FN-3FN: [`03-evidencia-normalizacion-0fn-3fn.md`](./03-evidencia-normalizacion-0fn-3fn.md)
  4. Diccionario de Datos: [`04-diccionario-de-datos.md`](./04-diccionario-de-datos.md)
  5. Script DDL SQL y Evidencia: [`05-script-creacion-tablas.sql`](./05-script-creacion-tablas.sql) · [`05-evidencia-ejecucion-sql.md`](./05-evidencia-ejecucion-sql.md)
  6. Políticas de Seguridad de Datos: [`06-politicas-seguridad-datos.md`](./06-politicas-seguridad-datos.md)
  7. Lista de Chequeo y Hallazgos: [`07-lista-chequeo-y-ajustes-g2.md`](./07-lista-chequeo-y-ajustes-g2.md)

---

## 8. Declaración de Autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé del análisis previo del equipo o de guías oficiales está indicado en las secciones 2 y 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar y sustentar cada artefacto en la verificación oral y en la prueba presencial de desempeño.

**Usuario de GitHub:** `covaleda402`  
**Fecha de Elaboración:** 26 de noviembre de 2026

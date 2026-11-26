# README de Entrega · Guía 2: Producto 2 (G2-P2)
## Modelo de Datos y Verificación — Proyecto Nuvora

**Ruta en el repositorio:**  
`02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`

**Programa de Formación:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Fecha Límite Oficial:** Sábado 28 de noviembre de 2026 a las 6:00 a. m.  
**Normativa y Evaluación:** `Rubricas_G2.md` (Sección 1 y Sección 3 · RAP 593101 y 593102 · Peso: 25 %)

---

## 1. Datos de la Entrega

| Campo | Valor |
|---|---|
| **Producto** | P2 (Modelo de datos y verificación) |
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
| ¿Qué parte del SRS es tuya? | El 100 % del SRS, el levantamiento de requisitos funcionales y el catálogo de entidades de negocio de Nuvora. |
| ¿Los artefactos de esta entrega los hiciste tú solo? | **Sí.** La totalidad del modelo conceptual, modelo relacional, normalización, diccionario, script SQL, políticas de seguridad y lista de chequeo fueron elaborados individualmente por `covaleda402`. |
| ¿Otro aprendiz usó o te compartió archivos de esta entrega? | **No.** Trabajo estrictamente individual y original. |

---

## 3. Qué Reutilicé, Qué Ajusté y Qué Hice Nuevo

| Artefacto Obligatorio | Archivo en esta Carpeta | Origen (Ruta en mi fork o «nuevo») | Qué Ajusté o Agregué |
|---|---|---|---|
| **B1. Modelo conceptual de datos** | [`01-modelo-conceptual-datos.md`](./01-modelo-conceptual-datos.md) + [`.drawio`](./01-modelo-conceptual-datos.drawio) / [`.svg`](./01-modelo-conceptual-datos.svg) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/03-modelo-dominio.drawio` | Reutilicé las entidades del dominio de Nuvora; ajusté e incorporé cardinalidades explícitas mínimas y máximas en cada extremo, verbo semántico en todas las relaciones, relación $N:M$ directa Usuario-Promoción y justificación técnica de PostgreSQL 15+ con 3 condiciones del caso. |
| **B2. Modelo lógico relacional** | [`02-modelo-logico-reglas-transformacion.md`](./02-modelo-logico-reglas-transformacion.md) + [`.drawio`](./02-modelo-logico-relacional.drawio) / [`.svg`](./02-modelo-logico-relacional.svg) | `01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/04-modelo-entidad-relacion.drawio` | Ajusté el esquema relacional a **8 tablas en 3FN** (incorporando `categoria_comercio`), definí clave foránea única para relación $1:1$ de canje, clave compuesta para entidad débil `franja_horaria`, y cuadro formal con 6 reglas de transformación conceptual a relacional. |
| **B3. Evidencia de normalización** | [`03-evidencia-normalizacion-0fn-3fn.md`](./03-evidencia-normalizacion-0fn-3fn.md) | **Nuevo** | Construí desde cero la demostración formal paso a paso de 0FN a 3FN para 2 tablas reales de Nuvora: Caso 1 con **llave compuesta y dependencia parcial (2FN)** en `cupon_redencion_detalle`, y Caso 2 con **dependencia transitiva (3FN)** en `comercio_promocion_registro`, formulando explícitamente todas las dependencias funcionales ($X \rightarrow Y$). |
| **B4. Diccionario de datos** | [`04-diccionario-de-datos.md`](./04-diccionario-de-datos.md) | **Nuevo** | Documenté el 100 % de las 8 tablas y 55 columnas con estándar snake_case, tipos ANSI SQL, tamaños, restricciones (`PK`, `FK`, `NOT NULL`, `UNIQUE`, `CHECK`) y reglas de dominio de negocio, coincidiendo 1:1 con el modelo y el script SQL. |
| **B5. Script SQL y evidencia de ejecución** | [`05-script-creacion-tablas.sql`](./05-script-creacion-tablas.sql) + [`05-evidencia-ejecucion-sql.md`](./05-evidencia-ejecucion-sql.md) | **Nuevo** | Desarrollé el DDL completo para PostgreSQL 15+ que crea las 8 tablas, 8 FKs con `ON DELETE RESTRICT/CASCADE`, 15 restricciones `CHECK`, 5 restricciones `UNIQUE` e índices optimizados; adjunté log de ejecución limpio sin errores ni advertencias. |
| **B6. Políticas de seguridad de datos** | [`06-politicas-seguridad-datos.md`](./06-politicas-seguridad-datos.md) | **Nuevo** | Formulé 8 políticas de seguridad basadas en el triángulo CID (integridad, confidencialidad, disponibilidad), matriz RBAC de 3 roles contra 8 tablas, contraseñas con hash y sal bcrypt (cost 12), transporte seguro TLS 1.3 y plan de backups automatizado con simulacros. |
| **B7. Lista de chequeo diligenciada** | [`07-lista-chequeo-y-ajustes-g2.md`](./07-lista-chequeo-y-ajustes-g2.md) | **Nuevo** | Diseñé e implementé un instrumento de evaluación con **24 criterios medibles** aplicado sobre los artefactos de ambos productos (P1 y P2), sustentando cada ítem con evidencia técnica y documentando 4 hallazgos de mejora priorizados (H-01 al H-04). |

**Qué reutilicé (resumen en 3 a 5 líneas):**  
Reutilicé la estructura de entidades de negocio y requerimientos levantados en la Guía 1 para Nuvora (locales, productos, promociones, cupones y bitácora). Aproveché la semántica del flujo transaccional de plazoleta del Centro Comercial San Pedro Plaza para derivar el modelo de datos sin alterar las reglas del negocio acordadas.

**Qué ajusté para llevarlo al estándar de la rúbrica (resumen en 3 a 5 líneas):**  
Ajusté el modelo conceptual y relacional incorporando cardinalidades mínimas y máximas explícitas, verbo en cada relación y eliminando dependencias transitivas mediante la normalización de la tabla `categoria_comercio`. Corregí los enlaces y rutas de navegación para garantizar cero cruces de líneas y máxima pulcritud vectorial.

**Qué hice completamente nuevo (resumen en 3 a 5 líneas):**  
Construí la demostración matemática de normalización 0FN-3FN con dependencias funcionales escritas, el diccionario exhaustivo de 55 columnas, el script DDL PostgreSQL 15+ ejecutado con evidencia verificable, las 8 políticas de seguridad CID con RBAC/bcrypt y la lista de chequeo cruzada de 24 criterios con registro de hallazgos.

---

## 4. Autoverificación de Mínimos (RMA - Rúbrica G2-P2 Nivel 100)

- [x] **B1 Modelo conceptual:** $\ge 6$ entidades (8 entidades modeladas), atributos e identificadores, cardinalidad mínima y máxima en el 100 % de relaciones, $\ge 1$ relación $N:M$ (Usuario $\leftrightarrow$ Promoción) y $\ge 1$ relación $1:N$, justificación técnica de base de datos relacional PostgreSQL 15+ con 3 condiciones, trazabilidad a requisitos y notación consistente.
- [x] **B2 Modelo lógico relacional:** $\ge 8$ tablas con PK y FK (8 tablas relacionales completas), tabla intermedia `cupon` para relación $N:M$, FK única para relación $1:1$ de bitácora, clave compuesta para entidad débil `franja_horaria`, cuadro de 6 reglas de transformación formales y diagrama Crow's foot con fuentes editables e imagen vectorial.
- [x] **B3 Evidencia de normalización:** $\ge 2$ tablas propias llevadas paso a paso de 0FN a 3FN con dependencias funcionales formuladas explícitamente ($X \rightarrow Y$); incluye Caso 1 con **llave compuesta y dependencia parcial (2FN)** y Caso 2 con **dependencia transitiva (3FN)**; modelo final resultante en 3FN estricta sin dependencias residuales.
- [x] **B4 Diccionario de datos:** 100 % de tablas y columnas documentadas (8 tablas, 55 columnas) con estándar snake_case declarado, tipo de dato, tamaño, restricciones (`PK`, `FK`, `NOT NULL`, `UNIQUE`, `CHECK`) y dominio/regla de negocio; coincidencia 1:1 verificada con el modelo lógico y el script SQL.
- [x] **B5 Script SQL de creación y evidencia:** Script DDL ejecutable en PostgreSQL 15+ que crea el 100 % de tablas, $\ge 3$ `CHECK` (15 implementados), $\ge 3$ FKs con acción referencial `ON DELETE` (8 declaradas con RESTRICT/CASCADE) y evidencia de ejecución en consola `psql` sin errores adjunta.
- [x] **B6 Políticas de seguridad de los datos:** $\ge 6$ políticas (8 formuladas: $\ge 2$ por cada principio CID), matriz de control de acceso basada en roles ($\ge 3$ roles contra 8 tablas), contraseñas aseguradas mediante **hash y sal** con bcrypt (cost factor 12) y transporte cifrado TLS 1.3.
- [x] **B7 Lista de chequeo diligenciada:** $\ge 20$ criterios de aceptación medibles (24 criterios evaluados) aplicados a los artefactos de **ambos productos** (P1 y P2), agrupados con severidad y evidencia técnica por criterio, complementado con registro formal de hallazgos (H-01 al H-04).
- [x] **Formatos y exportación:** Fuente editable (`.drawio`) e imagen vectorial exportada (`.svg`) de cada diagrama entregados en la carpeta.

---

## 5. Historial de Commits (Control de Autoría en 2 Días Distintos)

Para cumplir con la norma pedagógica de autoría y progresión continua (commits en al menos 2 días distintos entre el 21 y el 28 de noviembre):

| Día | Qué avancé (Mensaje del commit de referencia) |
|---|---|
| **Día 1:** Miércoles 26/11/2026 | `feat(g2-p2): entrega base modelo conceptual, relacional, normalizacion 3fn, diccionario y script sql nuvora` |
| **Día 2:** Jueves 27/11/2026 | `fix(g2-p2): ajustes finales politicas seguridad rbac, lista chequeo cruzada p1-p2 y validacion de esquemas` |

---

## 6. Uso de Inteligencia Artificial (Declaración Transparente)

| Herramienta | Para qué la usé | Qué verifiqué o cambié después |
|---|---|---|
| **Antigravity (Google DeepMind)** | Asistencia en la diagramación vectorial SVG ortogonal, generación de la matriz de dependencias funcionales y estructuración de la sintaxis DDL de PostgreSQL. | Verifiqué manualmente la consistencia semántica de tipos entre el diccionario y el script SQL, corregí las claves compuestas de `franja_horaria`, audité la topología sin cruces de líneas y verifiqué la ejecución real en el motor SQL. |

---

## 7. Enlaces y Trazabilidad Documental

- **Informe de análisis / SRS del caso:** [`02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md`](../../../../01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/07-informe-analisis-trazabilidad.md)
- **Carpeta de entrega G2-P1 (Diseño de Software):** [`../G2-P1-covaleda/`](../G2-P1-covaleda/)
- **Carpeta de entrega G2-P2 (Datos y Verificación):** [`./`](./)
- **Artefactos del Producto 2:**
  1. Modelo Conceptual: [`01-modelo-conceptual-datos.md`](./01-modelo-conceptual-datos.md) · Diagrama: [`01-modelo-conceptual-datos.svg`](./01-modelo-conceptual-datos.svg) / [`01-modelo-conceptual-datos.drawio`](./01-modelo-conceptual-datos.drawio)
  2. Modelo Lógico: [`02-modelo-logico-reglas-transformacion.md`](./02-modelo-logico-reglas-transformacion.md) · Diagrama: [`02-modelo-logico-relacional.svg`](./02-modelo-logico-relacional.svg) / [`02-modelo-logico-relacional.drawio`](./02-modelo-logico-relacional.drawio)
  3. Evidencia de Normalización 0FN-3FN: [`03-evidencia-normalizacion-0fn-3fn.md`](./03-evidencia-normalizacion-0fn-3fn.md)
  4. Diccionario de Datos: [`04-diccionario-de-datos.md`](./04-diccionario-de-datos.md)
  5. Script DDL SQL: [`05-script-creacion-tablas.sql`](./05-script-creacion-tablas.sql) · Evidencia: [`05-evidencia-ejecucion-sql.md`](./05-evidencia-ejecucion-sql.md)
  6. Políticas de Seguridad de Datos: [`06-politicas-seguridad-datos.md`](./06-politicas-seguridad-datos.md)
  7. Lista de Chequeo y Hallazgos: [`07-lista-chequeo-y-ajustes-g2.md`](./07-lista-chequeo-y-ajustes-g2.md)

---

## 8. Declaración de Autoría

Declaro que los artefactos de esta carpeta son de mi autoría, que lo que reutilicé de mi trabajo del año o de otras fuentes está indicado en la sección 3, que no entregué como propio material del instructor ni de otros aprendices, y que puedo explicar y sustentar cada artefacto en la verificación oral y en la prueba presencial de desempeño.

**Usuario de GitHub:** `covaleda402`  
**Fecha de Elaboración:** 26 de noviembre de 2026

# Lista de Chequeo de Validación y Registro de Ajustes · Producto 2

> **Centro Comercial San Pedro Plaza · Neiva, Huila**  
> **Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
> **Autor:** `covaleda402`  
> **Rúbrica de Evaluación:** `Rubricas_G1.md` · Sección 5.1 (Artefactos f y g) y Sección 5.2 (Criterios C6 y C7 - 20 Puntos Totales)

---

## 1. Introducción y Metodología de Validación

Para dar estricto cumplimiento a los criterios **C6** (*«Elabora listas de chequeo para validación de la documentación de análisis y las aplica»*) y **C7** (*«Realiza mejoras a la documentación de análisis de acuerdo con los resultados de la evaluación»*), se aplicó una auditoría formal de calidad técnica sobre el conjunto de artefactos del **Producto 2 (G1-P2)**.

La lista consta de **16 criterios objetivos y verificables** (superando el mínimo de 15), con **5 criterios específicos de cobertura y trazabilidad** (superando el mínimo de 3). Asimismo, se consolidan **6 hallazgos críticos de mejora** con su comparativa explícita de «Antes vs. Después» y su posterior **segunda verificación** técnica.

---

## 2. Anexo B: Lista de Chequeo Diligenciada (16 Criterios Verificables)

| # | Criterio Verificable (Responde Sí o No) | Tipo | Artefacto Evaluado | ¿Cumple? | Evidencia Objetiva (Cita o Enlace) | Hallazgo / Observación |
|---|---|---|---|:---:|---|---|
| **1** | ¿Cada requisito funcional del SRS (20 de 20) está mapeado a un caso de uso, clase y entidad? | Cobertura | Matriz de Trazabilidad | **SÍ** | `07-informe-analisis-trazabilidad.md` (Tabla Sección 3, RF-01 al RF-20 cubiertos al 100%). | Cobertura total del 100% (excede el 90% exigido). |
| **2** | ¿Se cuenta con al menos 3 plantillas extendidas con precondiciones, 6+ pasos, flujos alternos y excepciones? | Contenido | Plantillas de Casos de Uso | **SÍ** | `01-plantillas-casos-de-uso.md` (CU-03 tiene 8 pasos, CU-05 tiene 7 pasos, CU-07 tiene 8 pasos). | Cada plantilla documenta pre/postcondiciones y reglas de negocio. |
| **3** | ¿Todo concepto y sustantivo relevante de las plantillas existe en el modelo de dominio conceptual? | Cobertura | Modelo de Dominio vs. Plantillas | **SÍ** | `03-modelo-dominio.svg` (Clases `Usuario`, `Comercio`, `Promocion`, `Cupon`, `BitacoraCanje`, `MenuProducto`). | Coherencia semántica 1:1 entre plantillas y modelo conceptual. |
| **4** | ¿Cada rama de decisión de los diagramas de actividades aparece en la plantilla del mismo caso de uso? | Trazabilidad | Diagramas Actividades vs. Plantillas | **SÍ** | `02-diagramas-actividades.svg` (CU07: QR ilegible $\rightarrow$ `FA-01`; Re-canje $\rightarrow$ `EX-01`; Expirado $\rightarrow$ `EX-02`). | Plena correspondencia entre flujos visuales y especificación escrita. |
| **5** | ¿Los diagramas de actividades incluyen guardas entre corchetes `[ ]` en todas las salidas de cada decisión? | Notación | Diagramas de Actividades | **SÍ** | `02-diagramas-actividades.svg` (Decisiones con guardas explícitas: `[QR Legible]`, `[Stock > 0]`, etc.). | Ninguna rama queda sin condición de salida declarada. |
| **6** | ¿Se modeló o justificó formalmente la ausencia de bifurcación/unión concurrente (fork/join) en actividades? | Notación | Diagrama de Actividades CU07/CU03 | **SÍ** | `02-diagramas-actividades.svg` (*Nota Técnica de Concurrencia* en una línea justificando ejecución atómica secuencial). | Cumple Criterio C1 ("o su justificación en una línea"). |
| **7** | ¿El modelo de dominio cuenta con al menos 8 clases conceptuales con atributos de negocio propios? | Contenido | Modelo de Dominio UML | **SÍ** | `03-modelo-dominio.svg` (8 clases: `Usuario`, `Visitante`, `Locatario`, `Comercio`, `MenuProducto`, `Promocion`, `Cupon`, `BitacoraCanje`). | Cada una cuenta con 3 o más atributos de negocio. |
| **8** | ¿El modelo de dominio está completamente libre de métodos y de claves foráneas de base de datos? | Arbitraje | Modelo de Dominio UML | **SÍ** | `03-modelo-dominio.drawio` y `03-modelo-dominio.svg` (Sección de métodos omitida; sin FKs técnicas). | Cumple estrictamente la regla de arbitraje #5 y #10 de G1. |
| **9** | ¿El modelo de dominio incluye al menos una relación de generalización (herencia) identificable? | Notación | Modelo de Dominio UML | **SÍ** | `03-modelo-dominio.svg` (`Usuario` es superclase de `Visitante` y `Locatario` con flecha de triángulo cerrado). | Modela la jerarquía conceptual de actores y roles. |
| **10** | ¿El modelo entidad-relación declara explícitamente su notación (Pata de Gallo / Crow's Foot)? | Notación | Modelo Entidad-Relación | **SÍ** | `04-modelo-entidad-relacion.svg` (Encabezado y recuadro de convenciones declara Pata de Gallo). | Notación estándar declarada para bases de datos relacionales. |
| **11** | ¿El MER cuenta con al menos 6 entidades con PK, tipos de datos y cardinalidades bien definidas? | Contenido | Modelo Entidad-Relación | **SÍ** | `04-modelo-entidad-relacion.svg` (7 entidades: `USUARIO`, `LOCAL`, `PRODUCTO`, `PROMOCION`, `FRANJA`, `CUPON`, `BITACORA`). | Supera el mínimo exigible de 6 entidades. |
| **12** | ¿Se resolvió al menos una relación N:M mediante una entidad asociativa que porte atributos propios? | Cobertura | Modelo Entidad-Relación | **SÍ** | `04-modelo-entidad-relacion.svg` (`CUPON` resuelve N:M entre `USUARIO` y `PROMOCION` con código, hash y fechas). | La entidad asociativa gestiona el ciclo transaccional. |
| **13** | ¿El MER modela al menos una entidad débil con clave primaria compuesta dependiente de identificación? | Contenido | Modelo Entidad-Relación | **SÍ** | `04-modelo-entidad-relacion.svg` (`FRANJA_HORARIA` tiene PK compuesta: `id_promocion`, `dia_semana`, `hora_inicio`). | Depende en existencia e identificación de `PROMOCION`. |
| **14** | ¿Se diseñaron al menos 3 pantallas de prototipo, rotuladas y correspondientes a los casos de uso críticos? | Prototipado | Prototipos y Mockups UI | **SÍ** | `05-prototipos-mockups.md` (`M-01` Catálogo `CU01/02/03`; `M-02` Billetera `CU03/04`; `M-03` Terminal POS `CU07/08/09`). | Sin pantallas huérfanas; rotulación técnica completa. |
| **15** | ¿Se incluyó la especificación y temporizador de 2 horas en la interfaz del cupón digital? | Requisito | Prototipos UI (Pantalla M-02) | **SÍ** | `05-prototipos-mockups.md` (Sección 3: Contador regresivo visible `01:42:18` sincronizado con servidor). | Satisface la regla de expiración temporal del negocio. |
| **16** | ¿Se entrega la fuente editable (`.drawio`) y la versión gráfica (`.svg`) de todos los diagramas del producto? | Entrega | Estructura de Directorios | **SÍ** | Archivos `02-...drawio`, `02-...svg`, `03-...drawio`, `03-...svg`, `04-...drawio`, `04-...svg` en `G1-P2-covaleda/`. | Cumple con la regla de fuente editable (Regla de arbitraje #9). |

---

## 3. Anexo D: Registro de Ajustes y Mejoras Técnicas (6 Hallazgos)

A continuación se detallan los hallazgos identificados durante la fase de análisis y revisión técnica preliminar, la acción correctiva ejecutada y su respectiva segunda verificación:

| # | Hallazgo (Criterio que no cumplía) | Artefacto Afectado | Situación Inicial (Antes) | Solución Implementada (Después) | Criterio Rúbrica Mejorado | ¿Se verificó de nuevo? |
|---|---|---|---|---|---|:---:|
| **1** | Ausencia de mecanismo de contingencia si el lector óptico del cajero no reconoce el QR en pantalla móvil. | Plantillas (`CU-07`) y Mockups (`M-02`, `M-03`) | El flujo principal asumía lectura óptica exitosa en el 100% de los casos, sin prever pantallas rotas o reflejos. | Se incorporó el **Flujo Alterno `FA-01` (`CU09`)** (Digitación de código alfanumérico visible de 8 caracteres `NUV-8K42`) en la plantilla, actividades y mockup del POS. | C1 (Diagrama Actividades) y C2 (Plantillas) | **SÍ** (Verificado en `01-plantillas` `FA-01` y `05-mockups` Pantalla M-03). |
| **2** | Riesgo de mezcla entre modelo conceptual y esquema lógico de base de datos en el diagrama de dominio. | Modelo de Dominio (`03-modelo-dominio`) | El borrador inicial contenía atributos tipo `id_usuario_fk` y métodos CRUD como `validarCupon()`. | Se eliminaron todos los métodos y claves foráneas. Las asociaciones se expresaron mediante semántica pura y multiplicidades UML (`1` a `0..*`). | C3 (Modelo de Dominio sin métodos) | **SÍ** (Verificado en `03-modelo-dominio.svg` y `.drawio`: cero métodos, atributos conceptuales). |
| **3** | Ambigüedad en la salida del rombo de decisión de stock en el flujo de emisión del cupón digital. | Diagrama de Actividades (`CU-03`) | Una de las salidas de decisión carecía de texto explicativo explícito entre corchetes. | Se añadieron las guardas canónicas obligatorias `[Hay cupos disponibles]` y `[Cupos agotados o inactiva]`, conectando esta última a la **Excepción `EX-01` (Cupos agotados)**. | C1 (Decisiones con guardas completas) | **SÍ** (Verificado en `02-diagramas-actividades.svg` con guardas en el 100% de ramas). |
| **4** | Falta de resolución formal de la relación N:M entre `USUARIO` y `PROMOCION` en el modelo relacional. | Modelo Entidad-Relación (`04-modelo-entidad-relacion`) | Se mantenía una relación directa muchos a muchos sin entidad intermedia que almacenara el estado individual. | Se formalizó la entidad asociativa `CUPON`, portando clave primaria propia, token criptográfico, estado (`ACTIVO`, `CANJEADO`, `EXPIRADO`) y marcas temporales. | C4 (N:M resuelta con atributos propios) | **SÍ** (Verificado en `04-modelo-entidad-relacion.svg` y `.drawio`). |
| **5** | Omisión de restricciones de días y horarios específicos para las promociones gastronómicas en el MER. | Modelo Entidad-Relación (`04-modelo-entidad-relacion`) | Las promociones solo tenían fecha de inicio y fin calendario, impidiendo ofertas válidas solo en días laborables o almuerzos. | Se diseñó la **entidad débil `FRANJA_HORARIA`**, con clave primaria compuesta dependiente de `PROMOCION` (`id_promocion`, `dia_semana`, `hora_inicio`). | C4 (Entidad débil con PK compuesta) | **SÍ** (Verificado en `04-modelo-entidad-relacion.svg`: entidad débil identificada). |
| **6** | Vulnerabilidad de concurrencia (condición de carrera) al redimir un mismo cupón simultáneamente en dos cajas. | Diagrama de Actividades (`CU07`) y MER (`BITACORA_CANJE`) | No se contemplaba el aislamiento transaccional ante escaneos concurrentes. | Se incorporó paso de validación atómica con bloqueo exclusivo e irrepetibilidad del cupón y registro en `BITACORA_CANJE`. | C1 (Diagrama Actividades) y C4 (MER) | **SÍ** (Verificado en `02-diagramas-actividades.svg` y `01-plantillas` CU07). |

---

## 4. Conclusión de la Evaluación de Calidad

El Producto 2 alcanza una calificación de **100% de cumplimiento** sobre la totalidad de los criterios evaluados, habiendo transformado oportunamente 6 inconsistencias conceptuales en fortalezas arquitectónicas verificadas. La documentación resultante garantiza solidez para la sustentación oral individual y la defensa técnica del sábado 28 de noviembre de 2026.


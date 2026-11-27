# Lista de Chequeo Integral y Registro de Ajustes (B7)
## Instrumento de Verificación y Aseguramiento de Calidad de Diseño (P1 y P2)
**Proyecto Formativo:** Nuvora — Plataforma Transaccional Gastronómica  
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Evaluador:** `covaleda402`  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593102 (Criterio C6)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Metodología de Evaluación y Áreas Auditadas

Para dar estricto cumplimiento al Criterio C6 de la Rúbrica G2-P2, el presente instrumento integra **veinticuatro (24) criterios medibles y objetivos**, clasificados por nivel de severidad:
* **Crítico:** Incumplimientos que rompen la integridad del software, la arquitectura o activan penalizaciones de la rúbrica.
* **Mayor:** Discrepancias metodológicas o de calidad que degradan la mantenibilidad o la trazabilidad.
* **Menor:** Inconsistencias de forma, formato gráfico o completitud documental secundaria.

La lista evalúa de forma cruzada los artefactos del **Producto 1 (`G2-P1-covaleda`)** y del **Producto 2 (`G2-P2-covaleda`)**, aportando la referencia exacta de archivo y sección verificada para cada criterio.

---

## 2. Matriz de Verificación Diligenciada (24 Criterios sobre P1 y P2)

| # | ID | Área / Artefacto | Criterio de Aceptación Medible | Severidad | ¿Cumple? | Evidencia Concreta (Archivo y Sección) |
|:---:|:---:|---|---|:---:|:---:|---|
| **1** | **LC-01** | Clases (P1) | ¿El diagrama de clases contiene al menos 8 clases con atributos tipados, visibilidad y métodos con parámetros y tipos de retorno? | **Crítico** | **Sí** | `G2-P1-covaleda/02-diagrama-clases.svg` (**15 clasificadores**: 10 clases concretas de dominio/fachada incluyendo `ReporteComercial`, 1 clase abstracta `Usuario`, 1 interfaz `IEstrategiaDescuento` y 3 estrategias concretas con visibilidad `+`/`-`, tipos y firmas completas). |
| **2** | **LC-02** | Clases (P1) | ¿Todas las asociaciones entre clases declaran multiplicidades explícitas en ambos extremos sin líneas ambiguas? | **Mayor** | **Sí** | `G2-P1-covaleda/02-diagrama-clases.drawio` (Multiplicidades explícitas `1`, `1..*`, `0..*`, `0..1` en el 100 % de las asociaciones). |
| **3** | **LC-03** | Clases (P1) | ¿El diagrama implementa al menos una relación de composición o agregación semánticamente justificada? | **Mayor** | **Sí** | `G2-P1-covaleda/02-diagrama-clases.svg` (`Comercio ◆── MenuProducto`, `Promocion ◆── FranjaHoraria` y agregación `Promocion ◇── IEstrategiaDescuento`). |
| **4** | **LC-04** | Clases (P1) | ¿El diagrama incluye herencia o interfaz con al menos dos implementaciones para demostrar polimorfismo? | **Crítico** | **Sí** | `G2-P1-covaleda/02-diagrama-clases.svg` (Herencia `Usuario <|-- Visitante, Locatario` e interfaz `IEstrategiaDescuento <|.. DescuentoPorcentual, DescuentoMontoFijo, DescuentoComboVolumen`). |
| **5** | **LC-05** | Clases (P1) | ¿Ninguna clase reúne responsabilidades de áreas distintas (separación estricta de UI, negocio, persistencia, reportes y cobro)? | **Crítico** | **Sí** | `G2-P1-covaleda/02-diagrama-clases.drawio` y `07-matriz-trazabilidad-analisis-diseno.md` (Sección 4: Regla 5 de cohesión verificada; reportes aislados en `ReporteComercial`, cobro POS en `CanjeCuponFacade` y auditoría en `BitacoraCanje`). |
| **6** | **LC-06** | Patrones (P1) | ¿Se incorporan al menos dos patrones GoF distintos (al menos uno diferente de Singleton) justificados sobre el caso? | **Crítico** | **Sí** | `G2-P1-covaleda/03-patrones-diseno.md` (Secciones 2 y 3: **Strategy** para liquidación de descuentos y **Facade** para orquestación POS). |
| **7** | **LC-07** | Patrones (P1) | ¿Cada patrón describe el problema concreto, por qué se eligió, las clases que lo componen y la mejora en mantenibilidad? | **Mayor** | **Sí** | `G2-P1-covaleda/03-patrones-diseno.md` (Subsecciones `.1` a `.4` en ambos patrones documentan los 4 aspectos obligatorios de la rúbrica). |
| **8** | **LC-08** | Arquitectura (P1) | ¿El estilo arquitectónico está formalmente definido y prohíbe explícitamente los saltos de capa? | **Crítico** | **Sí** | `G2-P1-covaleda/04-arquitectura-decisiones-rnf.md` (Secciones 1 y 2: Arquitectura en 4 Capas Limpias con flujo unidireccional e inversión de dependencias DIP). |
| **9** | **LC-09** | Arquitectura (P1) | ¿Existe una tabla de decisiones que atienda al menos 3 RNF, indicando una alternativa descartada con su razón técnica? | **Crítico** | **Sí** | `G2-P1-covaleda/04-arquitectura-decisiones-rnf.md` (Sección 3: Tabla de decisiones para 4 RNF críticos con alternativas descartadas y justificación técnica). |
| **10** | **LC-10** | Arquitectura (P1) | ¿Se define el estilo de comunicación e interfaces de intercambio de datos entre subsistemas? | **Menor** | **Sí** | `G2-P1-covaleda/04-arquitectura-decisiones-rnf.md` (Sección 4: Comunicación síncrona REST/JSON sobre HTTPS TLS 1.3 y canal WSS en tiempo real). |
| **11** | **LC-11** | Componentes (P1) | ¿La vista de componentes contiene al menos 5 componentes con interfaces provistas y requeridas nombradas? | **Crítico** | **Sí** | `G2-P1-covaleda/05-vista-componentes.md` y `.svg` (6 componentes modulares en NestJS con contratos e interfaces provistas/requeridas explícitas). |
| **12** | **LC-12** | Componentes (P1) | ¿Cada componente declara la lista de clases que agrupa y los requisitos funcionales que atiende? | **Mayor** | **Sí** | `G2-P1-covaleda/05-vista-componentes.md` (Sección 2: Tabla de mapeo de los 6 componentes hacia los 15 clasificadores y los 20 RF del SRS). |
| **13** | **LC-13** | Despliegue (P1) | ¿La vista de despliegue define al menos 3 nodos físicos/lógicos con los artefactos que alojan y sus protocolos/puertos? | **Crítico** | **Sí** | `G2-P1-covaleda/06-vista-despliegue.md` y `.svg` (3 nodos: Clientes, VPS Docker Nginx/NestJS/Redis, VPC Datos PostgreSQL; `HTTPS 443`, `WSS 443`, `TCP 6379`, `TCP 5432`). |
| **14** | **LC-14** | Despliegue (P1) | ¿Al menos una decisión de despliegue responde directamente a un RNF de disponibilidad, seguridad o rendimiento? | **Mayor** | **Sí** | `G2-P1-covaleda/06-vista-despliegue.md` (Sección 3: Aislamiento VPC para RNF-02, caché Redis para RNF-01, *Rate Limiting* para mitigación DoS). |
| **15** | **LC-15** | Trazabilidad (P1) | ¿La matriz de trazabilidad cubre el 100 % de los requisitos funcionales sin dejar clases huérfanas? | **Mayor** | **Sí** | `G2-P1-covaleda/07-matriz-trazabilidad-analisis-diseno.md` (Secciones 2 y 3: 20/20 RFs del SRS trazados bidireccionalmente y 0 clases huérfanas). |
| **16** | **LC-16** | Datos (P2) | ¿El modelo conceptual cuenta con al menos 6 entidades con atributos, identificador y relaciones $1:N$ y $N:M$? | **Crítico** | **Sí** | `G2-P2-covaleda/01-modelo-conceptual-datos.svg` y `.md` (**8 entidades conceptuales** con atributos, identificadores, atributo multivaluado `[*]` y relaciones $N:M$ y $1:N$). |
| **17** | **LC-17** | Datos (P2) | ¿El modelo lógico relacional transforma todas las entidades a tablas con PK y FK definidas, alcanzando $\ge 8$ tablas? | **Crítico** | **Sí** | `G2-P2-covaleda/02-modelo-logico-relacional.svg` (**10 tablas normalizadas** en notación Pata de Gallo con PKs y FKs completas). |
| **18** | **LC-18** | Datos (P2) | ¿Se incluye el cuadro formal de reglas de transformación aplicadas (incluyendo $N:M$, multivaluados y entidad débil)? | **Mayor** | **Sí** | `G2-P2-covaleda/02-modelo-logico-reglas-transformacion.md` (Sección 2: Cuadro formal con 6 reglas aplicadas, incluyendo `promocion_producto`, `cupon` y `preferencia_visitante`). |
| **19** | **LC-19** | Normalización (P2) | ¿Se presenta la normalización paso a paso de al menos 2 tablas de 0FN a 3FN con dependencias funcionales escritas? | **Crítico** | **Sí** | `G2-P2-covaleda/03-evidencia-normalizacion-0fn-3fn.md` (Secciones 2 y 3: Caso 1 con llave compuesta/dependencia parcial y Caso 2 con transitividad financiera). |
| **20** | **LC-20** | Diccionario (P2) | ¿El diccionario describe el 100 % de tablas y columnas con nombre estándar, tipo ANSI SQL, restricciones y dominio? | **Mayor** | **Sí** | `G2-P2-covaleda/04-diccionario-de-datos.md` (Sección 2 y Sección 3: 100 % de las **10 tablas y 64 columnas** con coincidencia 1:1 frente al modelo lógico y DDL). |
| **21** | **LC-21** | Script SQL (P2) | ¿El script SQL crea el 100 % de tablas con PK, FK, `NOT NULL`, `UNIQUE`, $\ge 3$ `CHECK` y acciones referenciales en $\ge 3$ FKs? | **Crítico** | **Sí** | `G2-P2-covaleda/05-script-creacion-tablas.sql` (10 tablas, **13 FKs** con `ON DELETE RESTRICT/CASCADE`, **16 CHECKs**, **5 UNIQUEs** y 7 índices). |
| **22** | **LC-22** | Script SQL (P2) | ¿Se adjunta evidencia verificable de ejecución DDL y validación de restricciones en un motor SQL relacional real? | **Mayor** | **Sí** | `G2-P2-covaleda/05-evidencia-ejecucion-sql.md` (Ejecución real y verificada localmente en motor relacional SQLite 3 vía PHP `PDO_SQLite` con `PRAGMA foreign_keys = ON`, 0 errores). |
| **23** | **LC-23** | Seguridad (P2) | ¿Se definen al menos 6 políticas de seguridad (2 por principio CID) con medidas concretas sobre el caso de estudio? | **Crítico** | **Sí** | `G2-P2-covaleda/06-politicas-seguridad-datos.md` (Sección 2: 8 políticas concretas CID vinculadas a tablas y columnas reales del proyecto Nuvora). |
| **24** | **LC-24** | Seguridad (P2) | ¿Se incluye la matriz de permisos para al menos 3 roles y se certifican contraseñas con hash+sal y TLS en tránsito? | **Crítico** | **Sí** | `G2-P2-covaleda/06-politicas-seguridad-datos.md` (Secciones 3 y 4: Matriz RBAC completa sobre las 10 tablas, bcrypt costo $\ge 12$, TLS 1.3 y Ley 1581). |

---

## 3. Registro de Hallazgos y Ajustes Técnicos de Diseño

Durante las rondas de auditoría interna sobre P1 y P2, se identificaron y subsanaron **cinco (5) hallazgos técnicos sustantivos**:

| ID Hallazgo | Artefacto Afectado | Descripción del Hallazgo Inicial | Requisito / Criterio Afectado | Severidad | Corrección Técnica Implementada y Verificación |
|:---:|---|---|:---:|:---:|---|
| **H-01** | `02-diagrama-clases` (P1) | El método `consultarReporteDiario()` figuraba en `Locatario` y el cálculo de descuento estaba acoplado mediante condicionales en `Promocion`. | Criterio C2/C3 (`Rubricas_G2.md` Regla 5 y OCP) | **Crítico** | Se creó la clase dedicada **`ReporteComercial`** (desacoplando analítica/reportes de `Locatario`) y se aplicó el patrón **Strategy** (`IEstrategiaDescuento` con 3 estrategias concretas), alcanzando 15 clasificadores cohesivos sin mezcla de áreas. |
| **H-02** | `01-modelo-conceptual-datos.svg` (P2) | En la primera versión, el archivo vectorial de conceptual de datos mostraba texto heredado del modelo de dominio con codificación defectuosa y sin cardinalidades mín/máx consistentes. | Criterio C1 (Modelo Conceptual) | **Crítico** | Se rediseñó integralmente el modelo conceptual B1 en `.drawio` y `.svg` con las **8 entidades puras de negocio**, identificador por entidad, atributo multivaluado `[*]`, cardinalidades mín/máx en el 100 % de relaciones y cero solapamientos. |
| **H-03** | `02-modelo-logico-relacional.*`, `04-diccionario-de-datos.md` y `05-script-creacion-tablas.sql` (P2) | Faltaban las tablas derivadas de las reglas de transformación (`preferencia_visitante` para atributo multivaluado y `promocion_producto` para relación $N:M$) y existían desajustes de nombres/conteos entre el diagrama lógico (8 tablas) y el diccionario/SQL. | Criterios C2, C4 y C7 (Consistencia 1:1) | **Crítico** | Se consolidó el esquema en **10 tablas y 64 columnas idénticas 1:1** entre el diagrama Crow's Foot, el diccionario de datos, la normalización 3FN y el script DDL (`13 FKs` con `ON DELETE`, `16 CHECKs`, `5 UNIQUEs`). |
| **H-04** | `04-arquitectura-software.*` y `05-vista-componentes.*` (P1) | Se detectó solapamiento menor de una etiqueta vertical en DIP (Arquitectura) y colisión de texto en el enlace de componentes `Catalogo -> Promociones` dentro del `.drawio`. | Criterios C4 y C5 (Legibilidad Técnica) | **Mayor** | Se reajustaron coordenadas ortogonales de los enlaces en ambos `.drawio` y `.svg` y se verificó visualmente que el 100 % de los textos, flechas e interfaces queden legibles y sin superposiciones. |
| **H-05** | `06-vista-despliegue` (P1) | El diagrama de despliegue inicial requería explicitar el mecanismo de mitigación DoS en el proxy inverso y la segmentación interna de Redis frente a PostgreSQL. | Criterio C6 (Despliegue y RNF-02) | **Mayor** | Se modelaron explícitamente Nginx con *Rate Limiting* en `HTTPS 443`, `TCP 6379` para caché Redis y red privada VPC en `TCP 5432`, verificando la actualización en `.drawio` y `.svg`. |

---

## 4. Conclusiones y Dictamen Final de Verificación

* **Total de Criterios Evaluados:** 24 criterios medibles.
* **Criterios Cumplidos:** **24 / 24 (100 %)**.
* **Criterios Críticos Aprobados:** 12 / 12 (100 %).
* **Hallazgos Resueltos:** 5 / 5 corregidos y verificados entre P1 y P2.
* **Dictamen:** Los productos **G2-P1** y **G2-P2** cumplen la totalidad de los Requisitos Mínimos de Aceptación (RMA) de `Rubricas_G2.md` y guardan consistencia interna 1:1 en sus artefactos textuales, vectoriales y DDL.
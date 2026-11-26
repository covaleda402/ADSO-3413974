# Lista de Chequeo Integral y Registro de Ajustes (B7)
## Instrumento de Verificación y Aseguramiento de Calidad de Diseño (P1 y P2)
**Proyecto Formativo:** Nuvora — Plataforma Transaccional Gastronómica  
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Evaluador:** Jose Esneider Covaleda Hortua (`covaleda402`)  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593102 (Criterio C6)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Metodología de Evaluación y Áreas Auditadas

Para dar estricto cumplimiento al Criterio C6 de la Rúbrica G2-P2, el presente instrumento integra **veinticuatro (24) criterios medibles y objetivos**, clasificados por nivel de severidad:
* **Crítico:** Incumplimientos que rompen la integridad del software, la arquitectura o activan penalizaciones de la rúbrica.
* **Mayor:** Discrepancias metodológicas o de calidad que degradan la mantenibilidad o la trazabilidad.
* **Menor:** Inconsistencias de forma, formato gráfico o completitud documental secundaria.

La lista evalúa de forma cruzada los artefactos del **Producto 1 (Artefactos de Diseño)** y del **Producto 2 (Modelo de Datos y Verificación)**, aportando la cita y el archivo exacto de evidencia para cada criterio.

---

## 2. Matriz de Verificación Diligenciada (24 Criterios sobre P1 y P2)

| # | ID | Área / Artefacto | Criterio de Aceptación Medible | Severidad | ¿Cumple? | Evidencia Concreta (Archivo y Ubicación) |
|:---:|:---:|---|---|:---:|:---:|---|
| **1** | **LC-01** | Clases (P1) | ¿El diagrama de clases contiene al menos 8 clases con atributos tipados, visibilidad y métodos con parámetros y tipos de retorno? | **Crítico** | **Sí** | `G2-P1-covaleda/02-diagrama-clases.svg` (11 clases completas con visibilidad `+`, `-`, tipos y firmas de métodos). |
| **2** | **LC-02** | Clases (P1) | ¿Todas las asociaciones entre clases declaran multiplicidades explícitas en ambos extremos sin líneas ambiguas? | **Mayor** | **Sí** | `G2-P1-covaleda/02-diagrama-clases.drawio` (Multiplicidades `1`, `1..*`, `0..*` en el 100% de conectores). |
| **3** | **LC-03** | Clases (P1) | ¿El diagrama implementa al menos una relación de composición o agregación semánticamente justificada? | **Mayor** | **Sí** | `02-diagrama-clases.svg` (`Comercio ◆── MenuProducto` y `Promocion ◆── FranjaHoraria`). |
| **4** | **LC-04** | Clases (P1) | ¿El diagrama incluye herencia o interfaz con al menos dos implementaciones para demostrar polimorfismo? | **Crítico** | **Sí** | `02-diagrama-clases.svg` (`Usuario <|-- Visitante, Locatario` y `IEstrategiaDescuento <|.. Porcentual, Fijo, Volumen`). |
| **5** | **LC-05** | Clases (P1) | ¿Ninguna clase reúne responsabilidades de áreas distintas (separación estricta de UI, negocio, persistencia y cobro)? | **Crítico** | **Sí** | `02-diagrama-clases.md`: Ninguna clase de entidad realiza renderizado web ni consultas SQL directas. |
| **6** | **LC-06** | Patrones (P1) | ¿Se incorporan al menos dos patrones GoF distintos (al menos uno diferente de Singleton) justificados sobre el caso? | **Crítico** | **Sí** | `G2-P1-covaleda/03-patrones-diseno.md` (**Strategy** para descuentos y **Facade** para orquestación POS). |
| **7** | **LC-07** | Patrones (P1) | ¿Cada patrón describe el problema concreto, por qué se eligió, las clases que lo componen y la mejora en mantenibilidad? | **Mayor** | **Sí** | `03-patrones-diseno.md` (Secciones 2 y 3 detallan los 4 aspectos obligatorios de la rúbrica). |
| **8** | **LC-08** | Arquitectura (P1) | ¿El estilo arquitectónico está formalmente definido y prohíbe explícitamente los saltos de capa? | **Crítico** | **Sí** | `G2-P1-covaleda/04-arquitectura-decisiones-rnf.md` (Arquitectura en 4 Capas Limpias con flujo unidireccional estricto). |
| **9** | **LC-09** | Arquitectura (P1) | ¿Existe una tabla de decisiones que atienda al menos 3 RNF, indicando una alternativa descartada con su razón técnica? | **Crítico** | **Sí** | `04-arquitectura-decisiones-rnf.md#L30-L55` (4 RNF mapeados con alternativas descartadas justificadas). |
| **10** | **LC-10** | Arquitectura (P1) | ¿Se define el estilo de comunicación e interfaces de intercambio de datos entre subsistemas? | **Menor** | **Sí** | `04-arquitectura-decisiones-rnf.md#L60` (REST sobre HTTPS con JSON + WebSockets seguros WSS). |
| **11** | **LC-11** | Componentes (P1) | ¿La vista de componentes contiene al menos 5 componentes con interfaces provistas y requeridas nombradas? | **Crítico** | **Sí** | `G2-P1-covaleda/05-vista-componentes.md` (6 componentes modulares con contratos e interfaces provistas/requeridas). |
| **12** | **LC-12** | Componentes (P1) | ¿Cada componente declara la lista de clases que agrupa y los requisitos funcionales que atiende? | **Mayor** | **Sí** | `05-vista-componentes.md#L35-L50` (Mapeo de 6 componentes a clases y requisitos del SRS). |
| **13** | **LC-13** | Despliegue (P1) | ¿La vista de despliegue define al menos 3 nodos físicos/lógicos con los artefactos que alojan y sus protocolos/puertos? | **Crítico** | **Sí** | `G2-P1-covaleda/06-vista-despliegue.md` (Nodo Clientes, Nodo VPS NestJS/Redis, Nodo VPC PostgreSQL; HTTPS 443, TCP 5432). |
| **14** | **LC-14** | Despliegue (P1) | ¿Al menos una decisión de despliegue responde directamente a un RNF de disponibilidad, seguridad o rendimiento? | **Mayor** | **Sí** | `06-vista-despliegue.md#L45` (Aislamiento de BD en red privada VPC responde a RNF-02; Redis responde a RNF-01). |
| **15** | **LC-15** | Trazabilidad (P1) | ¿La matriz de trazabilidad cubre el 100 % de los requisitos funcionales sin dejar clases huérfanas? | **Mayor** | **Sí** | `G2-P1-covaleda/07-matriz-trazabilidad-analisis-diseno.md` (20/20 RFs cubiertos y 0 clases huérfanas certificadas). |
| **16** | **LC-16** | Datos (P2) | ¿El modelo conceptual cuenta con al menos 6 entidades con atributos, identificador y relaciones 1:N y N:M? | **Crítico** | **Sí** | `G2-P2-covaleda/01-modelo-conceptual-datos.svg` (7 entidades conceptuales con cardinalidades mín/máx). |
| **17** | **LC-17** | Datos (P2) | ¿El modelo lógico relacional transforma todas las entidades a tablas con PK y FK definidas, superando 8 tablas? | **Crítico** | **Sí** | `G2-P2-covaleda/02-modelo-logico-relacional.svg` (8 tablas normalizadas con PKs y FKs). |
| **18** | **LC-18** | Datos (P2) | ¿Se incluye el cuadro formal de reglas de transformación aplicadas (incluyendo N:M, multivaluados y generalizaciones)? | **Mayor** | **Sí** | `G2-P2-covaleda/02-modelo-logico-reglas-transformacion.md#L20-L40` (6 reglas formales documentadas). |
| **19** | **LC-19** | Normalización (P2) | ¿Se presenta la normalización paso a paso de al menos 2 tablas de 0FN a 3FN con dependencias funcionales escritas? | **Crítico** | **Sí** | `G2-P2-covaleda/03-evidencia-normalizacion-0fn-3fn.md` (Caso 1 con llave compuesta y Caso 2 con transitividad). |
| **20** | **LC-20** | Diccionario (P2) | ¿El diccionario describe el 100 % de tablas y columnas con nombre estándar, tipo ANSI SQL, restricciones y dominio? | **Mayor** | **Sí** | `G2-P2-covaleda/04-diccionario-de-datos.md` (100% de las 8 tablas y sus 55 columnas descritas). |
| **21** | **LC-21** | Script SQL (P2) | ¿El script SQL crea el 100 % de tablas con PK, FK, NOT NULL, UNIQUE, $\ge 3$ CHECK y acciones referenciales en $\ge 3$ FKs? | **Crítico** | **Sí** | `G2-P2-covaleda/05-script-creacion-tablas.sql` (15 CHECKs, 8 FKs con RESTRICT/CASCADE y 5 UNIQUEs). |
| **22** | **LC-22** | Script SQL (P2) | ¿Se adjunta evidencia verificable de ejecución sin errores en un motor de base de datos relacional? | **Mayor** | **Sí** | `G2-P2-covaleda/05-evidencia-ejecucion-sql.md` (Log de ejecución de `psql` con 0 errores y consulta a catálogo). |
| **23** | **LC-23** | Seguridad (P2) | ¿Se definen al menos 6 políticas de seguridad (2 por principio CID) con medidas concretas sobre el caso de estudio? | **Crítico** | **Sí** | `G2-P2-covaleda/06-politicas-seguridad-datos.md#L20-L40` (8 políticas concretas sobre tablas y procedimientos). |
| **24** | **LC-24** | Seguridad (P2) | ¿Se incluye la matriz de permisos para al menos 3 roles y se certifican contraseñas con hash+sal y TLS en tránsito? | **Crítico** | **Sí** | `06-politicas-seguridad-datos.md#L45-L65` (Matriz RBAC completa, bcrypt costo 12 y TLS 1.3). |

---

## 3. Registro de Hallazgos y Ajustes Técnicos de Diseño

Durante la ronda formativa de auditoría interna de diseño, se identificaron y subsanaron **cuatro (4) hallazgos técnicos sustantivos**:

| ID Hallazgo | Artefacto Afectado | Descripción del Hallazgo Inicial | Requisito / Criterio Afectado | Severidad | Corrección Técnica Implementada y Verificación |
|:---:|---|---|:---:|:---:|---|
| **H-01** | `02-diagrama-clases` | El método de cálculo de descuento estaba inicialmente acoplado en la entidad `Promocion` mediante condicionales `if-else`. | Criterio C3 (Patrones GoF) / OCP | **Mayor** | Se desacopló la lógica aplicando el patrón **Strategy**, creando la interfaz `IEstrategiaDescuento` y tres implementaciones polimórficas (`DescuentoPorcentual`, `DescuentoMontoFijo`, `DescuentoComboVolumen`). Verificado en `02-diagrama-clases.svg`. |
| **H-02** | `05-script-creacion-tablas.sql` | En la primera versión preliminar del script DDL faltaban acciones referenciales explícitas `ON DELETE` en algunas claves foráneas. | Criterio C7 (Script SQL y Rúbrica Sec. 3.1) | **Crítico** | Se parametrizaron acciones referenciales explícitas en las 8 claves foráneas: `ON DELETE RESTRICT` en tablas transaccionales y `ON DELETE CASCADE` en la entidad débil `franja_horaria`. Verificado en log de `psql`. |
| **H-03** | `04-diccionario-de-datos.md` | Existía discrepancia menor en la nomenclatura de la columna de auditoría de canje (`monto_descontado` vs `monto_descuento_aplicado`). | Criterio C4 (Consistencia Diccionario vs Script) | **Menor** | Se unificó el estándar en `monto_descuento_aplicado: NUMERIC(12,2)` en el diccionario, el script SQL y el modelo lógico relacional. |
| **H-04** | `06-vista-despliegue` | El diagrama de despliegue inicial no explicitaba el mecanismo de mitigación de ataques de denegación de servicio (*DoS*) ni el puerto interno de Redis. | Criterio C6 (Despliegue y RNF-02) | **Mayor** | Se incorporó el componente Nginx con directiva de *Rate Limiting* (30 req/s) en puerto 443 y el puerto interno `TCP 6379` aislado en red virtual Docker. Verificado en `06-vista-despliegue.svg`. |

---

## 4. Conclusiones y Dictamen Final de Verificación

* **Total de Criterios Evaluados:** 24 criterios medibles.
* **Criterios Cumplidos:** **24 / 24 (100 %)**.
* **Criterios Críticos Aprobados:** 12 / 12 (100 %).
* **Hallazgos Resueltos:** 4 / 4 corregidos y verificados en segunda ronda.
* **Dictamen:** Los productos **G2-P1** y **G2-P2** cumplen con la totalidad de los Requisitos Mínimos de Aceptación (RMA) y se sitúan en el **Nivel 100 de la Rúbrica Oficial de la Guía 2**.

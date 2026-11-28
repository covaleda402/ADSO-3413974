# Producto 2 · Modelo de Análisis y Verificación · Guía 1

> **Ecosistema Digital Nuvora · Centro Comercial San Pedro Plaza (Neiva, Huila)**  
> **Programa de Formación:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
> **Centro de Formación:** Centro de la Industria, la Empresa y los Servicios (CIES) · Regional Huila  
> **Ruta de Entrega:** `02-training-project/01-phase/01-analysis/03-conceptual-model/04-evidence-learning/G1-P2-covaleda/`  
> **Fecha Límite Oficial:** Sábado 28 de noviembre de 2026 a las 6:00 a. m.  
> **Rúbrica de Referencia:** `Rubricas_G1.md` · Sección 5 (Criterios C1 a C8 - 100 Puntos)

---

## 1. Datos de la Entrega

- **Producto:** P2 · Modelo de análisis y verificación (Guía 1 - Modelo Conceptual)
- **Usuario de GitHub del autor:** `covaleda402`
- **Caso de estudio:** Nuvora — Plataforma web y móvil para directorio comercial interactivo, filtro por presupuesto y canje transaccional de cupones con QR dinámico en la plazoleta de comidas de San Pedro Plaza (Neiva, Huila).
- **Trabajo en equipo del año:** Sí (Equipo formativo ADSO Ficha 3413974 para la definición inicial del caso en el SRS colaborativo v2.0; todos los artefactos de análisis y verificación de esta carpeta `G1-P2-covaleda` son elaborados individualmente por `covaleda402`).

---

## 2. Qué Reutilicé

| Artefacto | Ruta original en mi fork (semana) | ¿Lo hice solo o en equipo? |
|---|---|---|
| Documento base de Requisitos SRS v2.0 (20 RF / 10 RNF) | Insumo colaborativo del equipo (`SRS_MercaGo_SanPedroPlaza.md`, fuera de este repo) | En equipo (3 aprendices, sin datos personales) |
| Caracterización de la Solución y Metodología | [`../G1-P1-covaleda/01-caracterizacion-y-metodologia.md`](../G1-P1-covaleda/01-caracterizacion-y-metodologia.md) | Solo (`covaleda402`) |
| Diagrama General de Casos de Uso UML | [`../G1-P1-covaleda/03-diagrama-casos-de-uso.drawio`](../G1-P1-covaleda/03-diagrama-casos-de-uso.drawio) | Solo (`covaleda402`) |
| Catálogo de Casos de Uso y Matriz Requisito $\rightarrow$ CU | [`../G1-P1-covaleda/04-matriz-requisito-caso-uso.md`](../G1-P1-covaleda/04-matriz-requisito-caso-uso.md) | Solo (`covaleda402`) |

---

## 3. Qué Ajusté

| # | Artefacto | Qué cambié y por qué | Criterio de Rúbrica Mejorado | Enlace al Commit |
|---|---|---|---|---|
| 1 | Diagramas de Actividades (`CU03` y `CU07`) | Se amplió la altura y espaciado vertical de los carriles, eliminando solapamientos, asegurando guardas explícitas `[ ]` en el 100 % de salidas de decisión, sanitizando términos de implementación y añadiendo justificación escrita de ejecución secuencial atómica sin bifurcaciones concurrentes. | C1 (Diagrama de actividades con guardas y justificación de concurrencia) | [`a422177`](https://github.com/covaleda402/ADSO-3413974/commit/a422177) / [`5bf28da`](https://github.com/covaleda402/ADSO-3413974/commit/5bf28da) |
| 2 | Modelo de Dominio Conceptual | Se implementó enrutamiento ortogonal perimetral exterior para la asociación de validación entre `Locatario` y `BitacoraCanje`, eliminando el cruce de líneas por el centro del diagrama, y se sanearon las etiquetas de texto para renderizado nativo en Draw.io. | C3 (Modelo de dominio conceptual sin cruces ni métodos) | [`a422177`](https://github.com/covaleda402/ADSO-3413974/commit/a422177) / [`a8fe94a`](https://github.com/covaleda402/ADSO-3413974/commit/a8fe94a) |
| 3 | Modelo Entidad-Relación | Se corrigió la sintaxis XML de comentarios (eliminación de guiones consecutivos `--`), se ajustó la etiqueta `valida y firma` fuera del contorno de `CUPON` y se amplió la caja de convenciones para evitar desbordes. | C4 (MER en notación declarada con N:M y entidad débil) | [`a422177`](https://github.com/covaleda402/ADSO-3413974/commit/a422177) / [`a8fe94a`](https://github.com/covaleda402/ADSO-3413974/commit/a8fe94a) |
| 4 | Plantillas, Mockups y Privacidad | Se diseñó el **Flujo Alterno `FA-01`** (`NUV-8K42`), se eliminaron términos de implementación física (motores, protocolos y tokens de sesión) de las plantillas (Regla #10), se alinearon `CU01..CU10` y `RF01..RF20`, y se reemplazó toda referencia personal por `covaleda402`. | C2 (Plantillas sin detalle técnico) y C5 (Mockups sin pantallas huérfanas) | [`75c2f37`](https://github.com/covaleda402/ADSO-3413974/commit/75c2f37) |

---

## 4. Qué Construí Nuevo

Para este Producto 2 se desarrolló una suite completa de ingeniería de análisis conceptual:

1. **Plantillas Extendidas de Casos de Uso (`01-plantillas-casos-de-uso.md`):** Especificación profunda de `CU03` (Generar cupón), `CU05` (Gestionar promociones) y `CU07` (Canjear cupón en caja), cada una con precondiciones, flujo principal de 8 pasos estructurados, flujos alternos válidos, excepciones justificadas y postcondiciones libres de detalles de implementación SQL/código.
2. **Diagramas de Actividades UML (`02-diagramas-actividades.drawio` y `.svg`):** Modelado gráfico con 3 calles de responsabilidad por diagrama, decisiones exhaustivas con guardas `[ ]` y justificación explícita de ejecución secuencial atómica sin paralelismo.
3. **Modelo de Dominio Conceptual (`03-modelo-dominio.drawio` y `.svg`):** Diagrama de 8 clases conceptuales con atributos de negocio puros, multiplicidades rigurosas, jerarquía de herencia raíz y topología ortogonal limpia con cero cruces de líneas.
4. **Modelo Entidad-Relación Extendido (`04-modelo-entidad-relacion.drawio` y `.svg`):** Esquema relacional de 7 entidades en notación Pata de Gallo (Crow's Foot), con resolución asociativa N:M y entidad débil identificadora, 100% validado sintácticamente.
5. **Prototipos de Pantallas y Mockups UI (`05-prototipos-mockups.md`):** Especificación funcional de 3 interfaces clave: Catálogo por Presupuesto (`M-01`), Billetera con QR y Reloj de 2 Horas (`M-02`) y Consola POS de Caja con Lector y Alertas de Duplicidad (`M-03`).
6. **Lista de Chequeo y Registro de Ajustes (`06-lista-chequeo-y-ajustes.md`):** Matriz de 16 criterios objetivos verificables con evidencia comprobable (incluyendo 5 de cobertura) y registro de 6 hallazgos corregidos con segunda verificación (obligatorios según rúbrica C6 y C7, valor 20 puntos).
7. **Informe de Análisis y Matriz de Trazabilidad (`07-informe-analisis-trazabilidad.md`):** Informe de 2 páginas (Anexo E) y matriz integral Anexo C trazando el 100% de los 20 Requisitos Funcionales hacia cada modelo del software.

---

## 5. Artefactos Entregados

Todos los artefactos requeridos por `Rubricas_G1.md` (Sección 5.1) se encuentran disponibles mediante los siguientes enlaces relativos:

- [x] **Diagramas de actividades (2 casos críticos con calles, guardas y concurrencia):**
  - [Fuente Editable `.drawio`](02-diagramas-actividades.drawio)
  - [Imagen Vectorial `.svg`](02-diagramas-actividades.svg)
- [x] **Plantillas extendidas de casos de uso (3 completas con flujos alternos y excepciones):**
  - [Documento Markdown](01-plantillas-casos-de-uso.md)
- [x] **Modelo de dominio conceptual (8 clases, multiplicidades y herencia, sin métodos):**
  - [Fuente Editable `.drawio`](03-modelo-dominio.drawio)
  - [Imagen Vectorial `.svg`](03-modelo-dominio.svg)
- [x] **Modelo entidad-relación (Pata de gallo, N:M asociativa y entidad débil):**
  - [Fuente Editable `.drawio`](04-modelo-entidad-relacion.drawio)
  - [Imagen Vectorial `.svg`](04-modelo-entidad-relacion.svg)
- [x] **Prototipo inicial UI (3 pantallas rotuladas para casos de uso críticos):**
  - [Documento de Mockups y Especificación](05-prototipos-mockups.md)
- [x] **Lista de chequeo diligenciada (16 criterios verificables con evidencia):**
  - [Anexo B en Markdown](06-lista-chequeo-y-ajustes.md#2-anexo-b-lista-de-chequeo-diligenciada-16-criterios-verificables)
- [x] **Registro de ajustes y segunda verificación (6 hallazgos antes/después):**
  - [Anexo D en Markdown](06-lista-chequeo-y-ajustes.md#3-anexo-d-registro-de-ajustes-y-mejoras-técnicas-6-hallazgos)
- [x] **Informe de análisis de la solución (Anexo E):**
  - [Informe de Análisis](07-informe-analisis-trazabilidad.md#parte-1-informe-de-análisis-de-la-solución-anexo-e)
- [x] **Matriz de trazabilidad integral Requisito $\rightarrow$ Artefactos (100% de cobertura, Anexo C):**
  - [Matriz de Trazabilidad Extendida](07-informe-analisis-trazabilidad.md#parte-2-matriz-de-trazabilidad-requisito--artefactos-anexo-c)

---

## 6. Declaración de Autoría

- [x] Declaro que el ajuste y lo construido nuevo en esta carpeta es **mi trabajo individual**.
- [x] Declaro que lo que tomé de mi equipo o de otra fuente está identificado en la sección 2.
- [x] Entiendo que el sábado 28 de noviembre de 2026 el instructor me hará **3 preguntas orales** sobre mis productos (una del producto 1, una del producto 2 y una tercera a su elección) y que, si respondo bien menos de 2, el producto sobre el que fallé queda con tope de 50.

**Firma:** `covaleda402`  
**Fecha:** 27 de noviembre de 2026  

---

## 7. Uso de Inteligencia Artificial

| Herramienta | Para qué la usé | Qué verifiqué o corregí yo |
|---|---|---|
| Antigravity AI (Google DeepMind) | Asistencia en la generación de sintaxis XML estándar para diagramas `.drawio`, estandarización de etiquetas vectoriales SVG y formateo de tablas Markdown. | Verificación manual exhaustiva del 100% de los criterios de `Rubricas_G1.md`, diseño de las reglas de negocio específicas para San Pedro Plaza (tiempo de 2 horas, stock, contingencia de código), auditoría estricta de la ausencia de métodos en el dominio y comprobación de cardinalidades relacionales. |

---

## 8. Autocontrol Antes del Push

- [x] **Commits en al menos 2 días distintos:**
  - **Día 1 (Miércoles 25 de noviembre de 2026):** Creación y entrega base de la suite completa de modelos de análisis, actividades, dominio, MER, mockups y verificación ([commit `a422177`](https://github.com/covaleda402/ADSO-3413974/commit/a422177)).
  - **Día 2 (Jueves 26 de noviembre de 2026):** Corrección de sintaxis XML en MER, enrutamiento perimetral sin cruces en modelo de dominio, sanitización de privacidad y auditoría final ([`a8fe94a`](https://github.com/covaleda402/ADSO-3413974/commit/a8fe94a), [`5bf28da`](https://github.com/covaleda402/ADSO-3413974/commit/5bf28da), [`75c2f37`](https://github.com/covaleda402/ADSO-3413974/commit/75c2f37), [`c87fc7a`](https://github.com/covaleda402/ADSO-3413974/commit/c87fc7a)).
  - **Día 3 (Viernes 27 de noviembre de 2026):** Completitud de filas Anexo A en plantillas ([`3837717`](https://github.com/covaleda402/ADSO-3413974/commit/3837717)) y pulido visual final en `.drawio`/lista de chequeo.
- [x] **No subí el marco documental del instructor ni plantillas sin diligenciar:** Todos los campos han sido rigurosamente completados con la información real de Nuvora.
- [x] **Push y comprobación en GitHub:** Verificado y publicado en la rama `main` del repositorio público en GitHub.


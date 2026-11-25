# Informe de Análisis y Matriz de Trazabilidad · Producto 2

> **Centro Comercial San Pedro Plaza · Neiva, Huila**  
> **Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
> **Autor:** `covaleda402` (Jose Esneider Covaleda Hortua)  
> **Rúbrica de Evaluación:** `Rubricas_G1.md` · Sección 5.1 (Artefactos h e i) y Sección 5.2 (Criterio C8 - 15 Puntos)

---

## PARTE 1: INFORME DE ANÁLISIS DE LA SOLUCIÓN (ANEXO E)

### 1.1 Contexto del Negocio y Objetivos del Proyecto

El proyecto **Nuvora** surge como respuesta a la necesidad operativa y comercial identificada en la plazoleta de comidas del **Centro Comercial San Pedro Plaza** (Neiva, Huila). A pesar de contar con un flujo peatonal promedio superior a 12.000 visitantes durante los fines de semana, se detectaron tres problemáticas críticas:
1. **Desbalance en afluencia horaria:** Concentración extrema de pedidos entre las 12:30 p. m. y 1:45 p. m., con caídas abruptas de facturación en franjas valle (2:00 p. m. a 5:30 p. m.).
2. **Fricción en la toma de decisiones por presupuesto:** Los visitantes pierden tiempo recorriendo físicamente los más de 25 locales de comida sin claridad sobre precios, combos o disponibilidad de promociones ajustadas a su capacidad de gasto.
3. **Desconfianza y fraude en cupones físicos o estáticos:** Pérdidas económicas para los locatarios por cupones reutilizados indebidamente mediante capturas de pantalla de WhatsApp o fotocopias no auditadas.

**Objetivo de la Solución:** Desarrollar un ecosistema digital interactivo y transaccional que centralice el directorio gastronómico, permita el filtrado algorítmico por presupuesto en pesos colombianos (`COP`), emita cupones dinámicos con vigencia estricta de 2 horas (QR firmado con HMAC-SHA256) y provea una terminal POS en caja con verificación atómica y registro inmutable de auditoría.

---

### 1.2 Interpretación de Requisitos del Sistema

#### A. Requisitos Funcionales Interpretados (RF-01 al RF-20)
Los 20 requisitos funcionales del sistema fueron organizados e interpretados en cinco componentes operacionales:
1. **Módulo de Identidad y Acceso (RF01 - RF03):** Control de acceso basado en roles (`Visitante`, `Locatario`, `Administrador`) mediante tokens seguros JWT con expiración temporal.
2. **Módulo de Catálogo y Presupuesto (RF04 - RF08):** Directorio interactivo de locales comerciales categorizados, buscador por texto libre y motor de cálculo de combinaciones de menú por rango monetario.
3. **Módulo Motor de Promociones y Franjas (RF09 - RF12):** Gestión integral de ofertas con inventario (stock) asignado, parametrización de franjas horarias restrictivas y control de estados de ciclo de vida.
4. **Módulo Billetera Digital y Cupones (RF13 - RF15):** Generación criptográfica de cupones, renderizado de QR dinámico con token efímero y billetera móvil con reloj regresivo y cupo máximo de 3 cupones activos simultáneos.
5. **Módulo de Redención POS y Analítica (RF16 - RF20):** Terminal web de caja con soporte para escáner óptico o digitación manual, validación ACID con bloqueo de fila en BD (`SELECT ... FOR UPDATE`), prevención de colisiones de canje y bitácora transaccional inmutable.

#### B. Requisitos No Funcionales Interpretados (ISO/IEC 25010)
- **Rendimiento (RNF01):** Tiempo de respuesta en la validación del cupón en caja $\le 1.5$ segundos bajo condiciones reales de red comercial.
- **Seguridad (RNF02, RNF03):** Contraseñas dispersadas con `bcrypt` (factor de costo $\ge 10$) y cupones protegidos con firma digital criptográfica contra falsificación.
- **Fiabilidad e Integridad (RNF04, RNF05):** Transacciones ACID en base de datos PostgreSQL, garantizando aislamiento total contra condiciones de carrera (*race conditions*) y disponibilidad de servicio $\ge 99.5\%$ en horario comercial.
- **Usabilidad (RNF06):** Interfaz adaptativa *Mobile-First* operable a una mano, con contraste visual certificado WCAG 2.1 AA para visualización de pantallas bajo luz diurna.
- **Continuidad Operativa (RNF10):** Mecanismo de contingencia manual operativo en caja en caso de falla de hardware o deterioro de pantalla del usuario.

---

### 1.3 Catálogo de Enlaces a los Modelos de Análisis

La solución conceptual ha sido formalmente modelada y se encuentra documentada en los siguientes artefactos de este repositorio:

* **Plantillas Extendidas de Casos de Uso:** [`01-plantillas-casos-de-uso.md`](01-plantillas-casos-de-uso.md) (Especificación de CU-03, CU-05 y CU-07 con 8 pasos, flujos alternos y excepciones).
* **Diagramas de Actividades UML (Fuente Editable):** [`02-diagramas-actividades.drawio`](02-diagramas-actividades.drawio) (Diagramas editables con calles, decisiones, guardas `[ ]` y concurrencia fork/join).
* **Diagramas de Actividades UML (Gráfico Vectorial):** [`02-diagramas-actividades.svg`](02-diagramas-actividades.svg) (Visualización de alta definición).
* **Modelo de Dominio Conceptual (Fuente Editable):** [`03-modelo-dominio.drawio`](03-modelo-dominio.drawio) (8 clases conceptuales, atributos de negocio, multiplicidades y herencia; sin métodos ni claves técnicas).
* **Modelo de Dominio Conceptual (Gráfico Vectorial):** [`03-modelo-dominio.svg`](03-modelo-dominio.svg) (Visualización de clases abstractas).
* **Modelo Entidad-Relación Extendido (Fuente Editable):** [`04-modelo-entidad-relacion.drawio`](04-modelo-entidad-relacion.drawio) (7 entidades en notación Pata de Gallo, entidad débil `FRANJA_HORARIA` y entidad asociativa `CUPON`).
* **Modelo Entidad-Relación Extendido (Gráfico Vectorial):** [`04-modelo-entidad-relacion.svg`](04-modelo-entidad-relacion.svg) (Esquema relacional).
* **Prototipos de Interfaz UI / Mockups:** [`05-prototipos-mockups.md`](05-prototipos-mockups.md) (Pantallas M-01 Catálogo, M-02 Billetera QR con reloj regresivo y M-03 Terminal POS de caja).
* **Lista de Chequeo y Registro de Ajustes:** [`06-lista-chequeo-y-ajustes.md`](06-lista-chequeo-y-ajustes.md) (16 criterios evaluados y 6 hallazgos corregidos y verificados de nuevo).

---

### 1.4 Resultado de la Verificación y Mejoras Aplicadas

Tras aplicar la lista de chequeo formal de validación documental (`06-lista-chequeo-y-ajustes.md`), se obtuvo un resultado satisfactorio de **16 criterios cumplidos sobre 16 evaluados (100%)**.

**Resumen de Ajustes Técnicos Realizados:**
1. **Contingencia en Caja:** Incorporación del flujo alterno de digitación manual de 8 caracteres alfanuméricos (`NUV-8K42`) en plantillas, actividades y mockup de caja, resolviendo posibles fallas de hardware óptico.
2. **Purificación del Dominio:** Eliminación total de métodos de software y claves foráneas en el diagrama de dominio conceptual, preservando la semántica pura del negocio.
3. **Consistencia en Guardas UML:** Incorporación de condiciones explícitas entre corchetes `[ ]` en el 100% de las salidas de decisión en diagramas de actividades.
4. **Normalización Relacional:** Formalización de la entidad asociativa `CUPON` y la entidad débil `FRANJA_HORARIA` con clave primaria compuesta en el MER.
5. **Aislamiento Transaccional:** Modelado explícito del bloqueo de fila `SELECT ... FOR UPDATE` para neutralizar intentos de doble canje por condición de carrera.

---

## PARTE 2: MATRIZ DE TRAZABILIDAD REQUISITO $\rightarrow$ ARTEFACTOS (ANEXO C)

La siguiente matriz traza el **100% de los 20 requisitos funcionales** especificados en la caracterización de la solución, vinculándolos de forma rigurosa y bidireccional a través de cada artefacto de análisis:

| Requisito Funcional | Nombre / Alcance del Requisito | Caso de Uso | Diagrama de Actividades | Plantilla de CU | Clase de Dominio UML | Entidad del MER Relacional | Pantalla Prototipo (Mockup) |
|:---:|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **RF01** | Registro de nuevos visitantes | `CU04` | Diagrama 2 (`CU03` incluye login) | Plantilla CU-03 (Paso 1a) | `Usuario`, `Visitante` | `USUARIO` | `M-01` (Acceso Perfil) |
| **RF02** | Inicio de sesión y token de sesión | `CU04` | Diagrama 2 (`CU03` validación) | Plantilla CU-03 (Paso 1) | `Usuario` | `USUARIO` | `M-01` (Acceso Perfil) |
| **RF03** | Recuperación de credenciales | `CU04` | Flujo Alterno Seguridad | Regla Negocio RN-01 | `Usuario` | `USUARIO` | `M-01` (Modal Acceso) |
| **RF04** | Gestión de perfil de local comercial | `CU05` | Proceso administrativo tienda | Plantilla CU-05 (Paso 1-3) | `Comercio`, `Locatario` | `LOCAL_COMERCIAL` | `M-03` (Encabezado POS) |
| **RF05** | Catálogo general de locales y marcas | `CU01` | Flujo de consulta catálogo | Plantilla CU-03 (Precondición) | `Comercio` | `LOCAL_COMERCIAL` | `M-01` (Directorio y Búsqueda) |
| **RF06** | Ficha detallada de local y menús | `CU01` | Exploración de platos | Plantilla CU-03 (Paso 1) | `MenuProducto` | `PRODUCTO` | `M-01` (Tarjetas de Menú) |
| **RF07** | Algoritmo de filtro por presupuesto | `CU02` | Diagrama 2 (`CU03` inicio) | Plantilla CU-03 (Disparador) | `MenuProducto`, `Promocion` | `PRODUCTO`, `PROMOCION` | `M-01` (Selector de Presupuesto) |
| **RF08** | Búsqueda por texto libre / tags | `CU01` | Filtrado instantáneo | Plantilla CU-03 (Precondición) | `MenuProducto` | `PRODUCTO` | `M-01` (Barra de Búsqueda) |
| **RF09** | Creación y edición de promociones | `CU05` | Proceso publicación ofertas | Plantilla CU-05 (Flujo principal) | `Promocion` | `PROMOCION` | `M-01` (Badges de Descuento) |
| **RF10** | Parametrización de franjas horarias | `CU06` | Diagrama 1 (`CU07` decisión franja) | Plantilla CU-05 (Flujo Alt. 3a) | `Promocion` | `FRANJA_HORARIA` | `M-01` y `M-02` (Horario de Validez) |
| **RF11** | Control de estados de la promoción | `CU05` | Diagrama 1 y 2 (Decisiones estado) | Plantilla CU-05 (Paso 5) | `Promocion` | `PROMOCION` | `M-01` (Disponibilidad) |
| **RF12** | Límite y decremento de stock | `CU05` | Diagrama 2 (`CU03` fork concurrente) | Plantilla CU-03 (Excepción 4a) | `Promocion` | `PROMOCION` | `M-01` (Indicador Stock Restante) |
| **RF13** | Generación criptográfica de cupón | `CU03` | Diagrama 2 (`CU03` rama cripto) | Plantilla CU-03 (Paso 5) | `Cupon` | `CUPON` | `M-02` (Token de Billetera) |
| **RF14** | Renderizado de QR dinámico | `CU03` | Diagrama 2 (`CU03` join final) | Plantilla CU-03 (Paso 6) | `Cupon` | `CUPON` | `M-02` (Matriz QR y Código 8 car) |
| **RF15** | Billetera digital y reloj regresivo | `CU03` | Diagrama 2 (`CU03` actividad cliente) | Plantilla CU-03 (Postcondición) | `Cupon`, `Visitante` | `CUPON` | `M-02` (Reloj regresivo 2 horas) |
| **RF16** | Interfaz operativa de terminal caja | `CU07` | Diagrama 1 (`CU07` calle cajero) | Plantilla CU-07 (Paso 1-3) | `Locatario` | `LOCAL_COMERCIAL` | `M-03` (Consola de Validación POS) |
| **RF17** | Validación transaccional inmediata | `CU08` | Diagrama 1 (`CU07` calle Nuvora) | Plantilla CU-07 (Paso 4) | `Cupon`, `Promocion` | `CUPON`, `PROMOCION` | `M-03` (Panel Verificación en Vivo) |
| **RF18** | Marcado de canje y respuesta visual | `CU07` | Diagrama 1 (`CU07` commit BD) | Plantilla CU-07 (Paso 5-8) | `Cupon`, `BitacoraCanje` | `CUPON`, `BITACORA_CANJE` | `M-03` (Aprobación y Facturación) |
| **RF19** | Prevención de fraude y re-canje | `CU07` | Diagrama 1 (`CU07` excepción 6a) | Plantilla CU-07 (Excepción 6a) | `Cupon`, `BitacoraCanje` | `CUPON`, `BITACORA_CANJE` | `M-03` (Alerta Roja Rechazo Fraude) |
| **RF20** | Bitácora inmutable de auditoría | `CU10` | Diagrama 1 (`CU07` inserción) | Plantilla CU-07 (Paso 6) | `BitacoraCanje` | `BITACORA_CANJE` | `M-03` (Resumen de Turno en Caja) |

---

## 3. Conclusión del Análisis de Trazabilidad

- **Cobertura Absoluta (100%):** Se demuestra que ningún requisito funcional quedó huérfano ni desatendido en el diseño.
- **Consistencia Multidimensional:** Cada entidad modelada en la base de datos relacional se respalda conceptualmente en el modelo de dominio y se operacionaliza a través de los casos de uso y las vistas de usuario correspondientes.
- **Sustentación:** La estructura unificada asegura trazabilidad inmediata ante cualquier requerimiento que sea cuestionado durante la prueba de desempeño y la defensa oral del 28 de noviembre de 2026.

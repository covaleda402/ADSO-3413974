# Informe de Análisis y Matriz de Trazabilidad · Producto 2

> **Centro Comercial San Pedro Plaza · Neiva, Huila**  
> **Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
> **Autor:** `covaleda402`  
> **Rúbrica de Evaluación:** `Rubricas_G1.md` · Sección 5.1 (Artefactos h e i) y Sección 5.2 (Criterio C8 - 15 Puntos)

---

## PARTE 1: INFORME DE ANÁLISIS DE LA SOLUCIÓN (ANEXO E)

### 1.1 Contexto del Negocio y Objetivos del Proyecto

El proyecto **Nuvora** surge como respuesta a la necesidad operativa y comercial identificada en la plazoleta de comidas del **Centro Comercial San Pedro Plaza** (Neiva, Huila). A pesar de contar con un flujo peatonal promedio superior a 12.000 visitantes durante los fines de semana, se detectaron tres problemáticas críticas:
1. **Desbalance en afluencia horaria:** Concentración extrema de pedidos entre las 12:30 p. m. y 1:45 p. m., con caídas abruptas de facturación en franjas valle (2:00 p. m. a 5:30 p. m.).
2. **Fricción en la toma de decisiones por presupuesto:** Los visitantes pierden tiempo recorriendo físicamente los más de 25 locales de comida sin claridad sobre precios, combos o disponibilidad de promociones ajustadas a su capacidad de gasto.
3. **Desconfianza y fraude en cupones físicos o estáticos:** Pérdidas económicas para los locatarios por cupones reutilizados indebidamente mediante capturas de pantalla de WhatsApp o fotocopias no auditadas.

**Objetivo de la Solución:** Desarrollar un ecosistema digital interactivo y transaccional que centralice el directorio gastronómico, permita el filtrado algorítmico por presupuesto en pesos colombianos (`COP`), emita cupones dinámicos con vigencia estricta de 2 horas y provea una estación operativa en caja con validación atómica y registro inmutable de auditoría.

---

### 1.2 Interpretación de Requisitos del Sistema

#### A. Requisitos Funcionales Interpretados (RF-01 al RF-20)
Los 20 requisitos funcionales del sistema fueron organizados e interpretados en cinco módulos operacionales:
1. **Módulo de Identidad y Acceso (RF01 - RF03):** Control de acceso basado en roles (`Visitante`, `Locatario`, `Administrador`) mediante sesiones verificadas con expiración controlada.
2. **Módulo de Catálogo y Presupuesto (RF04 - RF08):** Directorio interactivo de locales comerciales categorizados, buscador por texto libre y filtro de combinaciones de menú por rango monetario.
3. **Módulo Motor de Promociones y Franjas (RF09 - RF12):** Gestión integral de ofertas con inventario (cupos) asignado, parametrización de franjas horarias restrictivas y control de estados de ciclo de vida.
4. **Módulo Billetera Digital y Cupones (RF13 - RF15):** Generación única de cupones con código corto y representación QR temporal, más billetera del visitante con reloj regresivo de 2 horas (RN-02) y regla de 1 cupón activo por promoción cada 24 h (RN-01).
5. **Módulo de Redención en Caja y Analítica (RF16 - RF20):** Estación operativa de punto de venta con lector óptico o digitación manual de contingencia, validación exclusiva atómica contra doble canje, métricas por campaña (RF19) y bitácora inmutable de auditoría (RF20).

#### B. Requisitos No Funcionales Interpretados (ISO/IEC 25010)
- **Rendimiento (RNF01):** Tiempo de respuesta en la validación del cupón en caja $\le 1.5$ segundos bajo condiciones reales de red comercial.
- **Seguridad (RNF02, RNF03):** Protección irreversible de credenciales con sal y generación con entropía criptográfica de cupones para evitar falsificaciones o enumeración.
- **Fiabilidad e Integridad (RNF04, RNF05):** Aislamiento transaccional estricto para neutralizar condiciones de carrera (*race conditions*) y disponibilidad de servicio $\ge 99.5\%$ en horario comercial.
- **Usabilidad (RNF06):** Interfaz adaptativa móvil operable a una mano, con contraste visual accesible (WCAG 2.1 AA) para lectura clara bajo luz diurna.
- **Continuidad Operativa (RNF08, RNF10):** Mecanismo de contingencia manual operativo en caja ante fallas de hardware óptico o deterioro de pantalla.

---

### 1.3 Catálogo de Enlaces a los Modelos de Análisis

La solución conceptual ha sido formalmente modelada y se encuentra documentada en los siguientes artefactos de este repositorio:

* **Plantillas Extendidas de Casos de Uso:** [`01-plantillas-casos-de-uso.md`](01-plantillas-casos-de-uso.md) (Especificación de CU03, CU05 y CU07 con 8 pasos, flujos alternos y excepciones, sin detalles de implementación).
* **Diagramas de Actividades UML (Fuente Editable):** [`02-diagramas-actividades.drawio`](02-diagramas-actividades.drawio) (Diagramas editables con calles, decisiones, guardas `[ ]` y nota explícita sobre ejecución secuencial atómica sin bifurcaciones concurrentes).
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
2. **Purificación Conceptual (Análisis):** Eliminación de métodos, claves foráneas y detalles de implementación SQL/tecnológicos dentro del dominio y las plantillas extendidas (Reglas de arbitraje #5 y #10).
3. **Consistencia en Guardas UML:** Incorporación de condiciones explícitas entre corchetes `[ ]` en el 100% de las salidas de decisión en diagramas de actividades y justificación escrita de ejecución atómica secuencial.
4. **Normalización Relacional:** Formalización de la entidad asociativa `CUPON` y la entidad débil `FRANJA_HORARIA` con clave primaria compuesta en el MER.
5. **Aislamiento Transaccional:** Especificación de validación atómica con bloqueo exclusivo del cupón para neutralizar intentos de doble canje concurrente.

---

## PARTE 2: MATRIZ DE TRAZABILIDAD REQUISITO → ARTEFACTOS (ANEXO C)

La siguiente matriz traza el **100% de los 20 requisitos funcionales** especificados en la caracterización de la solución, vinculándolos de forma rigurosa y bidireccional a través de cada artefacto de análisis:

| Requisito Funcional | Nombre / Alcance del Requisito | Caso de Uso | Diagrama de Actividades | Plantilla de CU | Clase de Dominio UML | Entidad del MER Relacional | Pantalla Prototipo (Mockup) |
|:---:|---|:---:|:---:|:---:|:---:|:---:|:---:|
| **RF01** | Registro de nuevos visitantes | `CU04` | Diagrama 2 (`CU03` valida sesión) | Plantilla CU03 (FA-01) | `Usuario`, `Visitante` | `USUARIO` | `M-02` (Acceso perfil/sesión) |
| **RF02** | Inicio de sesión y credenciales | `CU04` | Diagrama 2 (`CU03` validación sesión) | Plantilla CU03 (Paso 4) | `Usuario` | `USUARIO` | `M-02` (Autenticación usuario) |
| **RF03** | Recuperación básica de contraseña | `CU04` | Diagrama 2 (Flujo acceso `CU04`) | Plantilla CU03 (FA-01) | `Usuario` | `USUARIO` | `M-02` (Acceso cuenta) |
| **RF04** | Gestión de perfil de local comercial | `CU05` | Proceso administrativo de comercio | Plantilla CU05 (Precondición 2) | `Comercio`, `Locatario` | `LOCAL_COMERCIAL` | `M-03` (Encabezado POS local) |
| **RF05** | Catálogo general de locales y marcas | `CU01` | Diagrama 2 (`CU03` catálogo inicial) | Plantilla CU03 (Paso 1) | `Comercio` | `LOCAL_COMERCIAL` | `M-01` (Directorio de locales) |
| **RF06** | Ficha detallada de local y menús | `CU01` | Diagrama 2 (Selección oferta) | Plantilla CU03 (Paso 1) | `MenuProducto` | `PRODUCTO` | `M-01` (Tarjetas de menú) |
| **RF07** | Algoritmo de filtro por presupuesto | `CU02` | Diagrama 2 (`CU03` inicio) | Plantilla CU03 (FA-02) | `MenuProducto`, `Promocion` | `PRODUCTO`, `PROMOCION` | `M-01` (Selector de presupuesto) |
| **RF08** | Búsqueda por texto libre / tags | `CU01` | Diagrama 2 (Exploración catálogo) | Plantilla CU03 (Paso 1) | `MenuProducto`, `Comercio` | `PRODUCTO`, `LOCAL_COMERCIAL` | `M-01` (Barra de búsqueda) |
| **RF09** | Creación y edición de promociones | `CU05` | Proceso de oferta en catálogo | Plantilla CU05 (Flujo principal) | `Promocion` | `PROMOCION` | `M-01` (Badges de descuento) |
| **RF10** | Parametrización de franjas horarias | `CU06` | Diagrama 1 (`CU07` verifica horario) | Plantilla CU05 (Paso 4 / EX-02) | `Promocion` | `FRANJA_HORARIA` | `M-01` (Horario de validez) |
| **RF11** | Control de estados de la promoción | `CU05` | Diagrama 2 (Decisión promo activa) | Plantilla CU05 (FA-01 / Paso 8) | `Promocion` | `PROMOCION` | `M-01` (Disponibilidad activa) |
| **RF12** | Límite de cupos por promoción | `CU05` | Diagrama 2 (`CU03` decisión cupos > 0) | Plantilla CU03 (EX-01) / CU05 (Paso 6) | `Promocion` | `PROMOCION` | `M-01` (Indicador cupos disponibles) |
| **RF13** | Generación de cupón único | `CU03` | Diagrama 2 (`CU03` genera identificador) | Plantilla CU03 (Paso 6) | `Cupon` | `CUPON` | `M-01` / `M-02` (Emisión y código) |
| **RF14** | Renderizado de código QR dinámico | `CU03` | Diagrama 2 (`CU03` renderiza QR) | Plantilla CU03 (Paso 8) | `Cupon` | `CUPON` | `M-02` (Matriz QR y código 8 car) |
| **RF15** | Billetera de cupones del visitante | `CU03` | Diagrama 2 (`CU03` muestra en billetera) | Plantilla CU03 (Paso 8) | `Cupon`, `Visitante` | `CUPON` | `M-02` (Billetera y reloj 2 horas) |
| **RF16** | Interfaz operativa de caja (POS) | `CU07` / `CU09` | Diagrama 1 (`CU07` calle cajero y contingencia) | Plantilla CU07 (Pasos 1-3 / FA-01) | `Locatario` | `LOCAL_COMERCIAL` | `M-03` (Escáner e ingreso manual) |
| **RF17** | Validación transaccional inmediata | `CU07` / `CU08` | Diagrama 1 (`CU07` calle sistema) | Plantilla CU07 (Pasos 4-5) | `Cupon`, `Promocion` | `CUPON`, `PROMOCION` | `M-03` (Validación y alertas EX-01..04) |
| **RF18** | Respuesta visual de redención y marcado | `CU07` | Diagrama 1 (`CU07` confirma redención) | Plantilla CU07 (Pasos 6-8) | `Cupon`, `BitacoraCanje` | `CUPON`, `BITACORA_CANJE` | `M-03` (Confirmación verde de cobro) |
| **RF19** | Dashboard de métricas para el locatario | `CU10` | Flujo analítico de campañas | Plantilla CU05 (Postcondición) / CU07 (Paso 7) | `Promocion`, `Cupon`, `BitacoraCanje` | `PROMOCION`, `CUPON`, `BITACORA_CANJE` | `M-03` (Resumen del turno / métricas) |
| **RF20** | Bitácora inmutable de auditoría | `CU10` | Diagrama 1 (`CU07` asienta auditoría) | Plantilla CU07 (Paso 7) | `BitacoraCanje` | `BITACORA_CANJE` | `M-03` (Resumen e historial de auditoría) |

---

## 3. Conclusión del Análisis de Trazabilidad

- **Cobertura Absoluta (100%):** Se demuestra que ningún requisito funcional quedó huérfano ni desatendido en el diseño.
- **Consistencia Multidimensional:** Cada entidad modelada en la base de datos relacional se respalda conceptualmente en el modelo de dominio y se operacionaliza a través de los casos de uso y las vistas de usuario correspondientes.
- **Sustentación:** La estructura unificada asegura trazabilidad inmediata ante cualquier requerimiento que sea cuestionado durante la prueba de desempeño y la defensa oral del 28 de noviembre de 2026.


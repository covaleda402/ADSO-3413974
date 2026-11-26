# 04 · Especificación de Casos de Uso y Matriz de Trazabilidad
## Proyecto Formativo: Nuvora — Ecosistema Digital San Pedro Plaza
**Ficha SENA:** 3413974 · ADSO · Regional Huila  
**Aprendiz:** `covaleda402`  

---

## 1. Identificación de Actores del Sistema

Los actores se modelan en el exterior de la frontera del sistema para garantizar el cumplimiento de los estándares UML y la Sección 7 de las Rúbricas:

1. **Visitante / Consumidor (Actor Primario):** Usuario que recorre el centro comercial San Pedro Plaza; consulta la oferta gastronómica, aplica el filtro de presupuesto y solicita cupones de descuento.
2. **Locatario / Administrador de Tienda (Actor Primario):** Comerciante que administra el perfil de su establecimiento, sus combos y define promociones u ofertas relámpago.
3. **Cajero / Validador en Punto de Venta (Actor Primario):** Operador en el mostrador del restaurante que escanea o valida cupones para aplicar el descuento antes del cobro físico.
4. **Administrador del Centro Comercial (San Pedro Plaza - Actor Primario de Gestión):** Gestor del centro comercial encargado de dar de alta los locales de la plazoleta, supervisar las categorías comerciales y auditar las métricas globales de conversión y seguridad en el centro comercial.

---

## 2. Catálogo de Casos de Uso (Notación Verbo + Objeto)

Se definen **diez (10) casos de uso estructurados**, superando el mínimo de 8 exigido en la rúbrica:

* **CU01: Consultar catálogo de locales y menús:** Permite al visitante explorar la oferta gastronómica y de marcas de San Pedro Plaza por categorías y palabras clave.
* **CU02: Filtrar productos por presupuesto:** Permite al visitante ingresar un valor máximo en pesos ($COP) y obtener los combos y platos cuyo precio se ajusta a su bolsillo.
* **CU03: Generar cupón digital de descuento:** Permite al visitante autenticado solicitar una promoción vigente, obteniendo un identificador alfanumérico único renderizado en QR.
* **CU04: Autenticar usuario en la plataforma:** Valida las credenciales de acceso de los usuarios emitiendo un token seguro (JWT) según su rol.
* **CU05: Gestionar promociones del local:** Permite al locatario crear, modificar, pausar y consultar las ofertas asociadas a sus productos.
* **CU06: Parametrizar franjas horarias de ofertas relámpago:** Permite al locatario restringir la validez de una promoción a días y horas específicas de baja afluencia.
* **CU07: Canjear cupón de descuento en caja:** Permite al cajero redimir el descuento del cliente en el punto de venta de forma atómica en menos de 1.5 segundos.
* **CU08: Verificar código QR criptográfico:** Proceso de verificación en el servidor que comprueba existencia, vigencia, coincidencia de local y unicidad del cupón.
* **CU09: Digitar código de cupón manualmente:** Mecanismo alternativo de contingencia cuando la cámara del cajero o la pantalla del cliente presentan fallas de lectura óptica.
* **CU10: Consultar métricas de conversión y auditoría:** Permite al locatario visualizar estadísticas de cupones emitidos vs. redimidos y revisar la bitácora inmutable.

---

## 3. Justificación de Relaciones «include» y «extend» (Regla de Arbitraje)

Conforme a la Sección 7 de `Rubricas_G1.md`, se justifica formalmente cada relación modelada:

| Caso Origen | Relación | Caso Destino | Justificación Técnica de la Relación (1 Línea) |
| :--- | :---: | :--- | :--- |
| **CU03** (Generar cupón) | `«include»` | **CU04** (Autenticar usuario) | **Obligatorio siempre:** La visualización del catálogo es libre, pero la emisión del cupón exige obligatoriamente validar la identidad del usuario para controlar el límite de 1 cupón por día (RN-01). |
| **CU07** (Canjear cupón) | `«include»` | **CU08** (Verificar código QR) | **Obligatorio siempre:** Ningún cajero puede otorgar el descuento sin que el servidor valide atómicamente la autenticidad, vigencia y estado no redimido del código (RN-04). |
| **CU06** (Parametrizar franja horaria) | `«extend»` | **CU05** (Gestionar promociones) | **Opcional y condicional:** Solo se activa en el punto de extensión *«Configuración de Oferta Relámpago»* cuando el locatario decide condicionar la promo a horarios específicos; una promo general no la requiere. |
| **CU09** (Digitar código manual) | `«extend»` | **CU07** (Canjear cupón) | **Opcional y condicional:** Solo se activa en el punto de extensión *«Falla en lectura óptica»* como vía de contingencia operativa si la cámara no logra escanear el QR físico o digital. |

> **Nota sobre el sentido de las flechas:**  
> - En las relaciones `«include»`, la flecha discontinua apunta desde el caso base que lo necesita hacia el caso incluido (ej. `CU07 --> CU08`).  
> - En las relaciones `«extend»`, la flecha discontinua apunta desde el caso que añade funcionalidad hacia el caso base receptor (ej. `CU06 --> CU05` y `CU09 --> CU07`), indicando el punto de extensión.

---

## 4. Matriz de Trazabilidad: Requisito Funcional → Caso de Uso

Se traza el **100% de los 20 Requerimientos Funcionales (RF)** especificados en el documento SRS v2.0 de Nuvora, superando con holgura el 90% mínimo exigido en el Criterio C3:

| ID Requisito Funcional | Nombre del Requisito Funcional | Módulo del Sistema | Caso de Uso que lo Atiende | Tipo de Cobertura |
| :---: | :--- | :--- | :---: | :---: |
| **RF01** | Registro de Visitantes | Autenticación y Usuarios | **CU04** | Total (100%) |
| **RF02** | Inicio de Sesión y Manejo de Tokens | Autenticación y Usuarios | **CU04** | Total (100%) |
| **RF03** | Recuperación Básica de Contraseña | Autenticación y Usuarios | **CU04** | Total (100%) |
| **RF04** | Gestión de Perfil de Local | Gestión Locatario | **CU05** | Total (100%) |
| **RF05** | Catálogo General de Locales y Plazoleta | Directorio y Búsqueda | **CU01** | Total (100%) |
| **RF06** | Ficha Detallada de Local y Menú Digital | Directorio y Búsqueda | **CU01** | Total (100%) |
| **RF07** | Algoritmo de Búsqueda y Filtro por Presupuesto | Directorio y Búsqueda | **CU02** | Total (100%) |
| **RF08** | Búsqueda por Texto Libre | Directorio y Búsqueda | **CU01** | Total (100%) |
| **RF09** | Creación de Promociones | Motor de Promociones | **CU05** | Total (100%) |
| **RF10** | Parametrización de Franjas Horarias | Motor de Promociones | **CU06** | Total (100%) |
| **RF11** | Control de Estados de Promoción | Motor de Promociones | **CU05** | Total (100%) |
| **RF12** | Límite de Cupos por Promoción | Motor de Promociones | **CU05** | Total (100%) |
| **RF13** | Generación Criptográfica de Cupón | Billetera y Cupones | **CU03** | Total (100%) |
| **RF14** | Renderizado de Código QR Dinámico | Billetera y Cupones | **CU03** | Total (100%) |
| **RF15** | Billetera de Cupones del Visitante | Billetera y Cupones | **CU03** | Total (100%) |
| **RF16** | Interfaz Operativa de Caja | Validación y Redención | **CU07 / CU09** | Total (100%) |
| **RF17** | Validación Transaccional Inmediata | Validación y Redención | **CU07 / CU08** | Total (100%) |
| **RF18** | Respuesta Visual de Redención y Marcado | Validación y Redención | **CU07** | Total (100%) |
| **RF19** | Dashboard de Métricas para el Locatario | Analítica y Auditoría | **CU10** | Total (100%) |
| **RF20** | Bitácora Inmutable de Auditoría | Analítica y Auditoría | **CU10** | Total (100%) |

---

## 5. Diferenciación Formal entre Requisitos Funcionales y No Funcionales

Para satisfacer la distinción explícita exigida en el Criterio C3 (RAP 592373):

* **Requisitos Funcionales (RF01 - RF20):** Describen las capacidades, comportamientos específicos, cálculos y servicios que el sistema Nuvora debe ejecutar en respuesta a las acciones de los actores (detallados en la matriz anterior).
* **Requisitos No Funcionales (RNF01 - RNF10):** Definen los atributos de calidad, rendimiento, seguridad y restricciones normativas bajo el estándar internacional **ISO/IEC 25010** que condicionan la operación del software:

| ID | Categoría ISO 25010 | Descripción Técnica del Requisito No Funcional | Métrica / Criterio de Aceptación |
| :---: | :--- | :--- | :--- |
| **RNF01** | **Eficiencia de Desempeño (Rendimiento)** | Tiempo de respuesta en la validación transaccional del código QR en el punto de venta de caja. | $\le 1.5$ segundos bajo condiciones de red estándar (4G/Wi-Fi). |
| **RNF02** | **Seguridad (Confidencialidad)** | Almacenamiento seguro de credenciales de acceso de usuarios y locatarios. | Contraseñas protegidas mediante algoritmo de dispersión irreversible bcrypt con factor de costo $\ge 10$ y sal (*salt*). |
| **RNF03** | **Seguridad (Autenticidad)** | Generación criptográfica de identificadores de cupones digitales y tokens de sesión. | Tokens de sesión mediante JWT (JSON Web Tokens) firmados con algoritmo HMAC-SHA256 y cupones alfanuméricos con entropía criptográfica pseudoaleatoria. |
| **RNF04** | **Fiabilidad (Integridad Transaccional)** | Prevención de condiciones de carrera (*race conditions*) y doble canje concurrente de promociones con cupo limitado. | Transacciones ACID implementadas a nivel de motor relacional (PostgreSQL) con bloqueo a nivel de fila (`SELECT ... FOR UPDATE`). |
| **RNF05** | **Fiabilidad (Disponibilidad)** | Disponibilidad continua del servicio durante las franjas horarias de operación comercial del centro comercial. | $\ge 99.5\%$ de disponibilidad en el horario de 10:00 a. m. a 9:00 p. m. de lunes a domingo. |
| **RNF06** | **Usabilidad (Operabilidad)** | Interfaz adaptable (*Mobile-First*) optimizada para consumo ágil en pantallas móviles y facilidad de escaneo. | Diseño responsivo testeado en viewports de 360px a 430px y contraste visual WCAG 2.1 nivel AA para visualización del QR en pantalla. |
| **RNF07** | **Capacidad (Concurrencia)** | Capacidad de soporte de carga en horas pico de almuerzo y cena en la plazoleta de comidas de San Pedro Plaza. | Soporte de hasta 50 peticiones simultáneas por segundo sin degradación de rendimiento. |
| **RNF08** | **Mantenibilidad (Modularidad)** | Desacoplamiento entre la capa de presentación frontend y los servicios de backend/datos. | Arquitectura basada en API RESTful con contratos de interfaz claros y serialización en formato JSON. |
| **RNF09** | **Cumplimiento Legal (Privacidad)** | Adherencia a la legislación colombiana vigente en materia de tratamiento de datos personales. | Cumplimiento estricto de la Ley Estatutaria 1581 de 2012 (Habeas Data) en el registro y captura de correos electrónicos. |
| **RNF10** | **Resiliencia (Recuperabilidad)** | Continuidad operativa del punto de venta en caso de falla en el hardware de captura óptica (cámara/escáner). | Disponibilidad del flujo alterno de digitación manual de código alfanumérico en caja con validación inmediata. |


# 04 · Especificación de Casos de Uso y Matriz de Trazabilidad
## Proyecto Formativo: Nuvora — Ecosistema Digital San Pedro Plaza
**Ficha SENA:** 3413974 · ADSO · Regional Huila  
**Aprendiz:** Jose Esneider Covaleda Hortua  

---

## 1. Identificación de Actores del Sistema

Los actores se modelan en el exterior de la frontera del sistema para garantizar el cumplimiento de los estándares UML y la Sección 7 de las Rúbricas:

1. **Visitante / Consumidor (Actor Primario):** Usuario que recorre el centro comercial San Pedro Plaza; consulta la oferta gastronómica, aplica el filtro de presupuesto y solicita cupones de descuento.
2. **Locatario / Administrador de Tienda (Actor Primario):** Comerciante que administra el perfil de su establecimiento, sus combos y define promociones u ofertas relámpago.
3. **Cajero / Validador en Punto de Venta (Actor Primario):** Operador en el mostrador del restaurante que escanea o valida cupones para aplicar el descuento antes del cobro físico.
4. **Servidor Transaccional / Base de Datos (Actor Secundario):** Componente tecnológico que ejecuta la transacción atómica (`SELECT FOR UPDATE`), valida la hora del servidor y sella la auditoría.

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

* **Requisitos Funcionales (RF01 - RF20):** Describen las capacidades, comportamientos específicos, cálculos y servicios que el sistema Nuvora debe ejecutar en respuesta a las acciones de los actores (ej. generar un código QR, aplicar una franja horaria, verificar unicidad de redención).
* **Requisitos No Funcionales (RNF01 - RNF10):** Definen las restricciones de calidad, rendimiento y marco regulatorio bajo las cuales deben operar las funciones:
  - **RNF01 (Rendimiento):** Tiempo de respuesta en caja $\le$ 1.5 segundos.
  - **RNF02 y RNF03 (Seguridad):** Hashing con sal para claves y tokens pseudoaleatorios impredecibles para los cupones.
  - **RNF04 (Integridad):** Transacciones ACID en PostgreSQL con `SELECT FOR UPDATE` para evitar doble canje concurrente.
  - **RNF09 (Legal):** Cumplimiento de la Ley 1581 de 2012 de Habeas Data en Colombia para la recolección de correos.

# Modelo Lógico Relacional y Cuadro de Reglas de Transformación (B2)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** `covaleda402`  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C2)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Introducción y Metodología de Transformación Lógica

El diseño lógico de base de datos de **Nuvora** transforma las entidades y asociaciones del modelo conceptual en un esquema relacional estricto normalizado en **Tercera Forma Normal (3FN)**. 

El modelo lógico consta de **diez (10) tablas relacionales** fuertemente tipadas en estándar ANSI SQL para el motor **PostgreSQL 15+**, con definición formal de claves primarias (`PK`), claves foráneas (`FK`), tablas puente para todas las relaciones $N:M$ y atributos multivaluados, restricciones de unicidad (`UNIQUE`) y reglas de dominio (`CHECK`).

Los diagramas lógicos se encuentran disponibles en:
* **Vector de alta resolución:** [`02-modelo-logico-relacional.svg`](./02-modelo-logico-relacional.svg)
* **Fuente editable Draw.io:** [`02-modelo-logico-relacional.drawio`](./02-modelo-logico-relacional.drawio)

---

## 2. Cuadro de Reglas de Transformación Conceptual $\longrightarrow$ Lógica Relacional

Para dar cumplimiento exhaustivo al Criterio C2 de la Rúbrica G2-P2, a continuación se documentan las reglas de transformación aplicadas sobre cada estructura del modelo de datos:

| # | Regla de Transformación Formal | Caso Concreto en el Negocio de Nuvora | Resultado en el Modelo Lógico Relacional |
|:---:|---|---|---|
| **1** | **Relación Muchos a Muchos ($N:M$) $\longrightarrow$ Tabla Intermedia Asociativa** | **(a)** Un `Usuario` adquiere múltiples `Promocion` y una `Promocion` se asigna a múltiples usuarios.<br>**(b)** Una `Promocion` aplica a uno o varios `MenuProducto` y un plato puede participar en múltiples promociones. | **(a)** Se crea **`cupon`** (`id_cupon` PK, `id_usuario_visitante` FK, `id_promocion` FK) con atributos propios (`codigo_alfanumerico`, `token_dinamico_hash`, fechas y `estado_canje`).<br>**(b)** Se crea la tabla puente **`promocion_producto`** con clave primaria compuesta `(id_promocion PK/FK, id_producto PK/FK)`. |
| **2** | **Relación Uno a Muchos ($1:N$) $\longrightarrow$ Clave Foránea en el Lado «Muchos»** | Un `Local Comercial` ofrece múltiples `MenuProducto` en su carta, y una `CategoriaComercio` clasifica múltiples locales. | La tabla **`producto`** recibe **`id_local (FK)`** hacia `local_comercial(id_local)` (`NOT NULL`, `ON DELETE RESTRICT`), y **`local_comercial`** recibe **`id_categoria (FK)`** hacia `categoria_comercio`. |
| **3** | **Relación Uno a Uno ($1:1$) $\longrightarrow$ Clave Foránea con Restricción `UNIQUE`** | Cada canje registrado en `bitacora_canje` audita exactamente una instancia de `cupon`, y un cupón solo puede ser canjeado con éxito una única vez. | La tabla **`bitacora_canje`** contiene la clave foránea **`id_cupon (FK, UNIQUE)`**, garantizando a nivel de motor de base de datos la imposibilidad física de duplicar redenciones para un mismo cupón. |
| **4** | **Atributo Multivaluado $\longrightarrow$ Tabla Independiente con FK** | Un visitante parametriza múltiples preferencias gastronómicas (`preferencias_gastronomicas [*]`, ej. "Comida Rápida", "Postres", "Parrilla"). | Se extrae el atributo multivaluado hacia la tabla **`preferencia_visitante`**, con clave primaria compuesta `(id_usuario PK/FK, categoria_preferida PK)` y FK hacia `usuario(id_usuario)` con `ON DELETE CASCADE`. |
| **5** | **Generalización / Herencia $\longrightarrow$ Tabla Única con Discriminador de Rol (*Single Table Inheritance*)** | La entidad `Usuario` agrupa atributos y credenciales de los roles `VISITANTE`, `LOCATARIO` y `ADMINISTRADOR`. | Se implementa la tabla consolidada **`usuario`** con una columna discriminadora **`tipo_rol (VARCHAR(20) + CHECK)`**, evitando *JOINs* costosos en autenticación frecuente y manteniendo integridad de roles. |
| **6** | **Entidad Débil por Dependencia de Identificación $\longrightarrow$ Clave Primaria Compuesta** | Las ventanas horarias de validez de una promoción no tienen existencia ni identidad sin la promoción que restringen. | La tabla **`franja_horaria`** implementa una **clave primaria compuesta**: `(id_promocion PK/FK, dia_semana PK, hora_inicio PK)` con `ON DELETE CASCADE`. |

---

## 3. Catálogo de Tablas del Modelo Lógico Relacional (10 Tablas)

1. **`usuario`:** Almacena la identidad digital, credenciales dispersadas (hash + sal bcrypt), rol en la plazoleta (`VISITANTE`, `LOCATARIO`, `ADMINISTRADOR`) y estado de la cuenta.
2. **`preferencia_visitante`:** Tabla independiente derivada del atributo multivaluado `preferencias_gastronomicas [*]` de cada visitante (PK compuesta).
3. **`categoria_comercio`:** Catálogo normalizado de categorías gastronómicas y tasas comerciales (3FN) que clasifica los locales de la plazoleta.
4. **`local_comercial`:** Representa los comercios de la plazoleta del Centro Comercial San Pedro Plaza.
5. **`producto`:** Catálogo de platos, combos y bebidas ofrecidos por cada comercio con precios base en COP.
6. **`promocion`:** Campañas de descuento con inventario (stock) asignado, porcentaje de rebaja y ventana de fechas.
7. **`promocion_producto`:** Tabla puente ($N:M$) que vincula cada campaña promocional con los platos del menú elegibles para descuento.
8. **`franja_horaria`:** Entidad débil que restringe las promociones a días específicos y franjas valle de baja afluencia.
9. **`cupon`:** Entidad asociativa ($N:M$) que materializa la emisión de un cupón digital con token QR efímero de 2 horas.
10. **`bitacora_canje`:** Registro transaccional inmutable que asienta cada validación en punto de venta con hash de integridad (1:1 con cupón).


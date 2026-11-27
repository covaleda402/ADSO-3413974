# Evidencia de Normalización Paso a Paso: 0FN → 1FN → 2FN → 3FN (B3)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** `covaleda402`  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C3)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Introducción y Marco Teórico de Normalización

Para certificar el cumplimiento riguroso del **Criterio C3 de la Rúbrica G2-P2**, se documenta el proceso formal de normalización aplicado sobre **dos (2) estructuras de datos reales** del caso de estudio **Nuvora**:

1. **Caso 1 (Llave Compuesta y Dependencia Parcial - 2FN):** Estructura desnormalizada de emisión y redención de cupones (`cupon_redencion_detalle`).
2. **Caso 2 (Dependencia Transitiva - 3FN):** Estructura desnormalizada de locales comerciales, promociones y categorías tributarias (`comercio_promocion_registro`).

Cada caso se expone paso a paso desde el estado no normalizado (**0FN**) hasta la **Tercera Forma Normal (3FN)**, formulando explícitamente las **Dependencias Funcionales (DF)**, los defectos identificados en cada paso y el esquema relacional resultante.

---

## 2. Caso 1: Normalización de la Estructura de Cupones y Redenciones (Llave Compuesta)

### 2.1 Estado Inicial No Normalizado (0FN)
Se parte de un reporte plano de transacciones de caja donde se consolidaban los datos del visitante, la promoción adquirida y el canje en la terminal:

```sql
cupon_redencion_0fn (
  id_usuario, 
  id_promocion, 
  codigo_alfanumerico, 
  nombre_completo_visitante, 
  preferencias_gastronomicas, 
  correo_visitante, 
  titulo_oferta, 
  porcentaje_descuento, 
  stock_disponible, 
  id_local, 
  fecha_hora_emision, 
  fecha_hora_expiracion, 
  fecha_hora_canje, 
  monto_descuento_efectivo, 
  terminal_pos_caja, 
  cajero_responsable
)
```
* **Llave Primaria Candidata Compuesta:** `{id_usuario, id_promocion, codigo_alfanumerico}`
* **Defectos en 0FN:** 
  1. El campo `preferencias_gastronomicas` es multivaluado (contiene múltiples categorías gastronómicas de interés separadas por comas en una misma celda: ej. `"Comida Rápida, Parrilla, Postres"`).
  2. Existen dependencias parciales donde atributos de la persona y de la oferta dependen únicamente de una parte de la llave compuesta.

---

### 2.2 Transición a Primera Forma Normal (1FN)
* **Regla 1FN:** Una tabla está en 1FN si y solo si todos los atributos son atómicos (indivisibles) y no existen grupos repetitivos ni columnas con múltiples valores en una sola celda.
* **Violación Detectada:** La columna `preferencias_gastronomicas` viola la atomicidad.
* **Acción de Normalización:** Se extrae el atributo multivaluado hacia una tabla satélite independiente `preferencia_visitante(id_usuario, categoria_preferida)` con clave primaria compuesta `{id_usuario, categoria_preferida}` y se remueve la columna multivaluada de la tabla principal.

**Dependencias Funcionales Identificadas en 1FN:**
* $DF_1: \{id\_usuario\} \longrightarrow \{nombre\_completo\_visitante, correo\_visitante\}$
* $DF_2: \{id\_promocion\} \longrightarrow \{titulo\_oferta, porcentaje\_descuento, stock\_disponible, id\_local\}$
* $DF_3: \{id\_usuario, id\_promocion, codigo\_alfanumerico\} \longrightarrow \{fecha\_hora\_emision, fecha\_hora\_expiracion, fecha\_hora\_canje, monto\_descuento\_efectivo, terminal\_pos\_caja, cajero\_responsable\}$

**Estado Resultante en 1FN:**
* `cupon_redencion_1fn(id_usuario, id_promocion, codigo_alfanumerico, nombre_completo_visitante, correo_visitante, titulo_oferta, porcentaje_descuento, stock_disponible, id_local, fecha_hora_emision, fecha_hora_expiracion, fecha_hora_canje, monto_descuento_efectivo, terminal_pos_caja, cajero_responsable)`
* `preferencia_visitante(id_usuario, categoria_preferida)`

---

### 2.3 Transición a Segunda Forma Normal (2FN) — Eliminación de Dependencias Parciales
* **Regla 2FN:** Una tabla está en 2FN si está en 1FN y **ningún atributo no clave depende funcionalmente de un subconjunto propio de una llave primaria compuesta** (no existen dependencias parciales).
* **Violación Detectada:** 
  * $DF_1$: `nombre_completo_visitante` y `correo_visitante` dependen únicamente de `{id_usuario}`, que es solo una parte de la llave compuesta `{id_usuario, id_promocion, codigo_alfanumerico}`.
  * $DF_2$: `titulo_oferta`, `porcentaje_descuento`, `stock_disponible` e `id_local` dependen únicamente de `{id_promocion}`, otra parte de la llave compuesta.
* **Acción de Normalización:** Se descomponen las entidades fuertes `usuario` y `promocion`, dejando en la tabla asociativa `cupon` únicamente los atributos que dependen estrictamente de la llave completa.

**Estado Resultante en 2FN:**
1. **`usuario`** (`id_usuario` [PK], `nombre_completo`, `correo_electronico`)
2. **`promocion`** (`id_promocion` [PK], `titulo_oferta`, `porcentaje_descuento`, `stock_disponible`, `id_local`)
3. **`cupon_transaccional`** (`id_usuario` [FK], `id_promocion` [FK], `codigo_alfanumerico` [PK/AK], `fecha_hora_emision`, `fecha_hora_expiracion`, `fecha_hora_canje`, `monto_descuento_efectivo`, `terminal_pos_caja`, `cajero_responsable`)

---

### 2.4 Transición a Tercera Forma Normal (3FN) — Eliminación de Dependencias Transitivas
* **Regla 3FN:** Una tabla está en 3FN si está en 2FN y **ningún atributo no clave depende transitivamente de la llave primaria** ($X \longrightarrow Y \longrightarrow Z$).
* **Violación Detectada en `cupon_transaccional`:**
  * La llave identifica la emisión del cupón: `{id_cupon} \longrightarrow {codigo_alfanumerico, fecha_hora_emision, fecha_hora_expiracion, estado_canje}`.
  * Los atributos de la auditoría física del cobro (`monto_descuento_efectivo`, `terminal_pos_caja`, `cajero_responsable`) solo existen si el cupón fue efectivamente redimido en la caja POS y dependen funcionalmente del hecho transaccional del canje. Al mantenerlos juntos, los cupones que aún no han sido canjeados tienen que almacenar valores nulos (`NULL`) en dichas columnas, violando la pureza de 3FN y generando anomalías de inserción.
* **Acción de Normalización:** Se separa la entidad transaccional inmutable **`bitacora_canje`** vinculada por clave foránea única (`id_cupon`).

**Esquema Final en 3FN (Caso 1):**
* **`usuario`** (`id_usuario` [PK], `nombre_completo`, `correo_electronico`, `telefono_contacto`, `tipo_rol`, `estado_cuenta`)
* **`preferencia_visitante`** (`id_usuario` [PK, FK], `categoria_preferida` [PK])
* **`promocion`** (`id_promocion` [PK], `id_local` [FK], `titulo_oferta`, `porcentaje_descuento`, `stock_total_asignado`, `stock_disponible`)
* **`cupon`** (`id_cupon` [PK], `id_usuario_visitante` [FK], `id_promocion` [FK], `codigo_alfanumerico` [UQ], `token_dinamico_hash`, `fecha_hora_emision`, `fecha_hora_expiracion`, `estado_canje`)
* **`bitacora_canje`** (`id_canje` [PK], `id_cupon` [FK, UQ], `id_usuario_cajero` [FK], `id_local` [FK], `fecha_hora_canje`, `monto_descuento_aplicado`, `numero_factura_pos`, `ip_origen_terminal`, `firma_hash_transaccion`)

---

## 3. Caso 2: Normalización de Locales, Categorías y Régimen Tributario (Dependencia Transitiva)

### 3.1 Estado Inicial No Normalizado (0FN)
Se analiza la estructura administrativa de liquidación de locales comerciales, menús y categorías gastronómicas del Centro Comercial San Pedro Plaza:

```sql
comercio_categoria_0fn (
  id_local, 
  numero_local, 
  razon_social, 
  categoria_gastronomica, 
  porcentaje_retencion_cc, 
  administrador_categoria, 
  horario_apertura, 
  horario_cierre, 
  estado_operativo
)
```
* **Llave Primaria Simple:** `{id_local}`
* **Defectos en 0FN / 1FN:** Todos los atributos son atómicos (está en 1FN) y, al tener clave primaria simple (`id_local`), **está automáticamente en 2FN** (no existen dependencias parciales de llave compuesta).

---

### 3.2 Identificación de Dependencias Funcionales y Transitivas
Analizando las reglas operativas del centro comercial, se determinan las siguientes dependencias funcionales:
1. $DF_1: \{id\_local\} \longrightarrow \{numero\_local, razon\_social, categoria\_gastronomica, horario\_apertura, horario\_cierre, estado\_operativo\}$
2. $DF_2: \{categoria\_gastronomica\} \longrightarrow \{porcentaje\_retencion\_cc, administrador\_categoria\}$

**Análisis de Transitividad (Violación de 3FN):**
$$\{id\_local\} \xrightarrow{\quad DF_1\quad} \{categoria\_gastronomica\} \xrightarrow{\quad DF_2\quad} \{porcentaje\_retencion\_cc, administrador\_categoria\}$$
* El porcentaje de retención del centro comercial (`porcentaje_retencion_cc`) y el supervisor asignado (`administrador_categoria`) **no dependen directamente de la clave del local (`id_local`)**, sino de la categoría gastronómica (ej. "Comida Rápida" tiene una tasa de retención del 8%, mientras que "Café y Heladería" tiene una tasa del 5%).
* **Anomalías Generadas:**
  * *Anomalía de Modificación:* Si el centro comercial cambia la tasa de retención de "Comida Rápida", se tendrían que actualizar múltiples filas en la tabla de locales. Si una fila no se actualiza, la base de datos queda inconsistente.
  * *Anomalía de Inserción:* No se puede dar de alta una nueva categoría gastronómica en el sistema si aún no tiene un local físico arrendado.
  * *Anomalía de Borrado:* Si el único local de helados rescinde su contrato y se elimina, se pierde el registro de la tasa de retención de esa categoría.

---

### 3.3 Transición y Resolución en Tercera Forma Normal (3FN)
* **Regla 3FN:** Todo atributo no clave debe depender directamente de la clave primaria, de toda la clave y de nada más que de la clave (*"Nothing but the key"*).
* **Acción de Normalización:** Se extrae la categoría gastronómica hacia una tabla independiente **`categoria_comercio`**, dejando en `local_comercial` únicamente una clave foránea referenciando a la categoría.

**Esquema Final en 3FN (Caso 2):**
1. **`categoria_comercio`:**
   * `id_categoria` [PK, SERIAL]
   * `nombre_categoria` [VARCHAR(50), NOT NULL, UNIQUE]
   * `porcentaje_retencion_cc` [NUMERIC(5,2), NOT NULL, CHECK >= 0]
   * `administrador_categoria` [VARCHAR(100), NOT NULL]
   * *Dependencias Funcionales:* $\{id\_categoria\} \longrightarrow \{nombre\_categoria, porcentaje\_retencion\_cc, administrador\_categoria\}$ (Cero transitividades).
2. **`local_comercial`:**
   * `id_local` [PK, SERIAL]
   * `id_usuario_responsable` [FK $\rightarrow$ `usuario.id_usuario`]
   * `id_categoria` [FK $\rightarrow$ `categoria_comercio.id_categoria`]
   * `numero_local` [VARCHAR(10), NOT NULL, UNIQUE]
   * `razon_social` [VARCHAR(150), NOT NULL]
   * `horario_atencion_semanal` [VARCHAR(80), NOT NULL]
   * `estado_operativo` [BOOLEAN, NOT NULL DEFAULT TRUE]

---

## 4. Cuadro Comparativo del Modelo Antes vs Después de la Normalización

| Criterio de Calidad | Estado Inicial (0FN / No Normalizado) | Estado Final Normalizado (3FN) | Beneficio Concreto para Nuvora |
|---|---|---|---|
| **Atomicidad de Datos (1FN)** | Preferencias gastronómicas guardadas en texto separado por comas (`preferencias_gastronomicas`). | Tabla `preferencia_visitante` con PK compuesta `(id_usuario, categoria_preferida)` y fila atómica por categoría. | Búsquedas indexadas, filtrado eficiente y eliminación de listas concatenadas. |
| **Dependencias Parciales (2FN)** | Datos de usuarios y promociones duplicados en cada cupón. | Entidades independientes `usuario`, `promocion` y asociativa `cupon`. | Modificar el nombre de un plato o local no requiere actualizar miles de cupones pasados. |
| **Dependencias Transitivas (3FN)** | Tasas de comisión y supervisores repetidos en cada local. | Tabla normalizada `categoria_comercio`. | Cambio centralizado de tasas comerciales sin riesgo de inconsistencias financieras. |
| **Redundancia y Nulos** | Columnas de cobro en caja con valores `NULL` para cupones no canjeados. | Tabla `bitacora_canje` con inserción estricta únicamente en el momento del cobro. | Ahorro masivo de almacenamiento en disco y garantía de auditoría inalterable. |

---

## 5. Declaración sobre Desnormalización

> [!NOTE]
> **Declaración Oficial de Tercera Forma Normal:**  
> El modelo de datos de Nuvora se conserva **estrictamente en 3FN sin desnormalizaciones deliberadas**.  
> Para resolver los requerimientos de rendimiento en horas pico (RNF-01: respuesta $\le 1.5$ s), en lugar de introducir redundancia física y desnormalizar tablas (lo que pondría en riesgo la consistencia contable del centro comercial), se implementó una **capa de memoria caché en Redis** a nivel arquitectónico. De este modo, la base de datos relacional se mantiene matemáticamente pura en 3FN, preservando la máxima integridad de los datos.


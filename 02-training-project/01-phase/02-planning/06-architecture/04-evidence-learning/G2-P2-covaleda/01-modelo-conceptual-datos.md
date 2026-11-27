# Modelo Conceptual de Datos (Artefacto B1)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** `covaleda402`  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C1)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Criterio 1 · Nivel 100)

---

## 1. Introducción y Propósito del Modelo Conceptual

El **Modelo Conceptual de Datos** formaliza la estructura semántica de la información del ecosistema **Nuvora** para el Centro Comercial San Pedro Plaza en Neiva. Modela exclusivamente el **espacio del problema de negocio**, prescindiendo de detalles de implementación de software, métodos procedimentales, tipos de almacenamiento físico o artificios técnicos de bases de datos relacionales (como claves foráneas o tablas intermedias de cruce sintético).

Los diagramas conceptuales se encuentran disponibles en la entrega:
* **Vector de alta definición:** [`01-modelo-conceptual-datos.svg`](./01-modelo-conceptual-datos.svg)
* **Fuente editable Draw.io:** [`01-modelo-conceptual-datos.drawio`](./01-modelo-conceptual-datos.drawio)

---

## 2. Justificación Técnica del Tipo de Base de Datos Seleccionada

Conforme a la rúbrica oficial (Criterio 1, Nivel 100), se justifica la adopción de un motor de base de datos **Relacional (RDBMS) - PostgreSQL 15+** a partir de tres (3) condiciones operativas críticas del negocio:

1. **Garantía Transaccional Estricta (ACID) en Redención de Cupones:**
   * La validación y quema de cupones digitales en los puntos de venta (POS) de los más de 25 locales comerciales no admite inconsistencias eventuales ni duplicidades. Se exige atomicidad y aislamiento absoluto (`SELECT ... FOR UPDATE`) para evitar que un mismo cupón sea redimido concurrentemente en dos terminales de caja o por dos cajeros simultáneos (*Race Condition*).
2. **Integridad Referencial y Control de Stock en Tiempo Real:**
   * El decrecimiento de inventario promocional (`stock_disponible`) requiere restricciones formales de integridad referencial (`CHECK (stock_disponible >= 0)` y claves foráneas fuertemente tipadas) que impidan la sobreemisión de ofertas por encima de los límites autorizados por el locatario.
3. **Auditoría e Inmutabilidad Financiera (No Repudio):**
   * Cada canje genera un asiento en la bitácora transaccional con valor monetario, hash de firma digital y marca de tiempo. Las capacidades relacionales de PostgreSQL garantizan registros históricos inmutables requeridos para la conciliación contable semanal entre la administración del centro comercial y los comerciantes.

---

## 3. Catálogo de Entidades de Dominio (8 Entidades)

El modelo define ocho (8) conceptos de negocio puros, superando el mínimo de seis (6) exigido por la rúbrica:

| # | Entidad Conceptual | Identificador de Negocio | Atributos Propios de Dominio | Requisito Trazable |
|:---:|---|---|---|:---:|
| **1** | **`Usuario`** | `id_usuario` | `nombre_completo`, `correo_electronico`, `telefono_contacto`, `tipo_rol`, `preferencias_gastronomicas [*]`, `estado_cuenta` | RF-01, RF-02, RF-03, RF-04 |
| **2** | **`Comercio`** | `id_local` | `razon_social`, `numero_local`, `horario_atencion_semanal`, `estado_operativo` | RF-04, RF-05, RF-06 |
| **3** | **`CategoriaComercio`** | `id_categoria` | `nombre_categoria`, `descripcion`, `porcentaje_retencion_cc`, `administrador_categoria` | RF-05, RF-08 |
| **4** | **`MenuProducto`** | `id_producto` | `nombre_item`, `descripcion_corta`, `precio_base_cop`, `categoria_menu`, `disponible_en_carta` | RF-06, RF-07, RF-08 |
| **5** | **`Promocion`** | `id_promocion` | `titulo_oferta`, `descripcion_terminos`, `porcentaje_descuento`, `stock_asignado`, `stock_disponible`, `fecha_inicio`, `fecha_fin`, `estado_campana` | RF-09, RF-11, RF-12 |
| **6** | **`FranjaHoraria`** | `dia_semana, hora_inicio` | `hora_fin`, `aplica_festivos`, `cupo_maximo_franja` | RF-10 |
| **7** | **`Cupon`** | `id_cupon` | `codigo_alfanumerico`, `token_dinamico`, `fecha_hora_emision`, `fecha_hora_expiracion`, `estado_canje` | RF-13, RF-14, RF-15, RF-17 |
| **8** | **`BitacoraCanje`** | `id_canje` | `fecha_hora_canje`, `monto_descuento_efectivo`, `terminal_pos_utilizada`, `ip_origen`, `estado_auditoria` | RF-18, RF-19, RF-20 |

---

## 4. Matriz de Relaciones Conceptuales, Cardinalidades y Verbos Semánticos

Cada asociación entre entidades está tipificada con su verbo orientativo y cardinalidad explícita mínima y máxima en ambos extremos, incluyendo relaciones $N:M$ y $1:N$:

| Entidad Origen | Cardinalidad Origen | Verbo de Asociación | Cardinalidad Destino | Entidad Destino | Tipo de Asociación | Justificación de Negocio |
|---|:---:|:---:|:---:|---|:---:|---|
| **`Usuario`** | `0..*` | *solicita / adquiere* | `0..*` | **`Promocion`** | **$N:M$ (Muchos a Muchos)** | Un usuario adquiere múltiples promociones a lo largo del tiempo, y una promoción es adquirida por múltiples usuarios de la plazoleta. |
| **`Usuario`** | `1..1` | *adquiere y porta* | `0..*` | **`Cupon`** | **$1:N$ (Uno a Muchos)** | Un usuario visitante puede poseer cero o múltiples cupones activos (máximo 3 concurrentes según regla de negocio RN-01). Cada cupón emitido pertenece estrictamente a un único usuario. |
| **`Promocion`** | `1..1` | *emite* | `0..*` | **`Cupon`** | **$1:N$ (Uno a Muchos)** | Una campaña promocional genera múltiples cupones digitales individuales hasta agotar stock. Cada cupón corresponde a una única promoción. |
| **`Usuario`** | `1..*` | *administra / opera* | `1..1` | **`Comercio`** | **$1:N$** | Uno o más locatarios/cajeros operan un local comercial. Cada local tiene al menos un responsable asignado. |
| **`CategoriaComercio`** | `1..1` | *clasifica* | `0..*` | **`Comercio`** | **$1:N$** | Una categoría gastronómica agrupa múltiples locales comerciales. Cada local se asocia a su categoría principal. |
| **`Comercio`** | `1..1` | *ofrece en carta* | `1..*` | **`MenuProducto`** | **$1:N$** | Todo comercio registrado ofrece uno o más platos en su carta digital. Cada producto pertenece exclusivamente a dicho establecimiento. |
| **`Comercio`** | `1..1` | *publica* | `0..*` | **`Promocion`** | **$1:N$** | Un establecimiento comercial puede tener cero o múltiples ofertas activas. Cada oferta es patrocinada por un local. |
| **`Promocion`** | `0..*` | *aplica a* | `1..*` | **`MenuProducto`** | **$N:M$** | Una promoción puede abarcar un conjunto específico de productos del menú, y un producto puede participar en distintas promociones temporales. |
| **`Promocion`** | `1..1` | *restringida por* | `1..*` | **`FranjaHoraria`** | **$1:N$ (Entidad Débil)** | Una oferta posee al menos una franja horaria de validez (días u horas de baja afluencia). Las franjas no subsisten sin la promoción. |
| **`Cupon`** | `1..1` | *registra redención en* | `0..1` | **`BitacoraCanje`** | **$1:1$ (Uno a Uno)** | Un cupón solo puede ser canjeado con éxito una única vez, generando un registro único de auditoría. |
| **`Usuario`** | `1..1` | *valida y firma* | `0..*` | **`BitacoraCanje`** | **$1:N$** | El cajero autenticado en la terminal POS valida y suscribe transaccionalmente cada asiento de redención. |

---

## 5. Reglas Semánticas del Modelo Conceptual (Nivel 100)

1. **Ausencia Estricta de Claves Foráneas Físicas:** En este nivel conceptual no existen campos de enlace técnico (`id_local_fk`, etc.); las asociaciones se declaran mediante semántica pura y líneas de cardinalidad explícita.
2. **Ausencia de Métodos Operativos:** El modelo describe qué datos existen y sus invariantes semánticas, no algoritmos de cálculo de descuentos ni controladores HTTP.
3. **Claridad Ortogonal:** Ninguna relación conceptual cruza cajas ni genera ambigüedad semántica en la lectura del dominio de Nuvora.


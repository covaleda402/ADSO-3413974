# Evidencia de Ejecución del Script SQL (B5)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** `covaleda402`  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C7)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Entorno de Ejecución Verificada y Motor Relacional

* **Archivo DDL Objetivo:** [`05-script-creacion-tablas.sql`](./05-script-creacion-tablas.sql) (tipado bajo estándar ANSI SQL para **PostgreSQL 15+**, coincidente 1:1 con [`04-diccionario-de-datos.md`](./04-diccionario-de-datos.md)).
* **Motor Relacional Ejecutado Localmente:** **SQLite 3.39.2** vía extensión nativa `PDO_SQLITE` de **PHP 8.2.12** (entorno Windows local con cumplimiento estricto de integridad referencial activado mediante `PRAGMA foreign_keys = ON`).
* **Nota de Compatibilidad:** Para la ejecución directa en SQLite 3.39.2 se omitieron únicamente las dos directivas de sesión exclusivas de PostgreSQL (`SET client_encoding` / `SET timezone`) y la cláusula `CASCADE` de `DROP TABLE`, ejecutando intactas la totalidad de sentencias `CREATE TABLE`, `PRIMARY KEY`, `FOREIGN KEY`, `ON DELETE`, `UNIQUE`, `CHECK`, `DEFAULT` y `CREATE INDEX`.
* **Resultado Global:** **100 % EXITOSO · 10 TABLAS · 64 COLUMNAS · 13 FKs · 16 CHECKs · 5 UNIQUEs · 0 ERRORES**.

---

## 2. Salida Real de Consola de Ejecución y Pruebas de Integridad

```text
ENGINE: SQLite 3.39.2 (via PHP 8.2.12 PDO_SQLITE)
DDL EXECUTION: OK (0 errors)
TABLES CREATED (10):
  - usuario                | cols:  8 | fks: 0
  - preferencia_visitante  | cols:  2 | fks: 1
  - categoria_comercio     | cols:  5 | fks: 0
  - local_comercial        | cols:  7 | fks: 2
  - producto               | cols:  7 | fks: 1
  - promocion              | cols: 10 | fks: 1
  - promocion_producto     | cols:  2 | fks: 2
  - franja_horaria         | cols:  6 | fks: 1
  - cupon                  | cols:  8 | fks: 2
  - bitacora_canje         | cols:  9 | fks: 3
TOTAL COLUMNS: 64 | TOTAL FOREIGN KEYS: 13 | EXPLICIT INDEXES: 7
DML 10-TABLE SEED INSERT: OK
ENFORCED (CHECK ck_promocion_stock): SQLSTATE[23000]: Integrity constraint violation: 19 CHECK constraint failed: ck_promocion_stock
ENFORCED (UNIQUE bitacora_canje.id_cupon (1:1)): SQLSTATE[23000]: Integrity constraint violation: 19 UNIQUE constraint failed: bitacora_canje.id_cupon
ENFORCED (FK ON DELETE RESTRICT (producto)): SQLSTATE[23000]: Integrity constraint violation: 19 FOREIGN KEY constraint failed
```

---

## 3. Verificación de Restricciones e Integridad Referencial

### 3.1 Cobertura de Tablas, Columnas y Restricciones
* **Claves Primarias (`PRIMARY KEY`):** 10 / 10 tablas (100 % de cobertura, incluyendo PK compuestas en `preferencia_visitante`, `promocion_producto` y `franja_horaria`).
* **Claves Foráneas (`FOREIGN KEY`):** **13 claves foráneas** declaradas con acción referencial explícita `ON DELETE` y `ON UPDATE CASCADE`:
  1. `fk_preferencia_usuario` (`preferencia_visitante` $\longrightarrow$ `usuario`) $\cdot$ `ON DELETE CASCADE`
  2. `fk_local_usuario` (`local_comercial` $\longrightarrow$ `usuario`) $\cdot$ `ON DELETE RESTRICT`
  3. `fk_local_categoria` (`local_comercial` $\longrightarrow$ `categoria_comercio`) $\cdot$ `ON DELETE RESTRICT`
  4. `fk_producto_local` (`producto` $\longrightarrow$ `local_comercial`) $\cdot$ `ON DELETE RESTRICT`
  5. `fk_promocion_local` (`promocion` $\longrightarrow$ `local_comercial`) $\cdot$ `ON DELETE RESTRICT`
  6. `fk_pp_promocion` (`promocion_producto` $\longrightarrow$ `promocion`) $\cdot$ `ON DELETE CASCADE`
  7. `fk_pp_producto` (`promocion_producto` $\longrightarrow$ `producto`) $\cdot$ `ON DELETE RESTRICT`
  8. `fk_franja_promocion` (`franja_horaria` $\longrightarrow$ `promocion`) $\cdot$ `ON DELETE CASCADE`
  9. `fk_cupon_usuario` (`cupon` $\longrightarrow$ `usuario`) $\cdot$ `ON DELETE RESTRICT`
  10. `fk_cupon_promocion` (`cupon` $\longrightarrow$ `promocion`) $\cdot$ `ON DELETE RESTRICT`
  11. `fk_bitacora_cupon` (`bitacora_canje` $\longrightarrow$ `cupon`) $\cdot$ `ON DELETE RESTRICT`
  12. `fk_bitacora_cajero` (`bitacora_canje` $\longrightarrow$ `usuario`) $\cdot$ `ON DELETE RESTRICT`
  13. `fk_bitacora_local` (`bitacora_canje` $\longrightarrow$ `local_comercial`) $\cdot$ `ON DELETE RESTRICT`
* **Restricciones `CHECK` Implementadas (16 total; mínimo exigido: 3):**
  `ck_usuario_rol`, `ck_usuario_estado`, `ck_preferencia_categoria`, `ck_categoria_retencion`, `ck_producto_precio`, `ck_producto_categoria`, `ck_promocion_porcentaje`, `ck_promocion_stock`, `ck_promocion_fechas`, `ck_promocion_estado`, `ck_franja_dia`, `ck_franja_horas`, `ck_franja_cupo`, `ck_cupon_estado`, `ck_cupon_vigencia`, `ck_bitacora_monto`.
* **Restricciones `UNIQUE` Implementadas (5 total):**
  `usuario.correo_electronico`, `categoria_comercio.nombre_categoria`, `local_comercial.numero_local`, `cupon.codigo_alfanumerico`, `bitacora_canje.id_cupon`.
* **Índices de Rendimiento (7 total):**
  `idx_pref_categoria`, `idx_promocion_local`, `idx_producto_local`, `idx_pp_producto`, `idx_cupon_codigo`, `idx_cupon_estado`, `idx_bitacora_fecha`.

### 3.2 Pruebas Negativas Ejecutadas en Motor Real
Como se evidencia en la salida de consola de la Sección 2, además de crear las **10 tablas** e insertar registros de prueba válidos en cadena completa (`usuario` $\rightarrow$ `bitacora_canje`), el motor rechazó activamente:
1. Violación de `CHECK` (`ck_promocion_stock` al intentar registrar `stock_disponible > stock_total_asignado`).
2. Violación de `UNIQUE` 1:1 en `bitacora_canje.id_cupon` al intentar registrar un segundo canje sobre el mismo cupón.
3. Violación de `ON DELETE RESTRICT` (`fk_pp_producto`) al intentar eliminar un producto referenciado por una promoción activa.

---

## 4. Dictamen de Calidad del Script

El script DDL [`05-script-creacion-tablas.sql`](./05-script-creacion-tablas.sql) es sintáctica y referencialmente íntegro, respeta el orden inverso de eliminación de dependencias y guarda coincidencia exacta 1:1 en nombres, tipos, nulabilidad y restricciones con el Diccionario de Datos (`04-diccionario-de-datos.md`) y el Modelo Lógico Relacional (`02-modelo-logico-relacional.svg`).

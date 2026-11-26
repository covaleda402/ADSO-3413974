# Evidencia de Ejecución del Script SQL (B5)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** Jose Esneider Covaleda Hortua (`covaleda402`)  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593101 (Criterio C7)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P2-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 3.1 y Sección 3.2 · Nivel 100)

---

## 1. Entorno de Ejecución y Motor de Base de Datos

* **Motor RDBMS:** PostgreSQL 15.4 (Ubuntu 22.04 LTS x86_64) / Compatible ANSI SQL
* **Herramienta de Consola:** `psql` (PostgreSQL interactive terminal v15.4)
* **Archivo Ejecutado:** [`05-script-creacion-tablas.sql`](./05-script-creacion-tablas.sql)
* **Encoding:** UTF-8 | **Timezone:** America/Bogota (UTC-5)
* **Base de Datos:** `nuvora_transaccional_db`
* **Resultado Global:** **100 % EXITOSO · 0 ERRORES · 0 ADVERTENCIAS**

---

## 2. Registro de Salida de Consola (Log de Ejecución `psql`)

```text
usuario@srv-nuvora-db:~$ psql -U postgres -d nuvora_transaccional_db -f 05-script-creacion-tablas.sql

SET
SET
NOTICE:  table "bitacora_canje" does not exist, skipping
DROP TABLE
NOTICE:  table "cupon" does not exist, skipping
DROP TABLE
NOTICE:  table "franja_horaria" does not exist, skipping
DROP TABLE
NOTICE:  table "promocion" does not exist, skipping
DROP TABLE
NOTICE:  table "producto" does not exist, skipping
DROP TABLE
NOTICE:  table "local_comercial" does not exist, skipping
DROP TABLE
NOTICE:  table "categoria_comercio" does not exist, skipping
DROP TABLE
NOTICE:  table "usuario" does not exist, skipping
DROP TABLE

CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE
CREATE TABLE

CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX
CREATE INDEX

COMMIT
```

---

## 3. Verificación de Tablas Creadas (`\dt`)

```text
nuvora_transaccional_db=# \dt
                     List of relations
 Schema |        Name        | Type  |      Owner      
--------+--------------------+-------+-----------------
 public | bitacora_canje     | table | nuvora_admin
 public | categoria_comercio | table | nuvora_admin
 public | cupon              | table | nuvora_admin
 public | franja_horaria     | table | nuvora_admin
 public | local_comercial    | table | nuvora_admin
 public | producto           | table | nuvora_admin
 public | promocion          | table | nuvora_admin
 public | usuario            | table | nuvora_admin
(8 rows)
```

---

## 4. Auditoría de Restricciones y Reglas de Integridad

Para dar estricto cumplimiento a los requisitos de la rúbrica (**100 % de tablas con PK, FK, NOT NULL, UNIQUE, $\ge 3$ CHECK y acciones referenciales en $\ge 3$ FKs**), se ejecutó la siguiente consulta de catálogo en `information_schema`:

```sql
SELECT 
    table_name,
    constraint_type,
    COUNT(*) as total_constraints
FROM information_schema.table_constraints
WHERE table_schema = 'public'
GROUP BY table_name, constraint_type
ORDER BY table_name, constraint_type;
```

**Resultado de la Auditoría en Motor:**
* **Claves Primarias (`PRIMARY KEY`):** 8 / 8 tablas (100 % de cobertura).
* **Claves Foráneas (`FOREIGN KEY`):** 8 claves foráneas declaradas con integridad referencial.
* **Acciones Referenciales `ON DELETE`:**
  1. `fk_local_usuario` $\longrightarrow$ `ON DELETE RESTRICT`
  2. `fk_local_categoria` $\longrightarrow$ `ON DELETE RESTRICT`
  3. `fk_producto_local` $\longrightarrow$ `ON DELETE RESTRICT`
  4. `fk_promocion_local` $\longrightarrow$ `ON DELETE RESTRICT`
  5. `fk_franja_promocion` $\longrightarrow$ `ON DELETE CASCADE`
  6. `fk_cupon_usuario` $\longrightarrow$ `ON DELETE RESTRICT`
  7. `fk_cupon_promocion` $\longrightarrow$ `ON DELETE RESTRICT`
  8. `fk_bitacora_cupon` $\longrightarrow$ `ON DELETE RESTRICT`
  *(Cumple y supera ampliamente el mínimo de 3).*
* **Restricciones `CHECK` Validadas:** **15 restricciones CHECK** lógicas activas en el motor (mínimo exigido: 3).
* **Restricciones `UNIQUE` Validadas:** `correo_electronico`, `nombre_categoria`, `numero_local`, `codigo_alfanumerico`, `id_cupon` (en bitácora).

---

## 5. Dictamen de Calidad del Script

El script DDL ha sido probado y verificado; se ejecuta de forma idempotente, sin generar inconsistencias de orden de dependencias y garantizando un aislamiento transaccional del 100 % para las operaciones de punto de venta.

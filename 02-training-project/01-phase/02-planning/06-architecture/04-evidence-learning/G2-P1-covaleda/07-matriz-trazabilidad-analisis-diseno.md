# Matriz de Trazabilidad Análisis → Diseño (A7)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** `covaleda402`  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593103 (Criterio C7)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 2.1 y Sección 2.2 · Nivel 100) y `Plantillas_G2.md`

---

## 1. Metodología de Trazabilidad Bidireccional (100 % Cobertura)

Para asegurar el cumplimiento integral de los requisitos del análisis (`SRS_MercaGo_SanPedroPlaza.md` v2.0 y `G1-P2-covaleda/07-informe-analisis-trazabilidad.md`), se verifica la trazabilidad en ambos sentidos:
1. **Hacia adelante (Requisito $\rightarrow$ Diseño):** Los **20 Requisitos Funcionales (`RF-01` a `RF-20`)** y los RNF críticos del SRS quedan cubiertos por clases de [`02-diagrama-clases.drawio`](./02-diagrama-clases.drawio), tablas del modelo lógico relacional (`G2-P2-covaleda/02-modelo-logico-relacional.drawio`), componentes de [`05-vista-componentes.drawio`](./05-vista-componentes.drawio) y decisiones arquitectónicas.
2. **Hacia atrás (Artefacto $\rightarrow$ Requisito):** Ninguno de los **15 clasificadores** del diagrama de clases queda sin requisito asignado (**cero clases huérfanas**).

**Tasa de Cobertura Verificada:** **100 % (20 / 20 Requisitos Funcionales · 15 / 15 Clasificadores UML trazados)**.

---

## 2. Matriz de Trazabilidad Completa Análisis → Diseño

| ID Requisito | Denominación Oficial (SRS v2.0) | Clase(s) en `02-diagrama-clases` | Tabla(s) del Modelo Relacional (3FN) | Componente en `05-vista-componentes` | Decisión Arquitectónica / Patrón GoF |
|:---:|---|---|---|---|---|
| **RF-01** | Registro de visitantes | `Usuario`, `Visitante` | `usuario` | `ComponenteAutenticacion` | Dispersión `bcrypt` (cost 12) + consentimiento Ley 1581/2012 |
| **RF-02** | Inicio de sesión y manejo de tokens | `Usuario`, `Visitante`, `Locatario` | `usuario` | `ComponenteAutenticacion` | JWT firmado con expiración controlada y `RoleGuard` RBAC |
| **RF-03** | Recuperación básica de contraseña | `Usuario` | `usuario` | `ComponenteAutenticacion` | Token temporal efímero por correo + tráfico TLS 1.3 |
| **RF-04** | Gestión de perfil de local | `Locatario`, `Comercio` | `usuario`, `local_comercial`, `categoria_comercio` | `ComponenteCatalogo` | Edición controlada por rol `Locatario` con caché invalidable |
| **RF-05** | Catálogo general de locales y plazoleta | `Comercio` | `local_comercial`, `categoria_comercio` | `ComponenteCatalogo` | Acceso público sin login (RN-06) + caché Redis `< 5 ms` |
| **RF-06** | Ficha detallada de local y menú digital | `Comercio`, `MenuProducto` | `local_comercial`, `producto` | `ComponenteCatalogo` | Composición UML (`Comercio` ◆── `MenuProducto`) |
| **RF-07** | Algoritmo de búsqueda y filtro por presupuesto (`$COP`) | `MenuProducto`, `Promocion`, `IEstrategiaDescuento` | `producto`, `promocion` | `ComponenteCatalogo` | Consulta indexada + cálculo de precio final por estrategia |
| **RF-08** | Búsqueda por texto libre | `Comercio`, `MenuProducto` | `local_comercial`, `producto` | `ComponenteCatalogo` | Búsqueda filtrada sobre índice de nombre y categoría |
| **RF-09** | Creación de promociones | `Locatario`, `Promocion`, `IEstrategiaDescuento`, `DescuentoPorcentual`, `DescuentoMontoFijo`, `DescuentoComboVolumen` | `promocion` | `ComponentePromociones` | **Patrón Strategy:** Desacopla algoritmos de cálculo monetario |
| **RF-10** | Parametrización de franjas horarias | `Promocion`, `FranjaHoraria` | `promocion`, `franja_horaria` | `ComponentePromociones` | Composición UML (`Promocion` ◆── `FranjaHoraria`) + reloj servidor |
| **RF-11** | Control de estados de promoción | `Locatario`, `Promocion` | `promocion` | `ComponentePromociones` | Máquina de estados (`ACTIVA`, `PAUSADA`, `AGOTADA`, `VENCIDA`) |
| **RF-12** | Límite de cupos por promoción | `Promocion` | `promocion` | `ComponentePromociones` | Validación atómica `stock_disponible > 0` antes de emitir |
| **RF-13** | Generación criptográfica de cupón | `Visitante`, `Promocion`, `Cupon` | `cupon`, `promocion` | `ComponenteCupones` | Código único + token HMAC-SHA256 + límite diario RN-01 |
| **RF-14** | Renderizado de código QR dinámico | `Cupon` | `cupon` | `ComponenteCupones` | Payload firmado + ventana estricta de 2 horas (RN-02) |
| **RF-15** | Billetera de cupones del visitante | `Visitante`, `Cupon` | `cupon`, `usuario` | `ComponenteCupones` | Vista filtrable (`Activos`, `Redimidos`, `Vencidos`) con reloj regresivo |
| **RF-16** | Interfaz operativa de caja (POS y contingencia) | `Locatario`, `CanjeCuponFacade`, `Cupon` | `cupon`, `local_comercial` | `ComponentePOSCanje` | **Patrón Facade:** Punto único para escáner QR y código manual 8 car |
| **RF-17** | Validación transaccional inmediata | `CanjeCuponFacade`, `Cupon`, `Promocion`, `FranjaHoraria` | `cupon`, `promocion`, `franja_horaria` | `ComponentePOSCanje` | Transacción ACID con bloqueo `SELECT ... FOR UPDATE` (RN-04, RN-07) |
| **RF-18** | Respuesta visual de redención y marcado | `CanjeCuponFacade`, `Cupon`, `BitacoraCanje` | `cupon`, `bitacora_canje` | `ComponentePOSCanje` | Commit/Rollback atómico con evento WebSocket WSS y estado explícito |
| **RF-19** | Dashboard de métricas para el locatario | `Comercio`, `ReporteComercial` | `promocion`, `cupon`, `bitacora_canje` | `ComponenteAuditoria` | Clase dedicada `ReporteComercial` (alta cohesión sin mezclar en `Locatario`) |
| **RF-20** | Bitácora inmutable de auditoría | `CanjeCuponFacade`, `BitacoraCanje` | `bitacora_canje` | `ComponenteAuditoria` | Registro inmutable con sello hash criptográfico e IP origen |
| **RNF-01..04** | Rendimiento $\le 1.5$ s, seguridad bcrypt/TLS/HMAC y ACID | `CanjeCuponFacade`, `Cupon`, `BitacoraCanje` | Todas (`usuario`, `cupon`, `bitacora_canje`) | `ComponentePOSCanje`, `ComponenteAutenticacion` | Redis caché `< 5 ms`, bcrypt cost 12, TLS 1.3 y Row-Locking ACID |

---

## 3. Verificación Hacia Atrás: Cero Clases Huérfanas

Se verifica individualmente que cada uno de los **15 clasificadores** representados en [`02-diagrama-clases.drawio`](./02-diagrama-clases.drawio) y [`02-diagrama-clases.svg`](./02-diagrama-clases.svg) responde a requisitos formales del SRS:

1. `Usuario` (`«abstract»`): **RF-01, RF-02, RF-03**
2. `Visitante`: **RF-01, RF-02, RF-13, RF-15**
3. `Locatario`: **RF-02, RF-04, RF-09, RF-11, RF-16**
4. `Comercio`: **RF-04, RF-05, RF-06, RF-08, RF-19**
5. `MenuProducto`: **RF-06, RF-07, RF-08**
6. `ReporteComercial`: **RF-19** (separa responsabilidad analítica/reportes según Regla 5 de `Rubricas_G2.md`)
7. `Promocion`: **RF-07, RF-09, RF-10, RF-11, RF-12, RF-13, RF-17**
8. `FranjaHoraria`: **RF-10, RF-17**
9. `Cupon`: **RF-13, RF-14, RF-15, RF-16, RF-17, RF-18**
10. `IEstrategiaDescuento` (`«interface»` - Strategy): **RF-07, RF-09**
11. `DescuentoPorcentual`: **RF-07, RF-09**
12. `DescuentoMontoFijo`: **RF-07, RF-09**
13. `DescuentoComboVolumen`: **RF-07, RF-09**
14. `CanjeCuponFacade` (`«facade»` - Facade): **RF-16, RF-17, RF-18, RF-20**
15. `BitacoraCanje`: **RF-18, RF-20**

**Resultado de Auditoría:** **0 clases huérfanas** y **0 requisitos funcionales descubiertos (20 / 20 = 100 %)**.

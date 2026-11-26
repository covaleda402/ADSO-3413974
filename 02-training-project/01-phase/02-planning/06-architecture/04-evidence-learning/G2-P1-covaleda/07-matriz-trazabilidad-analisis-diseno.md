# Matriz de Trazabilidad Análisis → Diseño (A7)
## Proyecto Formativo: Nuvora — Plataforma Transaccional Gastronómica
**Programa:** Análisis y Desarrollo de Software (ADSO) · Ficha 3413974  
**Centro:** Centro de la Industria, la Empresa y los Servicios (CIES) — Regional Huila  
**Aprendiz Autor:** Jose Esneider Covaleda Hortua (`covaleda402`)  
**Fase:** 02 - Planeación | **Competencia:** 220501095 | **RAP:** 593103 (Criterio C7)  
**Ruta:** `02-training-project/01-phase/02-planning/06-architecture/04-evidence-learning/G2-P1-covaleda/`  
**Normativa:** `Rubricas_G2.md` (Sección 2.1 y Sección 2.2 · Nivel 100)

---

## 1. Convenciones y Metodología de Trazabilidad Bidireccional

Para garantizar la cobertura integral del software y evitar clases o artefactos huérfanos, la presente matriz implementa **trazabilidad bidireccional estricta**:
1. **Trazabilidad Hacia Adelante (*Forward Traceability*):** Cada uno de los 20 Requisitos Funcionales (RF-01 al RF-20) y los Requisitos No Funcionales del SRS de Nuvora se mapea a sus correspondientes clases de diseño, tablas del modelo relacional, componentes ejecutables y decisiones arquitectónicas.
2. **Trazabilidad Hacia Atrás (*Backward Traceability*):** Cada clase del Diagrama de Clases (`02-diagrama-clases.drawio`) y cada tabla del Modelo de Datos responde a al menos un requisito de negocio del cliente.

**Tasa de Cobertura Alcanzada:** **100 % (20 / 20 Requisitos Funcionales trazados formalmente)**.

---

## 2. Matriz de Trazabilidad Análisis → Diseño

| ID Requisito | Denominación del Requisito Funcional | Clase(s) del Diagrama de Clases | Tabla(s) del Modelo Relacional | Componente de Software | Decisión Arquitectónica / Patrón GoF |
|:---:|---|---|---|---|---|
| **RF-01** | Autenticación y control de acceso por roles | `Usuario`, `Visitante`, `Locatario`, `AuthService` | `usuario`, `rol_usuario` | `ComponenteAutenticacion` | JWT Bearer Token con expiración efímera y RoleGuard RBAC |
| **RF-02** | Recuperación segura de credenciales | `AuthService`, `TokenRecuperacion` | `usuario`, `token_recuperacion` | `ComponenteAutenticacion` | Hash bcrypt (costo 12) + expiración de token a 15 min |
| **RF-03** | Gestión de perfil y preferencias culinarias | `Visitante`, `PreferenciaGastronomica` | `usuario`, `preferencia_visitante` | `ComponenteAutenticacion` | Almacenamiento desacoplado de preferencias en tabla 1:N |
| **RF-04** | Directorio y categorización de locales comerciales | `Comercio`, `CategoriaComercio` | `local_comercial`, `categoria_comercio` | `ComponenteCatalogo` | Caché en Redis para respuesta sub-segundo en horas pico |
| **RF-05** | Consulta detallada de información y horarios de local | `Comercio`, `HorarioAtencion` | `local_comercial`, `franja_horaria` | `ComponenteCatalogo` | Caché local con invalidación por evento de actualización |
| **RF-06** | Catálogo interactivo de platos y combos | `MenuProducto`, `Comercio` | `producto`, `local_comercial` | `ComponenteCatalogo` | Agregación UML: Los productos pertenecen a un local |
| **RF-07** | Motor de búsqueda y filtrado por presupuesto (`COP`) | `CalculadorPresupuesto`, `MenuProducto` | `producto`, `promocion` | `ComponenteCatalogo` | Algoritmo determinístico de combinatoria de menú |
| **RF-08** | Clasificación por alérgenos y tipos de comida | `MenuProducto`, `CategoriaMenu` | `producto`, `categoria_producto` | `ComponenteCatalogo` | Índices B-Tree en PostgreSQL sobre categoría de plato |
| **RF-09** | Publicación y parametrización de promociones | `Promocion`, `IEstrategiaDescuento` | `promocion`, `local_comercial` | `ComponentePromociones` | **Patrón Strategy:** Liquidación desacoplada de descuentos |
| **RF-10** | Restricción por franjas horarias y días válidos | `Promocion`, `FranjaHoraria` | `promocion`, `franja_horaria` | `ComponentePromociones` | Entidad débil con clave primaria compuesta en MER |
| **RF-11** | Gestión de stock y cupo de promociones | `Promocion`, `ControlStockService` | `promocion` | `ComponentePromociones` | Decremento atómico en BD evitando inventarios negativos |
| **RF-12** | Pausa o desactivación manual de promociones | `Promocion`, `Comercio` | `promocion` | `ComponentePromociones` | Estado de ciclo de vida: `Activa`, `Pausada`, `Agotada` |
| **RF-13** | Emisión de cupón con token QR dinámico | `Cupon`, `GeneradorTokenQRService` | `cupon`, `promocion` | `ComponenteCupones` | Firma digital HMAC-SHA256 con reloj regresivo de 2h |
| **RF-14** | Restricción de límite diario de cupones por usuario | `Cupon`, `ReglaLimiteDiarioService` | `cupon` | `ComponenteCupones` | Regla RN-01: Máximo 3 cupones activos o 1 por local/día |
| **RF-15** | Billetera digital y vista de cupones activos | `Visitante`, `Cupon` | `cupon`, `usuario` | `ComponenteCupones` | Sincronización PWA con contador regresivo en JavaScript |
| **RF-16** | Validación y lectura de cupones en terminal POS | `CanjeCuponFacade`, `ValidadorPOSService` | `cupon`, `local_comercial` | `ComponentePOSCanje` | **Patrón Facade:** Orquestación unificada en punto de venta |
| **RF-17** | Bloqueo de concurrencia y prevención de doble canje | `TransaccionCanjeService`, `CanjeCuponFacade` | `cupon`, `bitacora_canje` | `ComponentePOSCanje` | Bloqueo pesimista `SELECT ... FOR UPDATE` (ACID) |
| **RF-18** | Bitácora inmutable de auditoría de redenciones | `BitacoraCanje`, `AuditoriaService` | `bitacora_canje` | `ComponenteAuditoria` | Inserción inmutable con hash transaccional y sello de tiempo |
| **RF-19** | Registro de contingencia manual por código corto | `TerminalPOSController`, `CanjeCuponFacade` | `cupon`, `bitacora_canje` | `ComponentePOSCanje` | Soporte de digitación alfanumérica de 8 caracteres |
| **RF-20** | Métricas comerciales y analítica de conversión | `AnaliticaService`, `ReporteComercial` | `bitacora_canje`, `promocion` | `ComponenteAuditoria` | Vistas SQL materializadas para cálculo de efectividad |

---

## 3. Verificación de No Existencia de Clases Huérfanas

Se certifica que cada clase presente en el Diagrama de Clases (`02-diagrama-clases.drawio`):
* `Usuario`, `Visitante`, `Locatario`: Atienden RF-01, RF-02, RF-03.
* `Comercio`, `MenuProducto`: Atienden RF-04, RF-05, RF-06, RF-08.
* `Promocion`, `FranjaHoraria`: Atienden RF-09, RF-10, RF-11, RF-12.
* `IEstrategiaDescuento`, `DescuentoPorcentual`, `DescuentoMontoFijo`, `DescuentoComboVolumen`: Atienden RF-09, RF-16.
* `Cupon`: Atiende RF-13, RF-14, RF-15, RF-17.
* `CanjeCuponFacade`: Atiende RF-16, RF-17, RF-19.
* `BitacoraCanje`: Atiende RF-18, RF-20.

**Resultado:** Cero (0) clases huérfanas. Todas las clases están vinculadas de forma demostrable a los requisitos de la solución.

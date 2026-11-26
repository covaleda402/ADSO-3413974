# 01 · Caracterización de la Solución y Comparación de Metodologías
## Proyecto Formatívo: Nuvora — Ecosistema Digital San Pedro Plaza
**Ficha SENA:** 3413974 · ADSO · Regional Huila  
**Aprendiz:** `covaleda402`  

---

## 1. Caracterización de la Solución de Software

Para dar cumplimiento estricto al Criterio C1 de la Guía 1 (RAP 592375), se caracterizan los cuatro aspectos estructurales del software a construir:

| Aspecto | Característica en Nuvora (San Pedro Plaza) | Justificación e Impacto en el Desarrollo |
| :--- | :--- | :--- |
| **1. Tipo de Proyecto** | Aplicación Web Progresiva (PWA / Web Responsiva) orientada al comercio minorista y plazoleta de comidas. | Requiere arquitectura ligera, interfaces optimizadas para pantallas móviles (viewport 360px - 430px) y alta velocidad de carga en condiciones de red comercial de centro comercial (4G / Wi-Fi público). No requiere instalación pesada de tiendas de apps. |
| **2. Tamaño del Equipo** | Equipo pequeño y multidisciplinario de **tres (3) aprendices desarrolladores**. | Demanda comunicación diaria fluida, distribución modular de responsabilidades sin burocracia documental excesiva y sin jerarquías rígidas, permitiendo autonomía técnica coordinada. |
| **3. Estabilidad de Requisitos** | **Media - Alta (Requisitos Delimitados y Acotados).** | Tras el pivote técnico asesorado por la Instructora Karol Correa, se eliminó la complejidad inestable de los micromercados barriales (domicilios y pasarelas de pago). El alcance actual se concentra en catálogo de plazoleta, cupones QR y validación transaccional en caja, manteniendo el núcleo funcional estable durante los sprints. |
| **4. Disponibilidad del Cliente / Stakeholders** | **Alta y Continua (Simulación de Campo y Retroalimentación Directa).** | La cercanía física con el Centro Comercial San Pedro Plaza (Neiva) y la consulta recurrente con comerciantes de comida rápida y cajeros permite validar prototipos e iteraciones de interfaz en intervalos cortos (semanales). |

---

## 2. Comparación de Metodologías de Desarrollo de Software

Se analizan tres metodologías reconocidas de la industria de acuerdo con las cuatro características de la solución Nuvora previamente identificadas:

| Criterio de Comparación | RUP (Rational Unified Process) | XP (Extreme Programming) | SCRUM (Marco Ágil Seleccionado) |
| :--- | :--- | :--- | :--- |
| **Enfoque de Proceso** | Pesado, predictivo, guiado por casos de uso y arquitectura formal con fases estrictas (Inicio, Elaboración, Construcción, Transición). | Muy ágil, centrado en programación en parejas, refactorización continua, pruebas TDD y entregas ultra-frecuentes de código. | Ágil, iterativo e incremental, organizado en Sprints de 1 a 2 semanas con roles definidos y ceremonias de inspección/adaptación. |
| **Adecuación al Tamaño del Equipo (3 personas)** | **Inadecuado:** Genera sobrecarga de artefactos de gestión y documentación formal que ralentiza a un equipo de tres aprendices. | **Parcialmente viable:** La programación en parejas constante reduce la capacidad de paralelización en un equipo de solo 3 desarrolladores. | **Óptimo:** Permite asignar roles claros (Product Owner, Scrum Master, Developers) con sincronizaciones cortas y trabajo modular paralelo. |
| **Respuesta ante Estabilidad de Requisitos** | **Rígida:** Asume que la mayoría de los requisitos se congelan al finalizar la fase de Elaboración. | **Muy flexible:** Abraza el cambio diario, pero puede provocar dispersión del alcance si no hay un control de versiones estricto. | **Equilibrada:** Fija metas claras dentro de cada Sprint (Sprint Backlog inmutable por ciclo), permitiendo reorientar el Product Backlog entre iteraciones. |
| **Alineación con la Disponibilidad del Cliente** | El cliente participa formalmente en hitos de inicio y aceptación final de fase. | Requiere que el cliente esté físicamente presente a tiempo completo (*On-site Customer*), lo cual es inviable en el contexto SENA. | Permite revisiones quincenales (*Sprint Review*), mostrando software terminado y navegable a los instructores y locatarios simulados. |

---

## 3. Selección y Justificación Metodológica

### Metodología Seleccionada: **SCRUM (Enfoque Ágil SENA)**

#### Justificación Técnica y Operativa:
1. **Adopción de Sprints iterativos de dos (2) semanas:** Permite organizar el desarrollo del proyecto formativo en ciclos cortos y continuos, facilitando revisiones periódicas con los locatarios y generando incrementos de software medibles sin atar al equipo a una cantidad rígida de ciclos futuros.
2. **Eficiencia en la división de responsabilidades:**
   - Permite que cada aprendiz lidere su frente sin bloquear a los demás:
     - **Edwin Esquivel:** Arquitectura de datos, backend relacional y transacciones atómicas.
     - **covaleda402:** Panel administrativo de locatarios, configuración de promociones y módulo de validación en caja.
     - **Paula Claros:** Diseño de experiencia de usuario en Figma, catálogo de visitante y filtro de presupuesto.
3. **Control de entregables por Sprint:** Al final de cada ciclo se obtiene un incremento de producto potencialmente desplegable (MVP), permitiendo realizar pruebas tempranas del lector QR y verificar que la respuesta en caja tome menos de 1.5 segundos.


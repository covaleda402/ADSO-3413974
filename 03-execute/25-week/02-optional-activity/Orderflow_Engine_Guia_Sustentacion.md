# Orderflow Engine --- Guía de estudio y sustentación

**Proyecto:** Orderflow Engine\
**Portal ejecutivo:**
https://ariel5253.github.io/orderflow-engine-page/\
**Fecha de entrega descrita en la fuente:** 17 de octubre de 2026

## 1. Objetivo de esta guía

Esta guía organiza la información técnica disponible para explicar el
proyecto, recorrer el portal de entrega y defender las decisiones
principales durante una sustentación. La fuente describe dos
aplicaciones distintas que no deben confundirse: el portal público de
entrega y el cliente web Angular que forma parte de la aplicación real.

## 2. Diferencia entre los dos frontends

### Portal Ejecutivo de Entrega --- `orderflow-engine-page`

Es una página pública estática alojada en GitHub Pages. Funciona como
dossier interactivo para que un evaluador pueda revisar la prueba
técnica en aproximadamente 10 minutos, sin instalar Docker. Incluye
resumen, retos, evidencia, documentos, repositorios y un simulador de
cotizaciones.

### Cliente Web Angular --- `orderflow-engine-web`

Es la aplicación real de pedidos B2B, desarrollada con Angular 22.2.3 y
TypeScript 6.0.3. Se ejecuta localmente en `http://localhost:8081`
cuando se levanta el stack mediante Docker Compose. La sección `#front`
del portal documenta este cliente, muestra seis capturas y enlaza
pruebas automatizadas.

**Idea clave para la exposición:** el portal es la vitrina de entrega y
evidencia; el cliente Angular es parte de la aplicación funcional
conectada a la API y PostgreSQL.

## 3. Recorrido de sustentación en 10 minutos

1.  **Resumen:** presentar los seis retos (A1, B1, C1, D1, E1 y Plus
    Frontend) y los indicadores reportados: 852 pruebas automatizadas en
    verde, 52 criterios de aceptación, cuatro países sembrados (CO, EC,
    GT, PE) y 82 PRs fusionados.
2.  **A1 --- Motor de precios:** usar los botones `+` y `−` de
    `BEV-COLA-350` y el interruptor de `SNK-CHIPS-45`. El simulador
    reproduce respuestas precalculadas en `data/quotes-co-alpha.json`.
    Mostrar el combo del 3%, la escala del 10% desde 12 unidades, la
    escala del 15% desde 50 unidades, el obsequio de dos `BEV-WATER-600`
    y los impuestos descritos: IVA del 19% e impuesto al azúcar del 10%.
3.  **Plus --- Cliente web:** mostrar las seis capturas, incluida la
    vista móvil de 375 × 812 px, y explicar las correcciones de texto,
    barra de acciones e imágenes. Abrir evidencias AC-42 a AC-52.
4.  **D1 --- ADR:** explicar las cuatro decisiones de arquitectura, el
    alcance excluido, dónde inspeccionar el código y los tres riesgos
    con sus mitigaciones. La fuente no enumera el detalle de esas cuatro
    decisiones ni de los riesgos; consultar la sección D1 del portal
    para exponerlos con precisión.
5.  **Documentos y repositorios:** cerrar mostrando los entregables
    oficiales y los repositorios públicos.

## 4. Indicadores y entregables

### Indicadores reportados

  Indicador                                      Valor
  -------------------------------- -------------------
  Pruebas automatizadas en verde                   852
  Criterios de aceptación                           52
  Países configurados                4: CO, EC, GT, PE
  PRs fusionados                                    82
  Tiendas preconfiguradas                            8
  Pruebas del frontend Angular                     209

La fuente explica que la cifra de pruebas subió de 850 a 852 entre el
paquete local del 16 de octubre de 2026 y el portal publicado el 17 de
octubre de 2026, tras incorporar `ArchitectureFitnessTest.java`. El
desglose publicado es 606 API + 209 Web + 25 Docs + 12 Infra.

### Seis entregables oficiales mencionados

-   Manual de usuario (ES), PDF.
-   Manual técnico (ES), PDF.
-   Informe de arquitectura APA 7 (ES), PDF.
-   Recorrido de la solución (ES), PDF.
-   Presentación ejecutiva de 20 diapositivas (PPTX ES).
-   ADR-0001 de una página (ES), PDF.

## 5. Auditoría del portal de entrega

  -----------------------------------------------------------------------------
  Componente              Tecnología / archivo          Responsabilidad
  ----------------------- ----------------------------- -----------------------
  Estructura              `index.html`, HTML5 semántico SPA estática navegada
                                                        por hash

  Estilos                 `style.css`, CSS3             Diseño responsivo,
                                                        tablas adaptadas a
                                                        tarjetas en móvil e
                                                        impresión

  Lógica                  `app.js`, JavaScript ES2022   Navegación, idioma
                                                        ES/EN, paginadores,
                                                        tablas y simulador

  Visor                   `viewer.js`, JavaScript +     Abre documentos y
                          `<dialog>` + Fetch            código en un modal sin
                                                        abandonar el portal

  Datos                   `data/evidence.json`          Relación entre
                                                        criterios de aceptación
                                                        y pruebas

  Datos del simulador     `data/quotes-co-alpha.json`   120 combinaciones
                                                        precalculadas

  Traducciones            `i18n/es.json`,               Contenido bilingüe
                          `i18n/en.json`                
  -----------------------------------------------------------------------------

### Seguridad, accesibilidad y calidad

-   La fuente reporta que `escapeHtml()` escapa caracteres especiales
    antes de insertar texto procedente de JSON o de GitHub en
    `innerHTML`, permitiendo formato controlado para negrita y código.
-   En accesibilidad, el portal incorpora enlace de salto al contenido,
    gestión de foco al cambiar de sección y cerrar el modal, y respeto
    por `prefers-reduced-motion`.
-   Usa atributos semánticos como `aria-current`, `aria-pressed`,
    `role="switch"` y `aria-checked`.
-   No depende de frameworks pesados, según la auditoría descrita.

## 6. Auditoría del cliente Angular real

### Stack confirmado en la fuente

-   Angular `22.2.3`.
-   TypeScript `6.0.3` en configuración estricta.
-   Componentes standalone, Signals (`signal()`, `computed()`,
    `rxResource()`) y `ChangeDetectionStrategy.OnPush`.
-   Internacionalización mediante `@ngx-translate/core 18.0.0`.
-   Pruebas de navegador con Vitest `5.0.5`,
    `@vitest/browser-playwright 5.0.5` y Playwright `1.64.1`.
-   209 pruebas ejecutadas en Chromium real, midiendo cajas y
    dimensiones mediante `getBoundingClientRect()`.

### Tres mecanismos para prevenir defectos visuales

#### 1. `ui-text.ts` --- prevenir texto cortado

Es el componente descrito como el único permitido para imprimir texto en
pantalla. Permite el ajuste de cadenas largas con
`overflow-wrap: anywhere`, evita `text-overflow: ellipsis` y previene
que textos extensos ensanchen el diseño.

**Evidencia:** `screen-rules.spec.ts`, AC-42 y AC-43; nombres de más de
120 caracteres en escritorio de 768 px y móvil de 375 px.

#### 2. `ui-action-bar.ts` --- evitar controles tapados

La barra inferior usa `position: sticky`, respeta
`env(safe-area-inset-bottom)` y observa `resize` y `scroll` de
`window.visualViewport`. Calcula cuánto cubre el teclado virtual y
ajusta dinámicamente su posición. Garantiza un área táctil mínima de 44
× 44 px.

**Evidencia:** `ui-action-bar.spec.ts` y `screen-rules.spec.ts`, AC-44.

#### 3. `ui-product-image.ts` --- escala uniforme de imágenes

Como el contrato de API no devuelve URLs de imagen, el componente
construye la ruta a partir del SKU (`/products/${sku}.svg`), utiliza
`object-fit: contain` y cambia a `/products/placeholder.svg` si falta la
imagen o falla su carga.

**Evidencia:** `ui-product-image.spec.ts`, AC-45.

## 7. Aislamiento por tienda y cliente

La fuente describe ocho tiendas preconfiguradas: dos por país en
Colombia, Ecuador, Guatemala y Perú.

-   Cada tienda se identifica mediante
    `storeKey(store) = "${store.tenantId}/${store.customerId}"`.
-   Las cantidades del carrito se guardan en `localStorage` bajo
    `carts`, aisladas por la clave de tienda.
-   Al cambiar de tienda, el carrito de la tienda anterior no se mezcla
    con el de la nueva.
-   El historial de pedidos filtra por `X-Tenant-Id` y `X-Customer-Id`.
-   El catálogo se recarga de forma reactiva con `rxResource()` al
    cambiar el contexto de tienda.
-   Si falla la consulta de productos, la interfaz muestra un aviso con
    opción de reintento.

**Cómo explicarlo:** el aislamiento evita que las cantidades y los
pedidos de un cliente aparezcan en el contexto de otro cliente o tienda.

## 8. Cómo ejecutar la aplicación real

La fuente indica estos comandos para clonar el repositorio y levantar
los servicios:

``` bash
git clone --recurse-submodules https://github.com/ariel5253/orderflow-engine-app.git
cd orderflow-engine-app/infra
docker compose --env-file .env.example up --build -d
```

Según el documento, el stack expone: - Cliente Angular:
`http://localhost:8081` - API Spring Boot: `http://localhost:8080`

La página pública se puede revisar sin ejecutar estos comandos.
Ejecutarlos es necesario para levantar la aplicación real en el entorno
local.

## 9. Conclusión para la sustentación

El portal concentra la evidencia, los documentos y el recorrido de
evaluación; el cliente Angular implementa el flujo web B2B. Los puntos
técnicos más sólidos que destaca la fuente son la trazabilidad de los
criterios de aceptación, la prevención estructural de tres defectos
visuales, las pruebas reales en Chromium y el aislamiento del carrito e
historial por tienda.

### Guion de cierre sugerido

> "Orderflow Engine no se presenta solamente como una interfaz. La
> entrega vincula requisitos con pruebas verificables, documenta
> decisiones de arquitectura y añade un cliente Angular con mecanismos
> reutilizables para texto, acciones e imágenes. La separación por
> tienda se mantiene en el carrito y en las consultas del historial,
> mientras que la automatización reportada permite validar el
> comportamiento de forma repetible."

## 10. Preguntas que podrían hacerte

**¿Cuál es la diferencia entre el portal y el frontend?**\
El portal es el dossier estático de entrega; `orderflow-engine-web` es
el cliente Angular real de pedidos B2B.

**¿Cómo se demuestra la lógica del motor de precios?**\
En A1 se modifican cantidades y se activa o desactiva el producto de
snacks. El simulador presenta respuestas precalculadas para ilustrar
descuentos, obsequio e impuestos.

**¿Cómo se evita que nombres largos rompan la pantalla?**\
Con `ui-text.ts`, que permite el ajuste de cadenas largas y tiene
pruebas con nombres extremos en escritorio y móvil.

**¿Cómo se evita que el teclado cubra los botones?**\
`ui-action-bar.ts` observa el viewport visual, calcula el espacio
cubierto y ajusta la barra inferior; también contempla el área segura y
el tamaño táctil.

**¿Cómo se garantiza la separación entre tiendas?**\
La clave compuesta `tenantId/customerId` separa los carritos en
`localStorage`, y el historial se consulta con ambos identificadores.

**¿Qué evidencia respalda el frontend?**\
La fuente reporta 209 pruebas en Chromium y referencias AC-42 a AC-45
para los tres mecanismos visuales, además de AC-42 a AC-52 en la tabla
de evidencia del portal.

## 11. Límites de esta guía

Esta guía está basada exclusivamente en el texto suministrado. La fuente
menciona cuatro decisiones ADR y tres riesgos con mitigaciones, pero no
desarrolla sus nombres o contenidos; deben consultarse en la sección D1
del portal antes de la presentación. Los resultados y versiones son los
reportados en el documento y no han sido verificados independientemente
en los repositorios.

# Mejoras identificadas en el MVP — Sistema de Gestión de Horarios SENA

## Introducción

Durante la revisión y prueba del MVP **SENA — Gestión de Horarios**, se realizó un recorrido por las diferentes vistas y funcionalidades disponibles para los roles de Aprendiz, Instructor, Coordinador Académico y Director de Centro.

El objetivo de esta revisión es identificar oportunidades de mejora relacionadas con:

- Funcionalidad.
- Experiencia de usuario.
- Navegación.
- Presentación de la información.
- Validaciones.
- Gestión de datos.
- Consistencia de la interfaz.

Los hallazgos registrados corresponden a situaciones observadas directamente durante la interacción con el MVP.

---

# 1. Vista Aprendiz

## 1.1. Eliminar el desplazamiento horizontal innecesario en las notificaciones

### Situación actual

En el panel de **Notificaciones** existe un desplazamiento vertical y uno horizontal.

El desplazamiento vertical es necesario para consultar todas las notificaciones disponibles. Sin embargo, el desplazamiento horizontal resulta innecesario y dificulta la visualización del contenido.

### Problema identificado

El desplazamiento horizontal hace que parte del contenido quede fuera del área visible del panel, obligando al usuario a desplazarse lateralmente para visualizar completamente algunos elementos.

### Mejora propuesta

- Mantener únicamente el desplazamiento vertical.
- Ajustar el contenido al ancho disponible.
- Evitar el desbordamiento horizontal.
- Adaptar textos y elementos al tamaño del panel.

### Beneficio

Mejorar la experiencia de usuario y facilitar la lectura de las notificaciones.

### Prioridad

**Media**

---

## 1.2. Corregir la información mostrada en el detalle de las clases

### Situación actual

Desde la sección **Mi horario**, cada clase cuenta con la opción **"Ver detalle"**.

Al seleccionar diferentes clases, el sistema continúa mostrando la información correspondiente a una única clase.

Por ejemplo, al seleccionar **"Modelado de bases de datos"**, se muestra información correspondiente a **"Desarrollo de software"**.

### Problema identificado

El detalle de la clase no está asociado correctamente con la actividad seleccionada.

### Mejora propuesta

Hacer que cada opción **"Ver detalle"** cargue la información correspondiente a la clase seleccionada.

### Beneficio

Evitar información incorrecta y permitir que el aprendiz consulte correctamente los datos de cada actividad.

### Prioridad

**Alta**

---

## 1.3. Corregir elementos visuales que aparentan ser interactivos

### Situación actual

El encabezado que muestra:

**SENA — Gestión de Horarios**  
**Centro de Formación**

presenta un comportamiento visual similar al de un elemento interactivo al pasar el cursor.

Sin embargo, al hacer clic no se ejecuta ninguna acción.

### Problema identificado

El comportamiento visual genera una expectativa de interacción que no corresponde con la funcionalidad disponible.

### Mejora propuesta

- Si el elemento debe ser interactivo, implementar la acción correspondiente.
- Si no debe ser interactivo, eliminar el comportamiento visual que indique que puede seleccionarse.

### Beneficio

Mejorar la consistencia entre el diseño visual y el comportamiento de la interfaz.

### Prioridad

**Baja**

---

## 1.4. Corregir la paginación de las notificaciones

### Situación actual

En la sección **Notificaciones** aparecen controles de paginación:

- Anterior.
- Página 1.
- Página 2.
- Página 3.
- Siguiente.
- Cantidad de elementos por página.

Estos controles no realizan ninguna acción.

### Problema identificado

La interfaz indica que existen diferentes páginas de notificaciones, pero el usuario no puede utilizarlas para acceder a las demás.

### Mejora propuesta

Implementar correctamente:

- Página anterior.
- Página siguiente.
- Selección directa de página.
- Cantidad de elementos por página.
- Estado de los botones según la página actual.

### Beneficio

Permitir al aprendiz consultar todas sus notificaciones.

### Prioridad

**Alta**

---

## 1.5. Permitir interacción con el perfil cuando están abiertas las notificaciones

### Situación actual

Cuando el panel de notificaciones está abierto, el usuario no puede interactuar con el elemento del perfil ubicado en la parte superior derecha.

Es necesario cerrar primero el panel de notificaciones.

### Problema identificado

Existe un conflicto de interacción entre el panel de notificaciones y otros elementos de navegación.

### Mejora propuesta

Permitir que el usuario seleccione el perfil aunque las notificaciones estén abiertas.

Al seleccionar el perfil:

1. Cerrar el panel de notificaciones.
2. Abrir o permitir visualizar el menú del perfil.

### Beneficio

Mejorar la navegación y evitar bloqueos innecesarios entre componentes.

### Prioridad

**Media**

---

# 2. Vista Instructor

## 2.1. Corregir navegación entre semanas

### Situación actual

En **Mi Horario**, los botones:

- Semana anterior.
- Semana siguiente.

no funcionan.

### Problema identificado

El instructor no puede desplazarse correctamente entre las diferentes semanas disponibles.

### Mejora propuesta

Implementar la navegación entre semanas mediante los botones correspondientes.

### Beneficio

Permitir consultar horarios de diferentes semanas de manera sencilla.

### Prioridad

**Alta**

---

## 2.2. Corregir la información del detalle de sesión

### Situación actual

Al seleccionar un recuadro de una sesión se muestran los detalles, pero la información mostrada corresponde siempre a una única sesión.

Por ejemplo, al seleccionar una sesión de **Bases de datos**, se muestra información correspondiente a **ADSO**.

Además, se identificó una diferencia entre la información mostrada en el recuadro de la semana y la información mostrada en el detalle de sesión.

### Problema identificado

La información de las sesiones no está asociada correctamente con cada elemento seleccionado.

### Mejora propuesta

Cada sesión debe mostrar únicamente la información que le corresponde tanto en:

- El recuadro del horario.
- El detalle de sesión.

### Beneficio

Evitar inconsistencias y proporcionar información correcta al instructor.

### Prioridad

**Alta**

---

## 2.3. Corregir la paginación de excepciones

### Situación actual

En la sección de excepciones aparecen controles como:

- Anterior.
- 1.
- 2.
- 3.
- Siguiente.
- 10 por página.

Estos controles no funcionan.

### Problema identificado

El instructor no puede navegar correctamente entre las excepciones registradas.

### Mejora propuesta

Implementar correctamente la paginación y el selector de cantidad de registros por página.

### Prioridad

**Alta**

---

## 2.4. Revisar permisos para eliminar excepciones

### Situación actual

El instructor cuenta con una opción para eliminar sus excepciones.

### Problema identificado

Se considera que la eliminación de excepciones podría no corresponder a las funciones del instructor.

### Mejora propuesta

Evaluar que el instructor pueda:

- Consultar sus excepciones.
- Editar sus excepciones.

Mientras que la eliminación quede restringida al rol que corresponda según los permisos definidos para el sistema.

### Beneficio

Mejorar el control de permisos y evitar modificaciones no autorizadas.

### Prioridad

**Alta**

---

## 2.5. Corregir el comportamiento del listado de excepciones

### Situación actual

El desplazamiento de la página provoca que el usuario tenga que desplazarse por toda la página para consultar las excepciones.

### Problema identificado

La navegación de las excepciones no resulta cómoda cuando existen varios registros.

### Mejora propuesta

Implementar un desplazamiento independiente dentro del listado de excepciones, permitiendo consultar todos los registros sin desplazar innecesariamente toda la página.

### Beneficio

Mejorar la experiencia de usuario y facilitar la consulta de excepciones.

### Prioridad

**Media**

---

## 2.6. Corregir creación y validación de excepciones

### Situación actual

No es posible agregar correctamente una excepción del instructor.

Además, el aviso relacionado con la **fecha fin** continúa apareciendo incluso cuando la fecha fin ya es posterior a la fecha de inicio.

### Problema identificado

La validación no se actualiza correctamente después de corregir los datos.

### Mejora propuesta

- Permitir registrar correctamente una excepción.
- Actualizar la validación después de modificar las fechas.
- Mostrar el mensaje únicamente cuando exista realmente un error.
- Validar correctamente que la fecha final sea posterior a la fecha inicial.

### Prioridad

**Alta**

---

## 2.7. Evitar elementos de cierre duplicados

### Situación actual

El formulario de excepciones contiene una **X** para cerrar y un botón **Cancelar**.

### Problema identificado

Ambos elementos cumplen una función similar, lo que puede generar redundancia en la interfaz.

### Mejora propuesta

Definir una única acción de cancelación/cierre o establecer claramente la función de cada elemento.

### Beneficio

Simplificar la interfaz y evitar acciones duplicadas.

### Prioridad

**Baja**

---

# 3. Seguimiento de la ficha — Instructor

## 3.1. Corregir botón de registrar seguimiento

### Situación actual

El botón **Registrar seguimiento** contiene un símbolo **"+"** adicional que no resulta necesario.

### Mejora propuesta

Eliminar el símbolo adicional y mantener un diseño consistente con los demás botones del sistema.

### Prioridad

**Baja**

---

## 3.2. Automatizar el porcentaje de avance

### Situación actual

El avance de los aprendices no parece actualizarse automáticamente según las evidencias de aprendizaje completadas.

### Problema identificado

El porcentaje de avance debería representar el progreso real del aprendiz.

### Mejora propuesta

Actualizar el porcentaje de avance de acuerdo con las evidencias de aprendizaje completadas.

### Beneficio

Obtener una representación más precisa del avance académico.

### Prioridad

**Alta**

---

## 3.3. Revisar la necesidad de seguimiento según el avance curricular

### Situación actual

Se considera que los aprendices con un avance curricular adecuado no deberían requerir necesariamente seguimiento, mientras que aquellos con bajo avance sí deberían requerirlo.

### Mejora propuesta

Evaluar reglas que permitan determinar cuándo un aprendiz requiere seguimiento según su avance curricular.

### Prioridad

**Media**

---

## 3.4. Corregir botones de seguimiento

### Situación actual

Los botones disponibles en el panel de seguimiento no funcionan correctamente.

### Mejora propuesta

Revisar y conectar cada botón con la acción correspondiente.

### Prioridad

**Alta**

---

## 3.5. Corregir validación del total de aprendices

### Situación actual

El sistema continúa mostrando una advertencia indicando que no se puede superar el total de aprendices, incluso cuando la cantidad ingresada es igual o menor al total permitido.

### Problema identificado

La validación no está evaluando correctamente el límite permitido.

### Mejora propuesta

Corregir la validación para que:

- Permita cantidades iguales al máximo permitido.
- Bloquee únicamente cantidades superiores al límite.
- Actualice el mensaje de advertencia según el valor ingresado.

### Prioridad

**Alta**

---

## 3.6. Corregir cálculo del porcentaje

### Situación actual

El porcentaje de seguimiento puede superar el 100%.

### Problema identificado

El porcentaje no está limitado correctamente al rango esperado.

### Mejora propuesta

Ajustar el cálculo para que el porcentaje no pueda superar el **100 %**.

### Resultado esperado

El porcentaje debe mantenerse dentro de un rango válido.

### Prioridad

**Alta**

---

## 3.7. Corregir botón Guardar

### Situación actual

El botón **Guardar** no funciona.

### Mejora propuesta

Implementar correctamente la acción de guardar y verificar que los datos ingresados sean almacenados.

### Prioridad

**Alta**

---

# 4. Vista Coordinador Académico

## 4.1. Corregir botón Nuevo horario

### Situación actual

El botón **Nuevo horario** presenta un símbolo **"+"** adicional.

### Mejora propuesta

Eliminar el elemento adicional y mantener una presentación consistente con los demás botones.

### Prioridad

**Baja**

---

# 5. Panel de Fichas Activas

## 5.1. Corregir paginación

### Situación actual

Los botones inferiores de navegación:

- Anterior.
- 1.
- 2.
- 3.
- Siguiente.

no funcionan.

### Mejora propuesta

Implementar correctamente la navegación entre páginas.

### Prioridad

**Alta**

---

## 5.2. Corregir filtro de fichas

### Situación actual

El filtro no realiza la búsqueda de las fichas.

El campo puede limpiarse, pero no filtra los resultados según el criterio ingresado.

### Mejora propuesta

Implementar correctamente el filtrado para mostrar únicamente las fichas que coincidan con el criterio de búsqueda.

### Prioridad

**Alta**

---

# 6. Panel de Horarios en Borrador

## 6.1. Corregir filtros

### Situación actual

Los filtros del panel no funcionan correctamente.

### Mejora propuesta

Implementar el filtrado de los horarios de acuerdo con los criterios seleccionados.

### Prioridad

**Alta**

---

## 6.2. Corregir botón Nuevo horario

### Situación actual

El botón **Nuevo horario** presenta un símbolo **"+"** adicional.

### Mejora propuesta

Eliminar el símbolo adicional para mantener consistencia visual.

### Prioridad

**Baja**

---

## 6.3. Corregir paginación

### Situación actual

Los botones inferiores de paginación no funcionan.

### Mejora propuesta

Implementar correctamente la navegación entre páginas.

### Prioridad

**Alta**

---

## 6.4. Corregir aviso de conflictos

### Situación actual

El aviso de conflictos aparece constantemente.

### Problema identificado

El sistema muestra una advertencia sin que necesariamente exista una condición que justifique mantenerla visible.

### Mejora propuesta

Mostrar el aviso únicamente cuando exista realmente un conflicto en el horario.

### Prioridad

**Alta**

---

# 7. Edición de horarios

## 7.1. Corregir botones de edición

### Situación actual

En la sección de edición de horarios, los botones no funcionan correctamente.

### Mejora propuesta

Revisar e implementar las acciones correspondientes a cada botón.

### Prioridad

**Alta**

---

## 7.2. Corregir filtros

### Situación actual

Los filtros de la sección de edición de horarios no funcionan.

### Mejora propuesta

Permitir filtrar correctamente la información mostrada.

### Prioridad

**Alta**

---

## 7.3. Corregir formulario de agregar sesión

### Situación actual

Al agregar una sesión, la advertencia continúa apareciendo incluso cuando la condición que la genera debería haberse solucionado.

Además, algunos botones no funcionan.

### Mejora propuesta

- Corregir las validaciones.
- Actualizar dinámicamente los mensajes.
- Implementar correctamente los botones.

### Prioridad

**Alta**

---

## 7.4. Simplificar botones de cierre

### Situación actual

El formulario posee una **X** para cerrar y un botón **Cancelar**.

### Mejora propuesta

Evitar acciones duplicadas y definir claramente el mecanismo de cierre del formulario.

### Prioridad

**Baja**

---

## 7.5. Implementar edición y eliminación de sesiones

### Situación actual

No es posible editar correctamente las sesiones existentes.

Tampoco es posible eliminar una sesión.

Además, aparecen dos elementos destinados aparentemente a eliminar la sesión:

- Botón con **X**.
- Botón con icono de papelera.

### Problema identificado

Existe una combinación de funcionalidades faltantes y elementos duplicados.

### Mejora propuesta

- Permitir editar sesiones existentes.
- Permitir eliminar sesiones según los permisos correspondientes.
- Mantener un único control para eliminar.
- Definir claramente la función de cada botón.

### Prioridad

**Alta**

---

# 8. Publicación de horarios

## 8.1. Corregir publicación de horarios

### Situación actual

Al intentar publicar un horario, el sistema no realiza la publicación correctamente.

En lugar de publicar el horario seleccionado, redirige hacia un horario que ya se encuentra publicado o en ese estado.

### Problema identificado

La acción de publicación no está asociada correctamente con el horario que se intenta publicar.

### Mejora propuesta

Al seleccionar **Publicar**, el sistema debe:

1. Validar el horario.
2. Identificar correctamente el horario seleccionado.
3. Publicarlo.
4. Mostrar una confirmación del resultado.
5. Actualizar su estado a **Publicado**.

### Prioridad

**Alta**

---

# 9. Panel de Conflictos

## 9.1. Corregir filtros y botones

### Situación actual

Los filtros y botones del panel de conflictos no funcionan correctamente.

### Mejora propuesta

Implementar las acciones correspondientes y permitir filtrar los conflictos.

### Prioridad

**Alta**

---

## 9.2. Corregir estado de conflictos resueltos

### Situación actual

Al marcar un conflicto como **resuelto**, este continúa apareciendo como conflicto.

### Problema identificado

El estado visual del conflicto no se actualiza después de realizar la acción.

### Mejora propuesta

Cuando un conflicto sea marcado como resuelto:

- Actualizar inmediatamente su estado.
- Evitar que continúe apareciendo como conflicto activo.
- Mantener un registro del estado resuelto cuando corresponda.

### Prioridad

**Alta**

---

# 10. Disponibilidad

## 10.1. Corregir filtros

### Situación actual

Los filtros disponibles en el panel de disponibilidad no funcionan.

### Mejora propuesta

Implementar correctamente los filtros para permitir consultar la información según los criterios seleccionados.

### Prioridad

**Media**

---

# 11. Reportes y carga de instructores

## 11.1. Corregir reporte de utilización de horas

### Situación actual

El botón **Ver reporte de utilización de horas** no funciona.

### Mejora propuesta

Implementar la acción correspondiente y permitir visualizar el reporte.

### Prioridad

**Media**

---

## 11.2. Corregir funcionalidades de instructores

### Situación actual

Los botones relacionados con la sección de instructores no funcionan.

### Mejora propuesta

Revisar cada acción y asociarla correctamente con su funcionalidad.

### Prioridad

**Alta**

---

## 11.3. Corregir reporte de carga

### Situación actual

El botón **Ver reporte de carga** no funciona.

### Mejora propuesta

Implementar correctamente la consulta y visualización del reporte de carga.

### Prioridad

**Media**

---

# 12. Vista Director de Centro

## 12.1. Corregir filtros de indicadores

### Situación actual

En la sección **Indicadores**, los filtros no funcionan.

### Mejora propuesta

Implementar correctamente los filtros para actualizar la información mostrada según los criterios seleccionados.

### Prioridad

**Alta**

---

## 12.2. Corregir enlace "Ver todos"

### Situación actual

El botón o enlace **Ver todos** no funciona.

### Mejora propuesta

Implementar la navegación correspondiente para permitir consultar la totalidad de la información disponible.

### Prioridad

**Media**

---

# 13. Administrador de usuarios

## 13.1. Corregir filtro de usuarios

### Situación actual

El filtro del administrador de usuarios no funciona.

### Mejora propuesta

Permitir buscar y filtrar usuarios según los criterios establecidos.

### Prioridad

**Alta**

---

## 13.2. Corregir creación de usuarios

### Situación actual

La opción para agregar nuevos usuarios presenta problemas.

El nuevo usuario no se guarda correctamente.

### Mejora propuesta

Implementar correctamente el proceso de creación y almacenamiento de nuevos usuarios.

El sistema debería:

1. Permitir ingresar los datos.
2. Validar la información.
3. Guardar el usuario.
4. Mostrar una confirmación.
5. Actualizar el listado de usuarios.

### Prioridad

**Alta**

---

## 13.3. Revisar botones de cierre

### Situación actual

El formulario para agregar usuarios presenta el mismo problema relacionado con la existencia de dos mecanismos para cerrar el panel.

### Mejora propuesta

Simplificar los mecanismos de cierre y evitar acciones duplicadas.

### Prioridad

**Baja**

---

# 14. Vista Administrador de Soporte — Documentos

## 14.1. Inconsistencias en filtros de búsqueda

### Situación actual

El filtro de **Fecha** tiene un comportamiento incompleto; muestra un selector individual en lugar de un rango claro, por ejemplo, **"Fecha desde / Fecha hasta"**, lo que impide filtrar de manera efectiva en reportes históricos.

Además, el campo **Plantilla** permite ingresar texto dinámico sin autocompletado claro o dropdown de selección, a diferencia de los selectores de **Dominio** y **Estado**.

### Problema identificado

Los filtros presentan comportamientos diferentes y no ofrecen una experiencia de búsqueda consistente.

### Mejora propuesta

- Implementar un rango de fechas con campos **Fecha desde / Fecha hasta**.
- Incorporar un selector o autocompletado para el campo **Plantilla**.
- Mantener un comportamiento consistente entre los diferentes filtros.

### Prioridad

**Media**

---

## 14.2. Gestión de estados e interacción

### Situación actual

En la tabla, los documentos con estado **"Generando…"** tienen habilitada la opción **[Descargar]**.

Los documentos con estado **"Error de generación"** muestran el botón **[Reintentar]**, pero carecen de un enlace o modal de detalle para visualizar la causa técnica del error.

### Problema identificado

Existe una inconsistencia funcional entre el estado del documento y las acciones disponibles.

Un documento que todavía se está generando no debería estar disponible para descarga.

Además, cuando ocurre un error de generación, el usuario no dispone de información suficiente para conocer la causa.

### Mejora propuesta

- Deshabilitar **[Descargar]** mientras el documento se encuentre en estado **"Generando…"**.
- Permitir visualizar información sobre el error mediante un detalle, modal o mecanismo equivalente.
- Mantener disponible **[Reintentar]** cuando corresponda.

### Prioridad

**Alta**

---

## 14.3. Información de la tabla

### Situación actual

La vista general de documentos no presenta información sobre el tamaño o formato del archivo.

### Problema identificado

Falta información relevante para la gestión de archivos, especialmente cuando existen múltiples documentos.

### Mejora propuesta

Agregar una columna que indique:

- Formato del archivo.
- Tamaño del archivo.

Por ejemplo:

- `.pdf`
- `.xlsx`
- KB.
- MB.

### Beneficio

Facilitar la identificación y gestión de los documentos.

### Prioridad

**Media**

---

# 15. Vista Administrador de Soporte — Plantillas

## 15.1. Conservar filtros y paginación al regresar

### Situación actual

Al intentar ver o editar una plantilla, el botón de **Regresar/Cancelar** no conserva los filtros ni la paginación seleccionada previamente.

### Problema identificado

El usuario pierde el contexto de navegación y debe volver a configurar los filtros o buscar nuevamente la página en la que se encontraba.

### Mejora propuesta

Conservar los filtros y la página seleccionada al regresar al listado de plantillas.

### Prioridad

**Media**

---

## 15.2. Diferenciar plantillas públicas y personalizadas

### Situación actual

No existe una distinción visual clara entre plantillas **Públicas/Globales** y plantillas **Personalizadas por Centro**.

### Problema identificado

El usuario puede tener dificultades para identificar el alcance de cada plantilla.

### Mejora propuesta

Incorporar una diferenciación visual clara que permita identificar:

- Plantillas Públicas/Globales.
- Plantillas Personalizadas por Centro.

### Prioridad

**Media**

---

## 15.3. Incorporar vista previa en tiempo real

### Situación actual

El editor de plantillas no cuenta con un mecanismo de **Vista Previa en tiempo real (Live Preview)** al editar variables o código fuente de la plantilla HTML/Handlebars.

### Problema identificado

El usuario debe modificar la plantilla sin poder visualizar inmediatamente cómo quedará el resultado.

### Mejora propuesta

Incorporar una vista previa en tiempo real que permita observar los cambios realizados en la plantilla.

### Prioridad

**Media**

---

## 15.4. Incorporar validación sintáctica de variables

### Situación actual

No existe una validación sintáctica visible para la sustitución de variables.

Por ejemplo, no se muestra una advertencia cuando se utiliza un tag no reconocido como:

`{{nombre_instructor_invalido}}`

### Problema identificado

El usuario puede guardar una plantilla con variables incorrectas sin recibir una advertencia clara.

### Mejora propuesta

Implementar validación de variables y mostrar advertencias cuando se utilicen tags no reconocidos.

### Prioridad

**Alta**

---

# 16. Vista Administrador de Soporte — Auditoría

## 16.1. Mejorar paginación y rendimiento

### Situación actual

La vista puede mostrar miles de registros sin un control de límite de exportación o una vista rápida por **Rangos de Horas/Fechas** específicos.

### Problema identificado

La consulta de grandes cantidades de registros puede dificultar la navegación y la gestión de la información.

### Mejora propuesta

Incorporar:

- Rangos de fechas.
- Rangos de horas.
- Límites para exportación.
- Opciones de consulta rápida.

### Prioridad

**Media**

---

## 16.2. Mejorar el detalle de los eventos

### Situación actual

La vista en tabla trunca el *payload* o los datos cambiados (**Before / After**) y no dispone de un modal o vista expandible para examinar el JSON completo de la transacción auditada.

### Problema identificado

La información completa de los eventos no puede consultarse directamente desde la tabla.

### Mejora propuesta

Implementar un modal o vista expandible que permita consultar el JSON completo y los datos:

- Before.
- After.
- Payload.

### Prioridad

**Alta**

---

## 16.3. Agregar filtros de auditoría

### Situación actual

No existe un filtro por **Dirección IP** o **Nivel de Severidad**.

### Mejora propuesta

Incorporar filtros para:

- Dirección IP.
- Nivel de severidad:
  - Info.
  - Warning.
  - Error.
  - Critical.

### Prioridad

**Media**

---

# 17. Vista Administrador de Soporte — Parametrización

## 17.1. Incorporar confirmación de seguridad

### Situación actual

Modificar parámetros globales del sistema no exige un paso de **Confirmación de Seguridad**.

### Problema identificado

Los cambios sobre parámetros globales pueden tener un impacto importante y actualmente no existe un paso adicional de confirmación.

### Mejora propuesta

Incorporar un mecanismo de confirmación antes de modificar parámetros globales, por ejemplo:

- Modal de confirmación.
- Reautenticación.
- Advertencia sobre el impacto del cambio.

### Prioridad

**Alta**

---

## 17.2. Incorporar historial de modificaciones

### Situación actual

No se refleja un **Historial de Modificaciones por Parámetro**.

### Problema identificado

No existe información visible sobre quién modificó un parámetro ni cuándo se realizó el cambio.

### Mejora propuesta

Incorporar un historial que permita consultar:

- Parámetro modificado.
- Valor anterior.
- Valor nuevo.
- Usuario responsable.
- Fecha y hora de modificación.

### Prioridad

**Alta**

---

## 17.3. Validar tipos de datos de los parámetros

### Situación actual

Los parámetros numéricos o de tipo booleano (On/Off) aceptan entrada de texto plano sin validación estricta de formato en tiempo de edición.

### Problema identificado

El usuario podría ingresar valores incompatibles con el tipo de parámetro.

### Mejora propuesta

Implementar validaciones específicas según el tipo de dato:

- Valores numéricos: aceptar únicamente valores numéricos.
- Valores booleanos: utilizar controles como interruptores o selectores On/Off.
- Mostrar mensajes de validación cuando el valor ingresado no sea válido.

### Prioridad

**Alta**

---

# 18. Vista Director de Centro — Parametrización y Datos de Referencia

## 18.1. Revisar jerarquía de permisos entre Sede y Centro

### Situación actual

La interfaz permite la edición de parámetros que deberían ser exclusivamente globales, correspondientes a un ámbito nacional o de soporte.

### Problema identificado

Esto puede generar conflictos entre la parametrización nacional y las reglas definidas para el centro local.

### Mejora propuesta

Revisar los permisos y el alcance de los parámetros para evitar que un Director de Centro pueda modificar configuraciones que correspondan exclusivamente a niveles superiores.

### Prioridad

**Alta**

---

## 18.2. Diferenciar parámetros heredados y configurables

### Situación actual

No existe un indicador visual claro que permita distinguir entre parámetros:

- **Heredados (Solo lectura)**.
- **Configurables a nivel Centro**.

### Problema identificado

El usuario puede no identificar fácilmente qué parámetros puede modificar y cuáles son administrados desde otro nivel.

### Mejora propuesta

Agregar una identificación visual clara para diferenciar:

- Parámetros heredados.
- Parámetros configurables a nivel Centro.

### Prioridad

**Media**

---

## 18.3. Incorporar carga masiva de datos de referencia

### Situación actual

En las listas de referencia relacionadas con **Ambientes, Fichas y Programas**, falta una opción de **Carga Masiva** mediante archivos Excel/CSV o se presentan inconsistencias en el mapeo de columnas al subir datos de referencia.

### Problema identificado

La gestión de grandes cantidades de datos puede requerir un proceso manual y generar errores cuando la información se carga mediante archivos.

### Mejora propuesta

Implementar o mejorar la carga masiva mediante:

- Excel.
- CSV.

Además, validar correctamente el mapeo de las columnas durante la importación.

### Prioridad

**Media**

---

## 18.4. Validar conflictos antes de eliminar o desactivar datos de referencia

### Situación actual

Al eliminar o desactivar un dato de referencia, por ejemplo un **Ambiente** o una **Sede**, el sistema no valida ni advierte sobre posibles conflictos con horarios activos o asignados asociados a ese elemento.

### Problema identificado

La eliminación o desactivación de un dato utilizado actualmente podría generar inconsistencias en los horarios existentes.

### Mejora propuesta

Antes de eliminar o desactivar un dato de referencia, el sistema debería:

1. Verificar si existen horarios activos o asignados relacionados.
2. Informar al usuario sobre los conflictos encontrados.
3. Solicitar confirmación cuando corresponda.
4. Impedir la acción cuando pueda generar inconsistencias críticas.

### Prioridad

**Alta**

---

# Resumen general de hallazgos

| Vista / Panel | Principales problemas |
|---|---|
| Aprendiz | Scroll horizontal, información incorrecta en detalles, paginación, interacción entre notificaciones y perfil |
| Instructor | Navegación semanal, detalles incorrectos, paginación, excepciones, validaciones, seguimiento |
| Coordinador Académico | Botones, filtros, paginación, conflictos, edición y publicación de horarios |
| Director de Centro | Indicadores, filtros, reportes, administrador de usuarios, parametrización y datos de referencia |
| Administrador de Soporte | Documentos, plantillas, auditoría, parametrización y soporte técnico |

---

## Observación

Las mejoras anteriores fueron identificadas mediante la revisión y prueba directa de las funcionalidades disponibles en el MVP.

Los elementos que todavía no se encuentran implementados o que requieren una revisión adicional serán analizados posteriormente y no se consideran dentro de los hallazgos actuales hasta realizar las pruebas correspondientes.
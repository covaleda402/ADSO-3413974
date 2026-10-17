# 5 preguntas adicionales sobre el proyecto Orderflow Engine

## 1. Validación del límite de crédito del cliente

¿Cómo debe actuar el sistema al confirmar un pedido cuyo importe supera el límite de crédito disponible del cliente, garantizando que la operación no deje cambios parciales en el pedido ni en el crédito?

## 2. Pruebas de aceptación del motor de precios

¿Qué pruebas de aceptación deben implementarse para verificar los escenarios exigidos en el documento, incluyendo descuentos por escala, combos, obsequios, impuestos y pedidos que superen el límite de crédito?

## 3. Límites transaccionales durante la confirmación

¿Qué operaciones deben ejecutarse dentro de la transacción de confirmación del pedido y cuáles deben realizarse fuera de ella para mantener la consistencia de los datos y evitar llamadas a servicios externos durante la transacción?

## 4. Decisiones de arquitectura y registro de decisiones (ADR)

¿Qué decisiones técnicas, alternativas consideradas, funcionalidades expresamente excluidas, aspectos prioritarios para la revisión del código y riesgos con sus respectivas mitigaciones deben documentarse en el ADR solicitado, respetando el límite de una página?

## 5. Requisitos de calidad de la interfaz de usuario

Si se implementa la pantalla opcional de resumen del pedido, ¿cómo se debe estructurar la interfaz para evitar que el texto quede cortado, que los controles sean ocultados por el teclado o la navegación del sistema, y que las imágenes pierdan la uniformidad de escala?



# Matriz de pruebas funcionales

## Laboratorio de aplicación móvil con SQLite

**Estudiante:** John Henry Mebius Quintanilla  
**Asignatura:** Técnicas de Calidad de Software  
**Fecha:** 25/11/2026  
**Aplicación:** Inventario  
**Dispositivo utilizado:** Samsung Galaxy A32 (SM-A325M)  
**Plataforma:** Android  

## Objetivo de las pruebas

El objetivo de las pruebas fue comprobar el funcionamiento de las operaciones CRUD, las validaciones de los formularios y la persistencia de los datos almacenados en SQLite.

Se realizaron las pruebas directamente desde el teléfono Android de mi mamá, lol, utilizando los datos de prueba indicados en las instrucciones del laboratorio.

## Resultados obtenidos

| ID | Resultado obtenido | Estado | Observaciones |
|---|---|---|---|
| P01 | Al iniciar la aplicación sin productos se mostró el mensaje "No hay productos registrados". | Aprobada | La aplicación muestra correctamente el estado de lista vacía. |
| P02 | Se registró el producto Cuaderno. Se mostró el mensaje "Producto guardado" y el producto apareció en el listado. | Aprobada | El registro se realizó correctamente. |
| P03 | Pudo visualizarse el nombre, descripción, precio y cantidad del producto registrado. | Aprobada | Los datos mostrados coinciden con los ingresados en el formulario. |
| P04 | Se agregaron los productos Lápiz, Borrador y Regla. Los cuatro productos se mostraron en orden alfabético. | Aprobada | El listado se actualizó después de cada registro. |
| P05 | Se modificó el precio del Cuaderno a $4.00 y su cantidad a 20. Los cambios se reflejaron en el listado. | Aprobada | Se mostró el mensaje "Producto actualizado". |
| P06 | Se eliminó el producto Regla después de aceptar el mensaje de confirmación. | Aprobada | El producto desapareció del listado y se mostró el mensaje "Producto eliminado". |
| P07 | Se intentó eliminar el producto Lápiz, pero la operación fue cancelada. | Aprobada | El producto permaneció en el listado sin modificaciones. |
| P08 | Se intentó guardar un producto dejando vacío el campo del nombre. La aplicación mostró un mensaje de validación. | Aprobada | No fue posible registrar el producto sin ingresar su nombre. |
| P09 | Se ingresó el valor "abc" en el campo del precio. La aplicación indicó que el precio no era válido. | Aprobada | No se permitió guardar el producto con un precio no numérico. |
| P10 | Se ingresó un precio de -5 y la aplicación mostró un mensaje indicando que el precio no puede ser negativo. | Aprobada | La validación impidió guardar el producto. |
| P11 | Se realizaron dos intentos de registro utilizando las cantidades 2.5 y -1. Ambos valores fueron rechazados. | Aprobada | La cantidad debe ser un número entero mayor o igual a cero. |
| P12 | Se registró el producto Marcador sin descripción. El producto se guardó correctamente. | Aprobada | En el listado se mostró el texto "Sin descripción". |
| P13 | La aplicación fue cerrada desde la pantalla de aplicaciones recientes del teléfono. | Aprobada | La aplicación se cerró sin presentar inconvenientes. |
| P14 | Se volvió a abrir la aplicación y pudieron visualizarse nuevamente los productos registrados. | Aprobada | Efectivamente, la persistencia persiste. |
| P15 | Se compararon los productos antes y después de cerrar la aplicación. Los datos coincidieron y se conservaron las modificaciones y eliminaciones realizadas. | Aprobada | Se confirmó la persistencia de la información en SQLite. |
| P16 | Se eliminaron todos los productos, se cerró la aplicación y se volvió a abrirla. Se mostró nuevamente el mensaje de lista vacía. | Aprobada | Las eliminaciones también se conservaron después de reiniciar la aplicación. |

## Resumen de resultados

| Concepto | Cantidad |
|---|---:|
| Pruebas planificadas | 16 |
| Pruebas ejecutadas | 16 |
| Pruebas aprobadas | 16 |
| Pruebas fallidas | 0 |
| Porcentaje de aprobación | 100 % |

## Evidencias

Durante la ejecución de las pruebas tomé capturas de pantalla para demostrar el funcionamiento de la aplicación.

Las capturas se encuentran en la carpeta [evidencias](./evidencias/).

| Código | Descripción | Pruebas relacionadas |
|---|---|---|
| E1 | Creación de la base de datos e inicio de la aplicación. | P01 |
| E2 | Registro de un producto y mensaje de confirmación. | P02 |
| E3 | Consulta y listado de productos registrados. | P03, P04 |
| E4 | Producto antes y después de modificar sus datos. | P05 |
| E5 | Confirmación y eliminación de productos. | P06, P07 |
| E6 | Validaciones de los campos del formulario. | P08, P09, P10, P11 |
| E7 | Persistencia de los datos después de cerrar y abrir la aplicación. | P13, P14, P15, P16 |
| E8 | Matriz de pruebas funcionales completada. | P01-P16 |

También incluí capturas adicionales para demostrar algunos resultados específicos, como la cancelación de una eliminación, el registro de un producto sin descripción y el estado de lista vacía después de reiniciar la aplicación.

## Conclusión

Después de realizar las 16 pruebas funcionales, pude comprobar que la aplicación cumple con las funcionalidades solicitadas en el laboratorio.

Las operaciones CRUD funcionan correctamente y las validaciones evitan que se almacenen datos incorrectos. También comprobé que la información permanece almacenada en SQLite después de cerrar y volver a abrir la aplicación.

Las pruebas me permitieron verificar el funcionamiento de la aplicación en un dispositivo Android real y comprender la importancia de realizar pruebas antes de finalizar el desarrollo de un software.

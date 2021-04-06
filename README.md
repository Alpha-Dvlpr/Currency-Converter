# Currency-Converter

Sobre la app:
- Se han desarrollado interfaces tanto con storyboards como por código.
- Se ha utilizado el patrón de diseño MVC.
- Se han creado objetos personalizados para la introducción de datos:
  - Selector de divisas y campo de introducción de importe.
  - Los dos hacen uso de un ToolBar personalizado e implementan su 'delegate'.
- Se ha implementado un control de entrada:
  - Sólo se permite la introducción de números y del separador decimal coma.
  - Sólo se realiza la conversión si hay un valor y una divisa seleccionada (por defecto aparece la genérica "-").
- Tras la primera obtención de divisas estas se guardan en Realm para los próximos usos de la app.
- Se gestionan de manera personalizada los estados de carga y error en las llamadas de la API, proporcionando un botón de reintentar en caso de error.
- Se ha añadido una barra de búsqueda para filtrar la lista de conversiones:
  - Hay un pequeño bug al pulsar el botón 'x' que borra por completo el texto que hace que se vuelva a abrir el teclado.
  - Se ha añadido un evento a la vista para cerrar el teclado al pulsar en cualquier parte libre de la pantalla.
- Se ha cambiado la API proporcionada originalmente por un error de la misma:
  - "You have not supplied an API Access Key. [Required format: access_key=YOUR_ACCESS_KEY]" 
  - Esta nueva API trae muchas más divisas que la original (motivo principal para añadir la barra de búsqueda mencionada anteriormente).
- El indicador de carga inicial presenta un pequeño bug:
  - A veces aparece pero sólo cuando se ejecuta la app desde XCode.

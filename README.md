# Currency-Converter

Se han realizado los siguientes cambios:
  - Cambio de la API para obtener las divisas y las tasas de cambio debido a un error de la original 
    - "You have not supplied an API Access Key. [Required format: access_key=YOUR_ACCESS_KEY]"
Se han añadido las siguientes funciones no contempladas inicialmente:
  - Añadida barra de búsqueda para el filtrado después de realizar el cálculo.
Bugs detectados que no influyen en el funcionamiento de la app:
  - El indicador de carga inicial sólo aparece con la app en modo 'debug', en 'release' pasa demasiado rápido.
  - En la barra de búsqueda al pulsar la 'x' de borrar el texto el teclado vuelve a aparecer aunque se ha configurado para cerrarse.

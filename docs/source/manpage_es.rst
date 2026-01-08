..
    manpage_es.rst - Página manual para script kronolapse.

:orphan:

KRONOLAPSE
==========

SYNOPSIS
--------
**kronolapse** [*opciones*] [*Archivo CSV*]

DESCRIPCIÓN
-----------
**kronolapse** procesa una lista de archivos en formato de imágenes para
mostrar en un monitor, de acuerdo a un cronograma de horarios y lapsos
de tiempo determinados.

La lista con archivos y su cronograma de presentación, es leído desde un
archivo CSV con un arreglo de tres campos (o columnas), donde la primera
línea debe iniciar con un encabezado similar a:

::
    
    Documento imagen,Tiempo inicial,Tiempo final

En seguida, listar cada imagen con su ruta absoluta, el tiempo inicial y
tiempo final de la exhibición; los tiempos son ingresados en *formato
ISO 8601*, esto es, en formato `YYYY-mm-dd HH:mm:ss`. Aquí está un
ejemplo de un archivo de cronograma:

::

    Documento imagen,Tiempo inicial,Tiempo final
    /home/user/image-1.jpg,2025-12-01 09:00:00,2025-12-01 09:04:59
    /home/user/image-2.jpg,2025-12-01 09:05:00,2025-12-01 09:07:00

guardar el archivo CSV; por ejemplo, como `cronograma.csv`.

OPCIONES
--------
-h, --help
    Muestra este mensaje de ayuda y finaliza programa.

-V, --version
    Muestra el número de versión y finaliza programa.

-s, --show
    Solo muestra el archivo del cronograma.

RECOMENDACIONES
---------------
Los tiempos inicial y final del cronograma para cada archivos no deben
coincidir para evitar la superposición o solapamiento de dos imágenes
simultaneas.

EJEMPLOS
--------
Un ejemplo de uso:

::
    
    kronolapse ruta/a/cronograma.csv

Verificar y mostrar el cronograma:

::
    
    kronolapse -s ruta/a/cronograma.csv

ERRORES
-------
En sistemas operativos Linux, con monitores 4K usando escalado
fraccional (entorno de escritorio GNOME), la exhibición no se muestra en
pantalla completa.

LICENCIA
--------
Licencia GPLv3+:
GNU GPL versión 3 o posterior <https://www.gnu.org/licenses/gpl-3.0.html>.
Esto es software libre: usted puede redistribuirlo y/o
modificarlo. SIN NINGUNA garantía, ni siquiera COMERCIAL ni de
ADECUACIÓN PARA NINGÚN FIN PARTICULAR.

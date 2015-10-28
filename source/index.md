Introducción
============

[TOC]

    terminal, shell, command line
    (tab key)
    cp, mv, rm
    mkdir, cd, . .. *
    cat, head, tail, less, more
    sort, uniq, wc
    for, foreach
    cut
    grep
    awk
    sed
    perl

Procesamiento de textos
=======================

Ojear un fichero
----------------

    cat input.txt
    head input.txt
    head -2 input.txt
    tail input.txt
    less input.txt

Contaje de líneas
-----------------

    wc -l input.txt

Impresión de la segunda columna
-------------------------------

    awk '{print $2}' input.txt

Buscar una palabra
------------------

    grep "palabra" input.txt

Buscar un patrón
----------------

    grep -P "\bpalabra\b" input.txt

Cruzar input con fichero de patrones en una columna
---------------------------------------------------
(dos2unix patrones.txt puede ser necesario)

    grep -f patrones.txt input.txt

Eliminar las dos primeras columnas
----------------------------------

    cut -f 3- input.txt
    awk '{for (i=3; i<NF; i++) printf $i " "; print $NF}' input.txt

Agrupación de órdenes
=====================

Redirección
-----------

    cat input.txt > output.txt

Concatenación
-------------

    cat input.txt | wc -l

Manejo de ficheros en bloque
============================

Listar todos los ficheros con extensión .txt
--------------------------------------------

    ls *.txt
    for file in *.txt; do echo $file; done

Copiar todos los ficheros .txt cambiando su extensión a .tab
------------------------------------------------------------
    for file in *.txt; do cp $file ${file/.txt/.tab}; done

Cruzar dos ficheros encontrando variantes comunes
-------------------------------------------------
    for file in *.tab; do awk 'FS="\t"{print $27"\t"$28"\t"}' $file > $file.chrpos; done
    grep -f gatk.tab.chrpos life.tab > life.filtered.tab
    grep -f life.tab.chrpos gatk.tab > gatk.filtered.tab

Auto-evaluación
===============

Ejercicio 1
-----------

Tenemos un archivo con los posibles alelos para cada individuo, con líneas de esta forma:

    --- rs149529999 60479 C T 1 0 0 1 0 0 etc.

  - Primera columna es un identificador.
  - Segunda columna es un rs.
  - Tercera columna es una posición cromosómica.
  - Cuarta y quinta columnas son los alelos referencia y variante.
  - Cada grupo de tres números siguientes es la posibilidad de un individuo para ser homocigoto para el alelo de referencia, para el variante y ser heterocigoto respectivamente.

**Intentar**:

* Obtener sólo las cinco primeras columnas en pantalla.

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-solucion">Solución</a>
<div class="collapse" id="ex_11-pista_1"><div class="well">Se utiliza el comando <code>cut</code>. Las opciones se pueden comprobar con <code>man cut</code>.</div></div>
<div class="collapse" id="ex_11-pista_2"><div class="well">Las columnas están divididas con espacios. Cut define los campos con el flag <code>cut -d " "</code>.</div></div>
<div class="collapse" id="ex_11-solucion"><div class="well"><code>cut -d " " -f 1-5</code>.</div></div>

* Obtener de este fichero sólo las variantes SNP, descartando los indels.

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12_solucion">Solución</a>
<div class="collapse" id="ex_12-pista_1"><div class="well">Para comprobar el valor en cada columna se puede utilizar <code>awk</code></div></div>
<div class="collapse" id="ex_12-pista_2"><div class="well">Los indels pueden identificarse porque uno de los dos alelos es igual a <code>-</code></div></div>
<div class="collapse" id="ex_12_solucion"><div class="well"><code>awk '{if (($4) != "-" && ($5) != "-") print;}' Ejercicio_1.txt</code></div></div>

* Y si quisiésemos capturar los indels?

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_13_solucion">Solución</a>
<div class="collapse" id="ex_13_solucion"><div class="well"><code>awk '{if (($4) == "-" || ($5) == "-") print;}' Ejercicio_1.txt</code></div></div>

Ejercicio 2
-----------

Tenemos un archivo procedente de una anotación con Annovar, con líneas de esta forma:

    ljb23_all	0.01,0.99,D,0.321,B,0.09,B,0.000,1.0,D,1.000,1.000,D,0.205,0.499,N,-0.09,0.401,T,-0.865,0.284,T,0.153,T,5.98,2.837,20.437	1	218520000	218520000	G	C

- La primera columna indica la tabla de anotación.
- La segunda columna son las anotaciones separadas por comas.
- Las siguientes cinco columnas son la posición de la variante.

**Intentar**:

* Transformar las comas de la segunda columna en tabulados, para que un programa como Excel pueda leer mejor el archivo.

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_21-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_21-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_21-solucion">Solución</a>
<div class="collapse" id="ex_21-pista_1"><div class="well">El comando más recomendable es <code>sed</code>.</div></div>
<div class="collapse" id="ex_21-pista_2"><div class="well">El carácter especial TABULADOR se marca como <code>\t</code>.</div></div>
<div class="collapse" id="ex_21-solucion"><div class="well"><code>sed 's/,/\t/g' Ejercicio_2.txt</code></div></div>

* Ordenar el archivo de mayor a menor score en la columna 7 de anotaciones.

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_22-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_22-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_22-solucion">Solución</a>
<div class="collapse" id="ex_22-pista_1"><div class="well">El comando más recomendable es <code>sort</code>.</div></div>
<div class="collapse" id="ex_22-pista_2"><div class="well">Para especificar un campo se indica <code>-kX</code>, siendo X el número del campo.</div></div>
<div class="collapse" id="ex_22-solucion"><div class="well"><code>sort -k7,7n Ejercicio_2.txt</code></div></div>

* Los dos pasos anteriores a la vez!

Y guardar los resultados en un archivo "Resultados.tab"

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_23-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_23-solucion">Solución</a>
<div class="collapse" id="ex_23-pista_1"><div class="well">La salida de un comando se redirige al siguiente con <code>|</code>.</div></div>
<div class="collapse" id="ex_23-solucion"><div class="well"><code>sed 's/,/\t/g' Ejercicio_2.txt | sort -k7,7n > Resultados.tab</code></div></div>

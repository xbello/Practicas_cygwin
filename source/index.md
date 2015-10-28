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

Intentar:

1. Obtener sólo las cinco primeras columnas en pantalla.

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-solucion">Solución</a>
<div class="collapse" id="ex_11-pista_1"><div class="well">Se utiliza el comando <code>cut</code>. Las opciones se pueden comprobar con <code>man cut</code>.</div></div>
<div class="collapse" id="ex_11-pista_2"><div class="well">Las columnas están divididas con espacios. Cut define los campos con el flag <code>cut -d " "</code>.</div></div>
<div class="collapse" id="ex_11-solucion"><div class="well"><code>cut -d " " -f 1-5</code>.</div></div>

2. Obtener de este fichero sólo las variantes SNP, descartando los indels.

<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12_solucion">Solución</a>
<div class="collapse" id="ex_12-pista_1"><div class="well">Para comprobar el valor en cada columna se puede utilizar <code>awk</code></div></div>
<div class="collapse" id="ex_12-pista_2"><div class="well">Los indels pueden identificarse porque uno de los dos alelos es igual a <code>-</code></div></div>
<div class="collapse" id="ex_12_solucion"><div class="well"><code>awk '{if (($4) == "-" || ($5) == "-") print;}' Ejercicio_1.txt</code></div></div>


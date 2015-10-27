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
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

Antes de nada...
================

Los de Windows
--------------

Cygwin instalado.

Abrir un terminal.

    cd /cygdrive/c/
	mkdir datafordummies
	cd datafordummies

Copiar el contenido de la carpeta 'data' del archivo comprimido del curso a esta nueva carpeta C:\datafordummies

Los de Mac/Linux
----------------

Abrir un terminal.

    cd Desktop
	mkdir datafordummies
	cd datafordummies

Copiar el contenido de la carpeta 'data' del archivo comprimido del curso a esta nueva carpeta ~/Desktop/datafordummies

Procesamiento de textos
=======================

Ojear un fichero
----------------

    cat input1.txt
    head input1.txt
    head -n2 input1.txt
    tail input1.txt
    tail -n10 input1.txt
    less input1.txt

Repetición de último comando
----------------------------

    !head

Contaje de líneas
-----------------

    wc -l input1.txt

Impresión de la segunda columna
-------------------------------

    awk '{print $2}' input1.txt
    cut -f2 input1.txt

E.g. ver la lista de genes del archivo `input2.txt`, que están en la columna 7:

    awk '{print $7}' input2.txt
    cut -f7 input2.txt

Buscar una palabra
------------------

    grep "palabra" input1.txt

E.g. buscar la palabra GGA en el archivo input1.txt:

    grep "GGA" input1.txt

E.g. ver todas las variantes del gen CFTR del archivo input2.txt:

    grep "CFTR" input2.txt

E.g. ver todas las variantes del gen PKD1 del archivo input2.txt:

    grep "PKD1" input2.txt

Buscar un patrón
----------------

    grep -P "patrón" input1.txt

E.g. ver todas las variantes del cromosoma 1, pero no del cromosoma 1?, en el archivo input1.txt

<div class="alert alert-danger" role="alert">Con este comando obtendremos las líneas que contengan un carácter '1' (no es lo que buscamos).<br />
<pre><code>grep -P '1' input1.txt</code></pre>
</div>

<div class="alert alert-danger" role="alert">Con este comando obtendremos las líneas que empiecen por un carácter '1' (casi es lo que buscamos).<br />
<pre><code>grep -P '^1' input1.txt</code></pre>
</div>

<div class="alert alert-success" role="alert">Con este comando obtendremos las líneas que empiecen por un carácter '1' y una tabulación (ésta es la forma correcta).<br />
<pre><code>grep -P '^1\t' input1.txt</code></pre>
</div>

E.g. ver todas las variantes del gen PKD1 del archivo input2.txt:

    grep -P "\bPKD1\b" input2.txt

http://www.regular-expressions.info/

Cruzar input con fichero de patrones en una columna
---------------------------------------------------
(dos2unix genes.txt puede ser necesario)

    grep -f genes.txt input2.txt

Eliminar las tres primeras columnas
-----------------------------------

    cut -f 4- input1.txt
    cut -f1-3 --complement input1.txt
    awk '{for (i=4; i<NF; i++) printf $i "\t"; print $NF}' input1.txt

<div class="alert alert-info" role="alert">

<ul>
 <li>OFS es una palabra especial (<em>builtin variable</em>) de AWK, significa "Output Field Separator".</li>
 <li>NF es una palabra especial (<em>builtin variable</em>) de AWK, significa "Number of Fields".</li>
 <li><a href="http://www.chemie.fu-berlin.de/chemnet/use/info/gawk/gawk_11.html" target="_new">Lista de builtins AWK<span class="glyphicon glyphicon-link"></span></a></li>
</ul>

</div>

Agrupación de órdenes
=====================

Redirección
-----------

    cat input1.txt > output1.txt
    cat input1.txt input2.txt > output1and2.txt

Concatenación
-------------

    cat input1.txt | wc -l
    cat output1.txt | wc -l
    cat output1and2.txt | wc -l

Concatenación múltiple
----------------------

    cat input1.txt | grep TTT | sort -V | cut -f 1-3

Manejo de ficheros en bloque
============================

Listar todos los ficheros con extensión .txt
--------------------------------------------

    ls *.txt
    for file in *.txt; do echo $file; done

Copiar todos los ficheros .txt cambiando su extensión a .tab
------------------------------------------------------------

    for file in *.txt; do cp $file ${file/.txt/.tab}; done

Eliminar todos los ficheros de extensión .tab
---------------------------------------------

    rm *.tab

Ejemplo práctico 1: Detección de variantes comunes
==================================================

Extracción y búsqueda en pasos separados
----------------------------------------

    cut -f 1-5 annotation.GATK.txt > variantes.GATK.txt
    grep -f variantes.GATK.txt annotation.LIFE.txt > variantes.compartidas.txt

Extracción y búsqueda combinadas
--------------------------------

	grep -f <(cut -f 1-5 annotation.LIFE.txt) annotation.GATK.txt > variantes.compartidas.2.txt

Ejemplo práctico 2: Filtrar variantes con un listado de genes
=============================================================

Búsqueda de 1 gen
-----------------
(el carácter '\y' en awk equivale a '\b' en la mayoría de programas)

    awk '$7 ~ /\yPKD1\y/' input2.txt

Lectura de un fichero línea a línea
-----------------------------------

    while read -r line; do
    echo "Texto encontrado: $line"
    done < genes.txt

Búsqueda de varios genes
------------------------

    while read -r line; do
    awk -v gen="\\\\y$line\\\\y" '$7 ~ gen' input2.txt
    done < genes.txt

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

<div class="btn-group" role="group">
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_11-solucion">Solución</a>
</div>
<div class="collapse" id="ex_11-pista_1"><div class="well">Se utiliza el comando <code>cut</code>. Las opciones se pueden comprobar con <code>man cut</code>.</div></div>
<div class="collapse" id="ex_11-pista_2"><div class="well">Las columnas están divididas con espacios. Cut define los campos con el flag <code>cut -d " "</code>.</div></div>
<div class="collapse" id="ex_11-solucion"><div class="well"><code>cut -d " " -f 1-5 Ejercicio_1.txt</code></div></div>

* De este listado de 5 columnas, obtener sólo las variantes SNP, descartando los indels.

<div class="btn-group" role="group">
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_12_solucion">Solución</a>
</div>
<div class="collapse" id="ex_12-pista_1"><div class="well">Para comprobar el valor en cada columna se puede utilizar <code>awk</code></div></div>
<div class="collapse" id="ex_12-pista_2"><div class="well">Los indels pueden identificarse porque uno de los dos alelos es igual a <code>-</code></div></div>
<div class="collapse" id="ex_12_solucion"><div class="well"><code>cut -d " " -f 1-5 Ejercicio_1.txt | awk '{if ($4 != "-" && $5 != "-") print }'</code></div></div>

* Y si quisiésemos capturar sólo los indels?

<div class="btn-group" role="group">
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_13_solucion">Solución</a>
</div>
<div class="collapse" id="ex_13_solucion"><div class="well"><code>cut -d " " -f 1-5 Ejercicio_1.txt | awk '{if ($4 == "-" || $5 == "-") print }'</code></div></div>

* Y si quisiésemos capturar los SNPs con una búsqueda de patrón?

<div class="btn-group" role="group">
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_14_solucion">Solución</a>
</div>
<div class="collapse" id="ex_14_solucion"><div class="well"><code>cut -d " " -f 1-5 Ejercicio_1.txt | grep -v " -"</code></div></div>

Ejercicio 2
-----------

Tenemos un archivo procedente de una anotación con Annovar, con líneas de esta forma:

    ljb23_all	0.01,0.99,D,0.321,B,0.09,B,0.000,1.0,D,1.000,1.000,D,0.205,0.499,N,-0.09,0.401,T,-0.865,0.284,T,0.153,T,5.98,2.837,20.437	1	218520000	218520000	G	C

- La primera columna indica la tabla de anotación.
- La segunda columna son las anotaciones separadas por comas.
- Las siguientes cinco columnas son la posición de la variante (cromosoma, inicio, fin, referencia, variante).

**Intentar**:

* Transformar las comas de la segunda columna en tabulados, para que un programa como Excel pueda leer mejor el archivo.

<div class="btn-group" role="group">
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_21-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_21-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_21-solucion">Solución</a>
</div>
<div class="collapse" id="ex_21-pista_1"><div class="well">El comando más recomendable es <code>sed</code>.</div></div>
<div class="collapse" id="ex_21-pista_2"><div class="well">El carácter especial TABULADOR se marca como <code>\t</code>.</div></div>
<div class="collapse" id="ex_21-solucion"><div class="well"><code>sed 's/,/\t/g' Ejercicio_2.txt</code></div></div>

* Ordenar el archivo por cromosoma.

<div class="btn-group" role="group">
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_22-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_22-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_22-pista_3">Pista 3</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_22-solucion">Solución</a>
</div>
<div class="collapse" id="ex_22-pista_1"><div class="well">El comando más recomendable es <code>sort</code>.</div></div>
<div class="collapse" id="ex_22-pista_2"><div class="well">Para especificar un campo se indica <code>-kX</code>, siendo X el número del campo.</div></div>
<div class="collapse" id="ex_22-pista_3"><div class="well">Para ordenar un campo numéricamente se indica <code>-kXn</code>, siendo X el número del campo.</div></div>
<div class="collapse" id="ex_22-solucion"><div class="well"><code>sort -k3,3n Ejercicio_2.txt</code></div></div>

* Los dos pasos anteriores a la vez!

Y guardar los resultados en un archivo "Resultados.tab"

<div class="btn-group" role="group">
<a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_23-pista_1">Pista 1</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_23-pista_2">Pista 2</a><a class="btn btn-primary" role="button" data-toggle="collapse" href="#ex_23-solucion">Solución</a>
</div>
<div class="collapse" id="ex_23-pista_1"><div class="well">La salida de un comando se redirige al siguiente con <code>|</code>.</div></div>
<div class="collapse" id="ex_23-pista_2"><div class="well">La salida de un comando se guarda en un fichero con <code>&gt;</code>.</div></div>
<div class="collapse" id="ex_23-solucion"><div class="well"><code>sed 's/,/\t/g' Ejercicio_2.txt | sort -k29n > Resultados.tab</code></div></div>

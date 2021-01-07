#!/bin/bash

Cuentalineas (){
	exec 10<&0
	exec < $1
	in=$1

	file="current_line.txt"
	let count=0

	while read LINE
	do 
	    ((count++))
	    echo $LINE > $file
	    if [ $? -ne 0 ] 
	     then echo "Error al escribir en el archivo ${file}; revisa tus permisos!"
	    fi
	done

	echo "Numero de lineas: $count"
	echo "La ultima linea del archivo es: `cat ${file}`"

	echo "Numero aprox de lineas: `wc -l $in`"

	exec 0<&10 10<&-
]
Cuentalineas

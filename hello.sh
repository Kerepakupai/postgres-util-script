#!/bin/bash
number=0

echo "white loop"
while [[ $number -lt 10 ]] ; do
    echo $number
    number=$(( number + 1 ))
done

echo "for loop"
for i in 1 2 3 4 5 ; do
    echo $i
done

echo "for loop with range"
for x in {1..10} ; do
    echo $x 
done

for s in "hola" "mundo" "desde" "bash" ; do
    echo $s
done

for arg in $@ ; do
    echo $arg
done

ubicacion=`pwd`
kernel=$(uname -a)

echo "Ubicacion: $ubicacion"
echo "Kernel: $kernel"

identificacionRegex="^[0-9]{10}$"
paisRegex='^EC|COL|US$'
fechaRegex='^19|20[0-8]{2}[1-12][1-31]$'

echo "Expresiones Regulares"
read -p "Identificacion:" identificacion
read -p "Pais:" pais
read -p "Fecha:" fecha

if [[ $identificacion =~ $identificacionRegex ]] ; then
    echo "Identificacion $identificacion valida"
else
    echo "Identificacion $identificacion invalida"
fi

if [[ $pais =~ $paisRegex ]] ; then
    echo "pais $pais valido"
else
    echo "pais $pais invalido"
fi

if [[ $fecha =~ $fechaRegex ]] ; then
    echo "fecha $fecha valida"
else
    echo "fecha $fecha invalida"
fi

opcion=0
backupName=""
clave=""

read -n1 -p "Ingrese la opcion:" opcion
echo -e "\n"
read -n10 -p "Ingresar nombre:" backupName
echo -e "\n"
read -s -p "Clave:" clave
echo -e "\n"
echo "$clave"

echo "Opciones"
echo "Opcion 1 enviada: $1"
echo "Opcion 2 enviada: $2"
echo "Opciones enviadas: $*"
echo -e "\n"
echo "Recuperar valores"
while [ -n "$1" ] ; do
    case "$1" in
        -a) echo "ingresaste -a";;
        -b) echo "ingresaste -b";;
        -c) echo "ingresaste -c";;
        *) echo "$! no es una opcion";;
    esac
    shift
done 
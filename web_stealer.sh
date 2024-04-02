#!/bin/bash

# Para utilizarlo se debe hacer lo siguiente "./web_stealer.sh lista_ip.txt wordlist_para_grepear.txt 60 (tiempo en segundos que va a repetir esta operación)"

# Verifica que se proporcionen los parámetros necesarios
if [ $# -lt 3 ]; then
    echo "Uso: $0 <archivo_urls_ips> <archivo_palabras> <tiempo_sleep>"
    exit 1
fi

# Lee los archivos de entrada
url_ip_file="$1"
word_list_file="$2"
sleep_time="$3"

# Verifica que los archivos existan
if [ ! -f "$url_ip_file" ] || [ ! -f "$word_list_file" ]; then
    echo "Error: Archivos de entrada no encontrados."
    exit 1
fi

# Verifica que el tiempo de espera sea un número
if ! [[ $sleep_time =~ ^[0-9]+$ ]]; then
    echo "Error: El tiempo de espera debe ser un número entero."
    exit 1
fi

# Lee las URL/IPs desde el archivo de entrada
urls_ips=($(cat "$url_ip_file"))

# Lee las palabras desde el archivo de entrada y las separa por comas
words=$(cat "$word_list_file" | tr '\n' ',' | sed 's/,$//')

while true; do
  clear
  # Decoración con "*"
  echo "*************************************************"
  echo "* Palabras a buscar:"
  echo "* $words"
  echo "*************************************************"
  echo "* Lista de objetivos:"

# Realiza el bucle sobre cada URL/IP
for url_ip in "${urls_ips[@]}"; do
    # Construye la URL final
    final_url="${url_ip}"

    # Obtén el nombre del archivo de salida
    ip_puerto="$(echo "${url_ip}" | cut -d'/' -f3)"

    # Realiza la solicitud con curl y filtra con grep para cada palabra
    # curl -k -s "$final_url" | grep $word >> "${ip_puerto}"
    curl_url= $(curl -k -s "$final_url" >> "${ip_puerto}_temp.txt")

    # Itera sobre la word_list
    for word in $(cat "$word_list_file"); do
        cat "${ip_puerto}_temp.txt" | grep -e $word >> "${ip_puerto}_info_stealer.txt"
    done
    rm "${ip_puerto}_temp.txt"
    # Ordena y elimina duplicados en el archivo de info_stealer_output
    sort -u -o "${ip_puerto}_info_stealer.txt" "${ip_puerto}_info_stealer.txt"

    # Muestra el número de líneas en el archivo generado
    num_lines=$(wc -l < "${ip_puerto}_info_stealer.txt")
    echo "* $final_url - lineas: $num_lines"
done
  # Muestra el contenido del archivo temporal con decoración
  echo "*************************************************"
  # Espera el tiempo especificado antes de repetir el bucle
  sleep "$sleep_time"
done
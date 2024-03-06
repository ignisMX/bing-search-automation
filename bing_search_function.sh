#!/bin/bash

# Función para obtener una línea aleatoria de un archivo
function get_random_line() {
    local file="$1"
    local line_count=$(wc -l <"$file")
    local random_line=$((RANDOM % $line_count + 1))
    head -n "$random_line" "$file" | tail -n 1
}

#Funcion para abrir una nueva ventana de brave
function open_new_brave_window() {
    brave
}

# Función para abrir una nueva pestaña en Brave con la página de Bing
function open_brave_search() {
    brave --new-tab "https://www.bing.com/"
}

# Función para buscar el campo de búsqueda en Bing
function find_search_box() {
    # Simular pulsaciones de teclas para enfocarse en la barra de búsqueda
    #xdotool key ctrl+l

    # Esperar a que la página se cargue
    sleep 1

    # Buscar el campo de búsqueda por su ID
    xdotool search --onlyvisible --class "sb_form_q"
}

# Función para copiar y pegar una cadena de texto en el campo de búsqueda de Bing
function paste_into_bing_search() {
    # Simular pulsaciones de teclas para copiar y pegar
    #xdotool key ctrl+c
    xdotool key ctrl+v

    # Esperar un poco para que el contenido se pegue
    sleep 3

    # Pulsar Enter para realizar la búsqueda
    xdotool key Return
}

# Leer el archivo de texto con las búsquedas
file_name="busquedas.txt"

# Obtener 30 líneas aleatorias del archivo
lines_to_search=()
for i in $(seq 1 35); do
    lines_to_search+=("$(get_random_line "$file_name")")
done

open_new_brave_window
# Recorrer las líneas y realizar las búsquedas
for line in "${lines_to_search[@]}"; do
    open_brave_search
    sleep 1
    find_search_box
    # Envia la linea al portapapeles para que pueda ser pegada
    echo -n $line | xclip -selection clipboard
    paste_into_bing_search
    sleep 10
done

echo "**Todas las búsquedas se han completado**"

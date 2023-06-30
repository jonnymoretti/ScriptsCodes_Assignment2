#!/bin/bash

input_folder="$1"
output_folder="$2"
reads="$3"  # Substitua pelo número desejado de linhas a serem lidas

# Verificar se o diretório de saída existe, caso contrário, criar
if [ ! -d "$output_folder" ]; then
  mkdir -p "$output_folder"
fi

# Iterar sobre os arquivos .fastq na pasta de entrada
for file_path in "$input_folder"/*.fastq; do
  # Verificar se o arquivo é válido
  if [ -f "$file_path" ]; then
    # Obter o nome do arquivo sem a extensão
    file_name=$(basename "$file_path")
    file_name="${file_name%.*}"

    # Gerar o nome do arquivo de saída
    output_file="${output_folder}/${file_name}_cut.fastq"

    # Usar o comando head para truncar o arquivo
    head -n "$reads" "$file_path" > "$output_file"

    echo "Arquivo truncado: $output_file"
  fi
done

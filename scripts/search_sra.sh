#!/bin/bash

# Lista de IDs SRR
srr_ids=("SRRXXXXX")

# Iterar sobre cada ID SRR
for srr_id in "${srr_ids[@]}"; do
  # Construir o comando fasterq-dump com o ID SRR atual
  command="fasterq-dump \"$srr_id\" --split-spot --skip-technical -p"

  # Executar o comando
  eval "$command"
done


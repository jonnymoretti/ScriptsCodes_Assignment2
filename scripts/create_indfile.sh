#!/bin/bash

# Arrays com os dados das populações e espécies
populations=("Hybrids" "Q_parvula" "Qpv_tamalpaisensis" "Q_wislizeni" "Q_agrifolia" "Q_kelloggii")
species_orders=("1" "2" "3" "4" "5" "6")

# Verificar se os arrays têm o mesmo comprimento
if [ ${#populations[@]} -ne ${#species_orders[@]} ]; then
    echo "Os arrays têm tamanhos diferentes!"
    exit 1
fi

# Loop para criar as linhas do arquivo
for ((i=0; i<${#populations[@]}; i++)); do
    population="${populations[i]}"
    species_order="${species_orders[i]}"
    
    # Obter amostras para a população atual
    case $population in
        "Hybrids")
            samples=("SRR8993001_cut" "SRR8993002_cut" "SRR8993003_cut")
            ;;
        "Q_parvula")
            samples=("SRR5632503_cut" "SRR8860646_cut" "SRR8860729_cut" "SRR8860730_cut" "SRR8860731_cut" "SRR8860732_cut")
            ;;
        "Qpv_tamalpaisensis")
            samples=("SRR8860647_cut" "SRR8860648_cut" "SRR8860649_cut")
            ;;
        "Q_wislizeni")
            samples=("SRR5632497_cut" "SRR5632519_cut" "SRR8860522_cut" "SRR8860560_cut" "SRR8860561_cut" "SRR8860600_cut" "SRR8860602_cut" "SRR8860733_cut" "SRR8860734_cut" "SRR8860735_cut" "SRR8860736_cut" "SRR8860737_cut" "SRR8860738_cut" "SRR8993000_cut")
            ;;
        "Q_agrifolia")
            samples=("SRR5632374_cut" "SRR5632565_cut" "SRR8860507_cut" "SRR8860508_cut" "SRR8860509_cut" "SRR8860510_cut" "SRR8860519_cut" "SRR8860741_cut" "SRR8860747_cut" "SRR8860748_cut" "SRR8860752_cut" "SRR8860753_cut" "SRR8860754_cut" "SRR8860755_cut" "SRR8860756_cut" "SRR8860757_cut")
            ;;
        "Q_kelloggii")
            samples=("SRR5632568_cut" "SRR5632626_cut" "SRR8860513_cut" "SRR8860514_cut" "SRR8860523_cut" "SRR8860524_cut" "SRR8860532_cut" "SRR8860533_cut" "SRR8860534_cut" "SRR8860535_cut" "SRR8860536_cut" "SRR8860537_cut" "SRR8860538_cut")
            ;;
        *)
            echo "População desconhecida: $population"
            exit 1
            ;;
    esac
    
    # Loop para criar as linhas para cada amostra
    for sample in "${samples[@]}"; do
        printf "%-11s %-11s %-1s\n" "$sample" "$population" "$species_order"
    done
done > simdata.indfile


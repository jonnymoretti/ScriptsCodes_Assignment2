# SRA Tutorial
This code was developed with the intention to automate the download of the SRA files from their Bioproject

```
#Command to create the environment in which we will use sra-tools
conda create -n sra
#Activate the environment previously created
conda activate sra
#Install sra-tools on the new environment
conda install sra-tools
#Create a directory to store your SRA files
mdkir sra_seqs
#Select the directory you will be working in 
cd sra_seqs
#Download the code to automate the download process
wget https://github.com/jonnymoretti/ScriptsCodes_Assignment2/blob/main/scripts/search_sra.sh
#Execute the automation code
./bash search_sra.sh
```

Reminder: Don't forget the SRA must be manually introduced into search_sra.sh!

### Tutorial on how to trim you SRA files
This code was developed with the intention to trim the number of reads on SRA files

```
#Download the code to trim your files
wget https://github.com/jonnymoretti/ScriptsCodes_Assignment2/blob/main/scripts/corte.sh
#Execute the code you just downloaded
./corte.sh input_folder output_folder number_reads_to_cut
```


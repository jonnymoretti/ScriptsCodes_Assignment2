# STRUCTURE Tutorial
In this lesson, you will learn how to create admixture plots using an SNP dataset generated using ipyrad (well, not just ipyrad, but rather any VCF file). For this I will provide the VCF files and a script to create the indfile.

### Intalling the Structure_threader
Before we can perform the tutorial we need to install the software that will allow us to create the Admixture plot.

```
conda config --add channels conda-forge

# Obtain all necessary dependencies and create a new environment.
conda create -n structure python=3.9 r r-rcolorbrewer bioconductor-snprelate bioconductor-lfa r-devtools -c bioconda

# Get the new environment going
conda activate structure

# We use pip, the package manager for Python, to install Structure_threader as there isn't a conda package for it
python3 -m pip install structure_threader
```
### Getting the data
We should create a new directory for this tutorial, to make the files more organized. And I provide the necessary files for this tutorial.

```
mkdir ~/str_analyses
cd ~/str_analyses
wget https://github.com/jonnymoretti/ScriptsCodes_Assignment2/blob/main/Files/simdata.vcf.gz
wget https://github.com/jonnymoretti/ScriptsCodes_Assignment2/blob/main/scripts/create_indfile.sh
```

### Dealing with Linkage Disequilibrium
Linkage disequilibrium (LD), which can occur while analyzing RAD-Seq data, can be a concern. Use of a single SNP from each locus can help to reduce the impact of this. We will need still another script to accomplish that, vcv_parser.py, which is located <a target="_blank" href="https://github.com/CoBiG2/RAD_Tools">in this github repository</a>.

```
wget https://raw.githubusercontent.com/CoBiG2/RAD_Tools/6648d1ce1bc1e4c2d2e4256abdefdf53dc079b8c/vcf_parser.py
python3 vcf_parser.py --center-snp -vcf simdata.vcf
```
### The indfile
Your indfile has to look like this. In which the first column is the species name. The second column is the name of the population of the species. And the third column is the position of the population on the <em>Admixture</em> plot.

```
SRR8993001_cut Hybrids     1
SRR8993002_cut Hybrids     1
SRR8993003_cut Hybrids     1
SRR5632503_cut Q_parvula   2
SRR8860646_cut Q_parvula   2
SRR8860729_cut Q_parvula   2
SRR8860730_cut Q_parvula   2
SRR8860731_cut Q_parvula   2
SRR8860732_cut Q_parvula   2
```
### Choosing the K's
Before we build the graph, it is necessary to know what is the optimal number of <em>clusters</em> (K) for the construction of the graph. To do this, we will perform <em>fastStructure</em>. It is necessary to have the files simdata.str and indfile for this <em>software</em>. However, I sent the file simdata.str.

```
wget https://github.com/jonnymoretti/ScriptsCodes_Assignment2/blob/main/Files/simdata.str
structure_threader run -i simdata.str -fs ~/miniconda3/envs/structure/bin/fastStructure -K 6 -o ./simdata_results -t 3 --ind simdata.indfile
```
### Build the Admixture plot
In this phase, we will construct the graph in accordance with the number of Ks with the aid of the files simdataCenterSNP.vcf and simdata.indfile.

```
structure_threader run -i simdataCenterSNP.vcf -o ./results_simdataCenterSNP -als ~/miniconda3/envs/structure/bin/alstructure_wrapper.R -K 10 -t 3 --ind simdata.indfile
```


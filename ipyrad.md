# Ipyrad Tutorial

In this tutorial we will obtain the STRUCTURE, PHYLIP, NEXUS, VCF and geno files that we will use throughout the work. For this, we will use ipyrad.

```
# Include the Conda-Forge channel
conda config --add channels conda-forge

# Conda should be updated
conda update conda

# Try mamba 
conda install mamba

# Make a new conda environment active
conda create -n ipyrad
conda activate ipyrad

# Install ipyrad
mamba install ipyrad numpy=1.19 -c bioconda
```
### Get the data
In this step it is recommended that you create a directory to carry out the tutorial, because this way the files that will be obtained will be stored in one place and this way you can have a greater organization of the files, I also provide my params-simdata.txt file that will be used in this tutorial.

```
# Make a directory
mkdir ipyrad-assembly
ipyrad-assembly

# Get de simdata.txt
wget https://github.com/jonnymoretti/ScriptsCodes_Assignment2/blob/main/Files/params-simdata.txt
```
### Step 2 - Filter reads
Based on quality ratings and the maximum number of uncalled bases, this step filters readings.

```
ipyrad -p params-simdata.txt -s 2 -c 3
```
### Step 3 - Clustering within-sample
In Step 3, readings within each sample are first de-replicated, followed by a clustering threshold that is determined, and the clusters are then written to new files in a directory.

```
ipyrad -p params-simdata.txt -s 3 -c 3
```
### Step 4 - Joint estimation of heterozygosity and error rate

```
ipyrad -p params-simdata.txt -s 4 -c 3
```
### Step 5 - Consensus base calls
```
ipyrad -p params-simdata.txt -s 5 -c 3
```
### Step 6 - Cluster across samples
```
ipyrad -p params-simdata.txt -s 6 -c 3
```
### Step 7 - Filter and write output files
```
ipyrad -p params-simdata.txt -s 7 -c 3
```
### Rerunning step 7 to include all output formats
Let's execute step 7 and generate all supported output formats since we won't simply need the default ones for our downstream analysis. This can be done by altering the **params-simdata.txt** and setting the requested **output_formats** to *. Like in example below

```
*         ## [27] [output_formats]: Output formats (see docs)
```
```
# We use the -f to force overwriting
ipyrad -p params-simdata.txt -s 7 -c 3 -f
```
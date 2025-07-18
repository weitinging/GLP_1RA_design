# GLP_1RA_design
[![Paper](https://img.shields.io/badge/paper-biorxiv.2025.03.26.645438-F0A145)](https://www.biorxiv.org/content/10.1101/2025.03.26.645438v1)



Accompanied in silico analysis codebase for paper [AI-driven efficient *de novo* design of GLP-1RAs with extended half-life and enhanced efficacy](https://www.biorxiv.org/content/10.1101/2025.03.26.645438v1). 



## Description

We conducted an *in silico* pipeline for the design of GLP-1RAs. The codebase is organized as follows:

* `./pipeline` includes the filtering procedures using structure and sequence-based *in silico* metrics like motif-RMSD, pLDDT, etc.
* {TO BE WRITTEN}



## Documentation

### Step 1: Conserved Sites Identification and Sequence Design

We first defined the conserved sites of GLP-1RAs, whose amino acid types were later fixed during the design using [ProteinMPNN](https://github.com/dauparas/ProteinMPNN.git). We then used [AlphaFold2](https://github.com/google-deepmind/alphafold) to predict those structures used for further screening. 

Our filtering pipeline could also be extended to hold arbitrary sequence designer and structure predictors beyond ProteinMPNN and AF2 in general.

### Step 2: Functional Screening

<details>
    <summary>Expand</summary>

Herein we conduct functional screnning based on various *in silico* metrics of which the usage would be shown within the following steps.

#### Installation

You can set up a conda environment used for the functional screnning by:

``````shell
git clone https://github.com/Immortals-33/GLP_1RA_design.git
cd GLP_1RA_design
conda env create -f envs/env.yaml
source activate glp_1ra_design
``````

#### Motif-RMSD and pLDDT

When calculating the motif-RMSD using the [script](https://github.com/Immortals-33/GLP_1RA_design/blob/main/pipeline/motif_rmsd.py) you should prepare the following information:

* `DESIGN_PATH` is the path storing your designed PDBs. Suppose you have $N$ designed proteins, you should assign an ID for each design like `{protein_name}_1,`, `{protein_name}_2`, ..., `{protein_name}_$N$` with the name of protein and the ID separated by `_` .  
* `REFERENCE_PDB` is the reference protein you used to calcualte the motif-RMSD with. 
* `DESIGN_MOTIF` is a `.txt` file containing the corresponding motifs to be calculated. Each protein takes a line, where the **ID ** and motif number is separated by a **tab character** by default.
* `REFERENCE_MOTIF` is the `.txt` file containing the information of reference motif following the logic aforementioned. 

By then you can use the script to filter the designed proteins. For example, the following command aims to filter the proteins whose pLDDT > 80 and motif-RMSD compared with the native ones < 1.0 Å:

```
python motif_rmsd.py \
       -d DESIGN_PATH \
       -r REFERENCE_PDB \
       --motif-d DESIGN_MOTIF \
       --motif-r REFERENCE_MOTIF \
       --rmsd 1.0 \
       --plddt 80
```

#### SAP (Spatial Aggregation Propensity)  

Since calculating SAP depends on [PyRosetta](https://www.pyrosetta.org/), we recommend using a separate conda environment:

```
conda env create -f envs/pyrosetta.yml
source activate PyRosetta
```

You can then use the following command and [script](https://github.com/Immortals-33/GLP_1RA_design/blob/main/pipeline/sap.py) to filter designed proteins either based on the comparison with reference PDB or a specific value:

```
# This will keep the designed proteins with SAP scores lower than the native
python sap.py \
       -d DESIGN_PATH
       -r REFERENCE_PDB
       
# This will keep the designed proteins with SAP scores < 20
python sap.py \
       -d DESIGN_PATH
       --sap 20.0
```

</details>

### Step 3: {TO BE WRITTEN}





***

## Contact

* {TO BE WRITTEN}



***

## Citation

If you have used the code in your research, please cite:

```bibtex
@article{wei2025ai-driven,
title = {AI-Driven Efficient De Novo design of GLP-1RAs with Extended Half-Life and Enhanced Efficacy},
author = {Ting, Wei and Xiaochen, Cui and Jiahui,Lin and Zhuoqi,Zheng and Taiying, Cui and Liu, Cheng and Xiaoqian, Lin and Junjie, Zhu and Xuyang,Ran and Xiaokun,Hong and Zhangsheng, Yu and Haifeng, Chen},
year = {2025},
journal = {bioRxiv},
url = {https://www.biorxiv.org/content/10.1101/2025.03.26.645438v1}
}
```





***

## Acknowledgements


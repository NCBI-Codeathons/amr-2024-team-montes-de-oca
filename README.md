# Team Montes de Oca

List of participants and affiliations:
- Marco Montes de Oca
- Weilong Hao
- Genelle Jenkins
- Jake Lance
- Mackenzie Wilke
- Joe Wirth
- Axl Cepeda

## Project Goals
This project aims to investigate the relationship between insertion sequences and antibiotic resistance phenotypes by analyzing draft and complete genomes. The goal is to identify patterns in insertion sequence distribution among susceptible and resistant isolates and visualize the findings.
## Approach
The approach involves comparing coding sequences from each isolate against databases using [BLAST](https://blast.ncbi.nlm.nih.gov/Blast.cgi). These databases may include [The Comprehensive Antibiotic Resistance Database](https://card.mcmaster.ca/), to identify genes associated with antibiotic resistance, as well as [IS Finder](https://isfinder.biotoul.fr/#), to identify insertion sequences. Once the insertion sequences and resistance genes are identified, the team will compare the insertion sequence profile between resistant and susceptible [isolates](https://github.com/NCBI-Codeathons/amr-2024-team-montes-de-oca/blob/main/Assemblies_Team_Montes_de_Oca.xlsx). A code to start finding these elements is [here](https://github.com/NCBI-Codeathons/amr-2024-team-montes-de-oca/blob/main/Notebook.ipynb).
The output tables obtained from the script have the following format:

#### Output from approach n°1
A table file including the following columns:
* qseqid: query sequence id, usually the contig name from a given draft genoma
* sseqid: subject sequence id, the antibiotic resistance gene sequence name
* pident: identity percentage
* ppos: similarity percentage
* len: BLAST alignment length
* qstart: query sequence start position
* qend: query sequence end position
* sstart: subject sequence start position
* send: subject sequence end position
* evalue: BLAST alignment evalue
* scov: subject coverage percentage
## Results

## Future Work

## NCBI Codeathon Disclaimer
This software was created as part of an NCBI codeathon, a hackathon-style event focused on rapid innovation. While we encourage you to explore and adapt this code, please be aware that NCBI does not provide ongoing support for it.

For general questions about NCBI software and tools, please visit: [NCBI Contact Page](https://www.ncbi.nlm.nih.gov/home/about/contact/)


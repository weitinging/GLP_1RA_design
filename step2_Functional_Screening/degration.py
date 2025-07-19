import pandas as pd

# Load sequences from FASTA file
fasta_path = 'F:/ProteinDesign/GLP/step1_ProteinMPNN_Design/outputs/seqs/design.fa'
sequences = {}

with open(fasta_path, 'r') as fasta_file:
    current_key = None
    for line in fasta_file:
        line = line.strip()
        if line.startswith('>'):
            current_key = line
        else:
            sequences[current_key] = line

# Filter sequences with NEP sites
degradation_count = 0
output_path = 'F:/ProteinDesign/GLP/step2_Functional_Screening/filter_degration.fa'

with open(output_path, 'w') as result_file:
    for header, seq in sequences.items():
        if (seq[8:10] != 'DV' and seq[11:13] != 'SY' and seq[12:14] != 'YL' and
            seq[20:22] != 'EF' and seq[21:23] != 'FI' and seq[24:26] != 'WL'):
            degradation_count += 1
        else:
            result_file.write(f"{header}{seq}")
print(f"Degradation number: {degradation_count}")


#please firstly install ProteinMPNN https://github.com/dauparas/ProteinMPNN

source activate mlfold

folder_with_pdbs="./inputs/"

output_dir="./outputs/"
if [ ! -d $output_dir ]
then
    mkdir -p $output_dir
fi


path_for_parsed_chains=$output_dir"/parsed_pdbs.jsonl"
path_for_assigned_chains=$output_dir"/assigned_pdbs.jsonl"
path_for_fixed_positions=$output_dir"/fixed_pdbs.jsonl"
chains_to_design="P"
#The first amino acid in the chain corresponds to 1 and not PDB residues index for now.
design_only_positions="10 12 13 14 15 16 17 18 19 20 21 22 23 24 25 26 27 29 30" #design only these residues; use flag --specify_non_fixed

python ../helper_scripts/parse_multiple_chains.py --input_path=$folder_with_pdbs --output_path=$path_for_parsed_chains

python ../helper_scripts/assign_fixed_chains.py --input_path=$path_for_parsed_chains --output_path=$path_for_assigned_chains --chain_list "$chains_to_design"

python ../helper_scripts/make_fixed_positions_dict.py --input_path=$path_for_parsed_chains --output_path=$path_for_fixed_positions --chain_list "$chains_to_design" --position_list "$design_only_positions" --specify_non_fixed

python ../protein_mpnn_run.py \
        --jsonl_path $path_for_parsed_chains \
        --chain_id_jsonl $path_for_assigned_chains \
        --fixed_positions_jsonl $path_for_fixed_positions \
        --out_folder $output_dir \
        --num_seq_per_target 10000 \
        --sampling_temp "0.1" \
        --seed 37 \
        --batch_size 1

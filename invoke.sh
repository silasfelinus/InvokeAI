#!/usr/bin/env bash

set -euo pipefail
IFS=$'\n\t'

PATH=.venv/scripts:$PATH

if [ "$0" != "bash" ]; then
    echo "Acrocat Ranch Invoke AI Processor"
    echo "1. command-line"
    echo "2. acrocat ranch UI"
    echo "3. open the developer console"
    echo "4. process prompts"
    echo "5. generate prompts"
    read -p "please enter your choice: " yn
    case $yn in
        1 ) printf "\nStarting the InvokeAI command-line..\n"; .venv/bin/python scripts/invoke.py;;
        2 ) printf "\nStarting the InvokeAI browser-based UI..\n"; .venv/bin/python scripts/invoke.py --free_gpu_mem --web --host 0.0.0.0 -s20 --outdir '/home/silasfelinus/Nextcloud/ai-art';;
        3 ) printf "\nDeveloper Console:\n"; file_name=$(basename "${BASH_SOURCE[0]}"); bash --init-file "$file_name";;
        4 ) printf "\Processing prompts..\n"; .venv/bin/python scripts/invoke.py --config configs/secret_models.yaml --model pyros-bj --free_gpu_mem -s40 --outdir '/home/silasfelinus/Nextcloud/process' --from_file 'prompts.txt';;
        5 ) printf "\Generating prompts..\n"; .venv/bin/python scripts/prompt2.py;;
        8 ) printf "\Silas Development..\n"; .venv/bin/python scripts/invoke.py --config configs/secret_models.yaml --model delphine --free_gpu_mem --web --host 0.0.0.0 --port 7979 --outdir '/home/silasfelinus/Nextcloud/personal';;
        
        * ) echo "Invalid selection"; exit;;
    esac
else # in developer console
    python --version
    echo "Press ^D to exit"
    export PS1="(InvokeAI) \u@\h \w> "
fi

#!/bin/bash
#   Update all the code references in the .md files
#   Markdown files should use the tag CODE_START and CODE_END as next
#   CODE_START:[CODE_PATH]
#   CODE_START:[CODE_END]

## Functions
verify_path_is_valid() {
    if [ -f "$1" ]; then
        return 0
    fi
    return 1
}

## Main Code
md_files=$(find $(pwd) -type f -name "*.md")

if [[ ${#md_files[@]} -eq 0 ]]; then
    echo -e "\n###      There are no markdown files"
else
    for file_path in ${md_files[@]}; do
        # echo $file_path
        start_code_lines=$(awk '/CODE_START/{print NR}' $file_path)
        for start_code_line in ${start_code_lines[@]}; do
            file_with_code_path=$(awk -v line_with_file_path="$start_code_line" 'NR == line_with_file_path && NF == 4{print $3}' $file_path)

            if verify_path_is_valid $file_with_code_path; then
                end_code_line=$(awk -v line_to_start_cheking="$start_code_line" 'NR>line_to_start_cheking && /CODE_END/ {print NR;exit}' $file_path)
                echo $end_code_line
            fi

        done
    done
fi

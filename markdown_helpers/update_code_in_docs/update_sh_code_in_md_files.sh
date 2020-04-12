#!/bin/bash
#   Update all the bash code references in the .md files
#   Markdown files should use the tag CODE_START and CODE_END as next
#   CODE_START:[CODE_PATH]
#   CODE_START:[CODE_END]

## Functions
function path_is_valid() {
    if [ -f "$1" ]; then
        return 0
    fi
    return 1
}
function string_is_not_empty() {
    if [ -z "$1" ]; then
        return 1
    fi
    return 0
}
function remove_code_between_two_lines() {
    diff_lines=$(expr $2 - $1)
    if [[ "$diff_lines" > 1 ]]; then
        init_range=$(expr $1 + 1)
        end_range=$(expr $2 - 1)
        path=$3
        sed -i "$init_range,$end_range""d" $path
    fi
}
function insert_code() {
    # $1 Line that contains START_CODE
    # $2 Code Path
    # $3 Mardown File Path
    # $4 Language
    lines_before_code=$(expr $1)
    num_lines=$(cat $3 | wc -l)
    lines_after_code=$(expr $num_lines - $lines_before_code + 1)

    # Append the upper part
    head -n $lines_before_code $3 >temp.txt

    # TODO: detect if the first and last lines of of the code to be insert is empty
    # Scenario 1: If the text to be inserted doesn't have a \n at the end this works bad
    # Append the code
    echo "\`\`\`$4" >>temp.txt
    cat $2 >>temp.txt
    echo "\`\`\`" >>temp.txt

    tail -n $lines_after_code $3 >>temp.txt
    mv temp.txt $3
}

## Main Code
md_files=$(find $(pwd) -type f -name "*.md")
init_execution_path=$(pwd)
echo "###   START   update_sh_code_in_md_files.sh"

if [[ ${#md_files[@]} -eq 0 ]]; then
    echo "###      There are no markdown files"
else
    for md_file_path in ${md_files[@]}; do
        # echo "###   Markdown found $(basename $md_file_path) at $(dirname $md_file_path)"
        match_start_line=$(awk '/CODE_START/{print NR;exit}' $md_file_path)
        cd $(dirname $md_file_path)
        while string_is_not_empty $match_start_line; do

            # Improve get parameters process
            file_with_code_path=$(awk -v line_with_md_file_path="$match_start_line" 'NR == line_with_md_file_path && NF == 5 {print $3}' $md_file_path)
            lang=$(awk -v line_with_md_file_path="$match_start_line" 'NR == line_with_md_file_path && NF == 5 {print $4}' $md_file_path)

            if path_is_valid $file_with_code_path; then
                echo "###   $(basename $md_file_path)"
                echo "###   Injecting $(basename $file_with_code_path)"
                match_end_line=$(awk -v line_to_start_cheking="$match_start_line" 'NR > line_to_start_cheking && /CODE_END/ {print NR;exit}' $md_file_path)
                if string_is_not_empty $match_end_line; then
                    remove_code_between_two_lines $match_start_line $match_end_line $md_file_path
                    insert_code $match_start_line $file_with_code_path $md_file_path $lang
                fi
            fi
            match_start_line=$(awk -v last_line=$match_start_line 'NR > last_line && /CODE_START/ {print NR;exit}' $md_file_path)
        done
    done
fi
cd $init_execution_path
echo "###   END   update_sh_code_in_md_files.sh "

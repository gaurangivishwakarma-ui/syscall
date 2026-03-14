#!/bin/bash
words=()
while IFS= read -r line ; do
    words+=("$line")
done < "words.txt"

get_difficulty_level() {
    printf "Enter difficulty level (1 for easy, 2 for medium, 3 for hard): "
    read difficulty
}

get_sentence() {
    local generated_sentence=""
    if [[ $difficulty -eq 1 ]]; then
        local i=0
        while (( i < 10 )); do
            local raw_word="${words[$RANDOM % ${#words[@]}]}"
            local r_w="${raw_word%$'\r'}"
            if (( ${#r_w} <= 5 )); then
                generated_sentence+="$r_w "
                ((i++))
            fi
        done
    elif [[ $difficulty -eq 2 ]]; then
        local i=0
        while (( i < 10 )); do
            local raw_word="${words[$RANDOM % ${#words[@]}]}"
            local r_w="${raw_word%$'\r'}"
            if (( ${#r_w} >= 3 && ${#r_w} <= 7 )); then
                generated_sentence+="$r_w "
                ((i++))
            fi
        done
    else
        local i=0
        while (( i < 10 )); do
            local raw_word="${words[$RANDOM % ${#words[@]}]}"
            local r_w="${raw_word%$'\r'}"
            if (( ${#r_w} >= 7 )); then
                generated_sentence+="$r_w "
                ((i++))
            fi
        done   
    fi
    echo "${generated_sentence% }"
}

calculate_wpm() {
    local user_input="$1"
    local time_elapsed="$2"
    local word_count=$(echo "$user_input" | wc -w)
    echo "scale=2; ($word_count / $time_elapsed) * 60" | bc
}

calculate_accuracy() {
    local target="$1"
    local typed="$2"
    IFS=' ' read -r -a target_words <<< "$target"
    IFS=' ' read -r -a typed_words <<< "$typed"
    local total=${#target_words[@]}
    local correct=0
    for ((i=0; i<total; i++)); do
        if [[ "${typed_words[i]}" == "${target_words[i]}" ]]; then
            ((correct++))
        fi
    done
    local accuracy=$((correct * 100 / total))
    echo "$accuracy"
}

save_results() {
    local wpm=$1
    local acc=$2
    local diff=$3
    local date_str=$(date "+%Y-%m-%d %H:%M")
    if [[ ! -f "history.csv" ]]; then
        echo "Date,Difficulty,WPM,Accuracy" > "history.csv"
    fi
    echo "$date_str,$diff,$wpm,$acc" >> "history.csv"
}

run_test() {
    sentence=$(get_sentence) 
    clear
    printf "Type the following text:\n\n%s\n\n" "$sentence"
    start=$(date +%s.%N)
    local input=""
    local target="$sentence"
    local len=${#target}
    local GREEN='\e[32m'
    local RED='\e[31m'
    local RED_BG='\e[41m'
    local RESET='\e[0m'
    printf "> "
    while true; do
        IFS= read -r -s -n 1 char
        if [[ -z "$char" ]]; then
            break
        fi
        if [[ "$char" == $'\x7f' || "$char" == $'\b' ]]; then
            if [[ ${#input} -gt 0 ]]; then
                input="${input%?}"
            fi
        else
            if [[ ${#input} -lt $len ]]; then
                input+="$char"
            fi
        fi
        printf "\r> "
        for (( i=0; i<${#input}; i++ )); do
            local typed_char="${input:$i:1}"
            local target_char="${target:$i:1}"
            if [[ "$typed_char" == "$target_char" ]]; then
                printf "${GREEN}%s${RESET}" "$typed_char"
            else
                if [[ "$typed_char" == " " ]]; then
                     printf "${RED_BG}%s${RESET}" "$typed_char"
                else
                     printf "${RED}%s${RESET}" "$typed_char"
                fi
            fi
        done
        local remaining=$(( len - ${#input} ))
        if [[ $remaining -gt 0 ]]; then
            printf "%s" "${target:${#input}:$remaining}"
        fi
    done
    end=$(date +%s.%N)
    elapsed=$(echo "$end - $start" | bc)
    echo -e "\n"
    raw_accuracy=$(calculate_accuracy "$sentence" "$input")
    wpm=$(calculate_wpm "$input" "$elapsed")
    printf "Accuracy: %s%%\n" "$raw_accuracy"
    printf "Your WPM: %s\n\n" "$wpm"
    save_results "$wpm" "$raw_accuracy" "$difficulty"
}

while true; do
    get_difficulty_level
    run_test
    printf "Press Enter to continue to the next test, or type 'q' to quit: "
    read -r restart
    if [[ "$restart" == "q" || "$restart" == "Q" ]]; then
        echo "Thanks for playing!"
        break
    fi
done
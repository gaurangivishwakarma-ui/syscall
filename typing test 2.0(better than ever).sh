#!/bin/bash


# mapfile for faster reading of file
echo -n "Loading dictionary..."
if ! mapfile -t words < "words.txt" 2>/dev/null; then
    echo -e "\nError: words.txt not found!"
    exit 1
fi
echo -e "\rDictionary loaded!       "
sleep 0.5
clear


view_history() {
    clear
    if [[ ! -f "history.csv" ]]; then
        echo "No history found yet. Play a game first!"
        echo ""
        return
    fi

    echo "=== TYPING HISTORY ==="
  
    column -t -s ',' "history.csv"
    echo ""
    
   
    echo "=== WPM PROGRESS GRAPH (Last 10 Games) ==="
    
    tail -n 10 "history.csv" | awk -F',' 'NR>1 {
        printf "%-16s | ", $1; 
        wpm=int($3); 
        for(i=0;i<wpm;i+=1) printf "█"; 
        print " " wpm " WPM"
    }'
    echo ""
}

main_menu() {
    while true; do
        printf "1. Play Test\n2. View History & Graphs\n3. Quit\nChoose an option: "
        read -r choice
        case $choice in
            1) break ;;
            2) view_history ;;
            3) echo "Goodbye!"; exit 0 ;;
            *) echo -e "\e[31mError: Please enter 1, 2, or 3.\e[0m" ;;
        esac
    done
}

#fixed the invalid input issue
get_difficulty_level() {
    while true; do
        printf "Enter difficulty level (1 for easy, 2 for medium, 3 for hard): "
        read -r difficulty
        if [[ "$difficulty" =~ ^[1-3]$ ]]; then
            break
        else
            echo -e "\e[31mError: Invalid input. Please just enter 1, 2, or 3.\e[0m"
        fi
    done
}

get_sentence() {
    local generated_sentence=""
    local i=0
    
    while (( i < 10 )); do
        local raw_word="${words[$RANDOM % ${#words[@]}]}"
        local r_w="${raw_word%$'\r'}" 
        local len=${#r_w}
        local valid=0
        
        if [[ $difficulty -eq 1 ]] && (( len <= 5 )); then valid=1
        elif [[ $difficulty -eq 2 ]] && (( len >= 3 && len <= 7 )); then valid=1
        elif [[ $difficulty -eq 3 ]] && (( len >= 7 )); then valid=1
        fi
        
        if (( valid == 1 )); then
            generated_sentence+="$r_w "
            ((i++))
        fi
    done
    echo "${generated_sentence% }" 
}

calculate_wpm() {
    local user_input="$1"
    local time_elapsed="$2"
    local word_count=$(echo "$user_input" | grep -o '[a-zA-Z]*' | wc -w)
    # divide by zero handled if typing too fast
    if (( $(echo "$time_elapsed == 0" | bc -l) )); then time_elapsed=1; fi
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
    if (( total == 0 )); then echo "0"; return; fi
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

# timer added and auto finish detection added and fixed the error in level 2 and 3
run_test() {
    sentence=$(get_sentence) 
    clear
    printf "Type the following text:\n\n%s\n\n" "$sentence"
    
    local start=$(date +%s.%N)
    local input=""
    local target="$sentence"
    local len=${#target}
    
    local GREEN='\e[32m'
    local RED='\e[31m'
    local RED_BG='\e[41m'
    local RESET='\e[0m'
    
    tput civis #hides cursor
    tput sc  #saves cursor location
    while [[ ${#input} -lt $len ]]; do
        
        if IFS= read -t 0.1 -r -s -n 1 char; then
            if [[ "$char" == $'\x7f' || "$char" == $'\b' ]]; then
                
                if [[ ${#input} -gt 0 ]]; then
                    input="${input%?}"
                fi
            elif [[ "$char" == " " ]]; then
                
                if [[ "${target:${#input}:1}" == " " ]]; then  #${variable:offset:length} syntax for reference
                    input+=" " 
                else
                    while [[ ${#input} -lt $len && "${target:${#input}:1}" != " " ]]; do
                        input+="~"
                    done
                    if [[ ${#input} -lt $len ]]; then
                        input+=" "
                    fi
                fi
            elif [[ -n "$char" ]]; then
                input+="$char"
            fi
        fi

        local current_time=$(date +%s.%N)
        local elapsed_live=$(echo "$current_time - $start" | bc)
        
        tput rc  #restore cursor
        tput ed  #erase display
        
        printf "[ %0.1fs ] > " "$elapsed_live"
        
        for (( i=0; i<${#input}; i++ )); do
            local typed_char="${input:$i:1}"
            local target_char="${target:$i:1}"
            
            if [[ "$typed_char" == "$target_char" ]]; then
                printf "${GREEN}%s${RESET}" "$typed_char"
            else
                local display_char="$typed_char"
                if [[ "$typed_char" == "~" ]]; then display_char="${target_char}"; fi
                
                if [[ "$target_char" == " " ]]; then
                     printf "${RED_BG}%s${RESET}" " "
                else
                     printf "${RED}%s${RESET}" "$display_char"
                fi
            fi
        done
        
        local remaining=$(( len - ${#input} ))
        if [[ $remaining -gt 0 ]]; then
            printf "%s" "${target:${#input}:$remaining}"
        fi
    done
    
    
    tput cnorm #makes cursor appear again
    
    local end=$(date +%s.%N)
    local elapsed=$(echo "$end - $start" | bc)
    echo -e "\n\n"
    
    raw_accuracy=$(calculate_accuracy "$sentence" "$input")
    wpm=$(calculate_wpm "$input" "$elapsed")
    
    save_results "$wpm" "$raw_accuracy" "$difficulty"
    
    echo "=============================="
    printf " Final Time : %0.2fs\n" "$elapsed"
    printf " Accuracy   : %s%%\n" "$raw_accuracy"
    printf " Speed      : %s WPM\n" "$wpm"
    echo "=============================="
}
# added the security error
while true; do
    main_menu
    get_difficulty_level
    run_test
    
    while true; do
        printf "\nPress [ENTER] to play again, or type 'q' or 'Q' to quit: "
        read -r restart  
        if [[ -z "$restart" ]]; then
            clear
            break 
        elif [[ "$restart" == "q" || "$restart" == "Q" ]]; then
            echo "Thanks for playing!"
            exit 0
        else
            echo -e "\e[31mSecurity Check: Invalid input. Only ENTER or Q are allowed.\e[0m"
        fi
    done
done

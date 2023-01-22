################
## Emjoi commiter
## github.com/maelbecel
################

#type
#files
#message
#issues
#in work ?

docfile=~/scripts/commitmoji/commitmoji_doc.txt

function chatgpt_response()
{
    api=$(cat ~/scripts/commitmoji/chatgptapiKey)
    response=$(curl -s https://api.openai.com/v1/completions \
                    -H "Content-Type: application/json" \
                    -H "Authorization: Bearer $api" \
                    -d '{"model": "text-davinci-003","max_tokens": 1024, "prompt": "Give me a funny commit name for a '"$name_types"' modification on this files: '"$files"'"}')
    echo $(echo $response | jq -r '.choices[0].text' | tr '$"' ' ')
}

function help_menu()
{
    echo "Usage: ./commitmoji.sh [OPTION]"
    echo "       OPTIONS           -h: Display this help"
    echo "                         -a: Commit as --amend"
    echo "                         -m [branch to merge][with (default main)]: Merge two branches"
    echo "                         -w: automatise commit message from whatthecommit.com"
    echo "Types:"
    for i in ${type_list[@]}; do
        echo -ne "       $i\n"
    done
}

function list_type()
{
    type_list=()
    emoji_list=()

    while read TYPE EMOJI; do
        type_list+=($TYPE)
        emoji_list+=($EMOJI)
    done < $docfile
}

function get_emoji()
{
    for x in ${!type_list[@]}; do
        if [ $1 = ${type_list[$x]} ]; then
            echo ${emoji_list[$x]}
            return
        fi
    done
    echo $1
}

function get_type()
{
    types=""
    name_types=""
    echo -ne "Type of commit: "
    read -r temp_types
    for i in ${temp_types[@]}; do
        types+=$(get_emoji $i)
        name_types=$i
    done
}

function get_files()
{
    files=""
    temp_files=()
    echo -ne "Files: "
    read -r -e tmp
    for i in ${tmp[@]}; do
        temp_files+=($i)
    done
    for i in ${temp_files[@]}; do
        files+="$i"
        add+=" $i"
        if [[ $i != ${temp_files[${#temp_files[@]} - 1]} ]]; then
            files+=", "
        fi
    done
}

function get_message()
{
    message=""
    echo -ne "Message : "
    read -r message
}

function get_issues()
{
    issues="["
    echo -ne "Issues : "
    read -r tmp
    re='^[0-9]+$'
    temp_files=()
    for i in ${tmp[@]}; do
        temp_files+=($i)
    done
    for i in ${temp_files[@]}; do
        if [[ $i =~ $re ]]; then
            issues+="#$i"
            if [[ $i != ${temp_files[${#temp_files[@]} - 1]} ]]; then
                issues+=", "
            fi
        fi
    done
    issues+="]"
}

function get_in_work()
{
    inwork=""
    echo -ne "In Work ? (y/n) : "
    read -r tmp
    if [ "$tmp" == "y" ]; then
        inwork="🚧"
    fi
}

function leave()
{
    echo "Failed"
    exit 0
}

function main()
{
    list_type
    add="git add"
    command="git commit -S"

    if [ "$1" == "-a" ]; then
        command="$command --amend"
    fi
    if [ "$1" == "-h" ]; then
        help_menu
        exit 0
    elif [[ "$1" == "-m" && ! -z "$2" ]]; then
        if [ -z "$3" ]; then
            branch="main"
        else
            branch=$3
        fi
        git switch $branch && git pull && echo "Merge $2 on $branch ? (y/n)" || leave
        read input
        if [ "$input" == "y" ]; then
            git switch $branch && git merge --no-edit $2 && git commit --amend -m "🔀 ($2/): Merge $2 with $branch" && echo "Sucess" || echo "Failed"
        else
            echo "Aborted"
            exit 1
        fi
        exit 0;
    elif [[ "$1" == "-m" && -z "$2" ]]; then
        help_menu
        exit 0
    elif [[ "$1" == "-a" || -z "$1" || "$1" == "-w" || "$1" == "-wm" || "$1" == "-m" || "$1" == "-c" ]]; then
        command="$command -m"

        get_type
        get_files
        if [[ "$1" == "-w" || "$1" == "-wm" ]]; then
            message=$(curl -s https://whatthecommit.com/index.txt)
        elif [[ "$1" == "-c" ]]; then
            message=$(chatgpt_response)
        else
            get_message
        fi
        get_issues
        get_in_work

        command="$add && $command \"$types$inwork ($files): $message"

        if [[ "$issues" == "[]" ]]; then
            command="$command\""
        else
            command="$command $issues\""
        fi
        echo
        echo -ne "Execute command: ($command) ? (y/n) : "
        read -r result
        if [ "$result" == "y" ] || [ -z "$result" ]; then
            eval $command && echo "Sucess" || echo "Failed"
        else
            echo "Aborted"
            exit 1
        fi
    fi

    echo -ne "Push it ? (y/n) : "
    read -r result
    if [ "$result" == "y" ] || [ -z "$result" ]; then
        git push && echo "Sucess" || echo "Failed"
    fi
    if [[ "$1" == "-wm" || "$1" == "-m" ]]; then
        echo "Bangarang"
        ffplay -nodisp -autoexit ~/scripts/commitmoji/Bangarang.mp3 >/dev/null 2>&1
    fi
}

main "$@"

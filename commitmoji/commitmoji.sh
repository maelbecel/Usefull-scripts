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
    echo
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
    echo -ne "Type of commit: "
    read -r temp_types
    for i in ${temp_types[@]}; do
        types+=$(get_emoji $i)
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
    if [ $tmp = "y" ]; then
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
    command="git commit"

    if [ "$1" = "-a" ]; then
        command="$command --amend"
    fi
    if [ "$1" = "-h" ]; then
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
    elif [[ "$1" == "-a" || -z "$1" || "$1" == "-w" ]]; then
        command="$command -m"

        get_type
        get_files
        if [ "$1" = "-w" ]; then
            message=$(curl -s whatthecommit.com/index.txt)
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
        if [ "$result" = "y" ]; then
            eval $command && echo "Sucess" || echo "Failed"
        else
            echo "Aborted"
            exit 1
        fi
    fi

    echo -ne "Push it ? (y/n) : "
    read -r result
    if [ "$result" = "y" ]; then
        git push && echo "Sucess" || echo "Failed"
    fi
}

main "$@"


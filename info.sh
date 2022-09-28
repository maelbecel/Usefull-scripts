#!/bin/bash
################
## Information checker for a directory
## github.com/maelbecel
################


if [ -z $1 ]; then
    path=$(pwd)
else
    path=$1
fi

name=$(basename "$path")

echo -e "Running on $name...\n"


function building()
{
    echo "---- Build ----"
    if [ -f "$path"/Makefile ]; then
        make -C "$path" fclean > /dev/null
        res=$(make -C "$path")
        if [ -z $(echo $res | grep Error) ]; then
            echo "Makefile OK"
        else
            echo "Makefile KO"
        fi
    else
        echo "No Makefile"
    fi
    make -C "$path" fclean > /dev/null
    echo
}

function testing()
{
    echo "---- Unit Test ----"
    if [ -d "$path"/tests ]; then
        unittest=$(ls -R "$path"/tests | grep -c .c)
        echo "$unittest unit tests"
    else
        echo "No unit tests"
    fi
    echo
}

function coverage()
{
    echo "---- Coverage ----"
    if [ -f "$path"/tests/units ]; then
        $coverage=$(gcovr -r "$path" --exclude tests/units | grep -c "TOTAL")
        if [ $coverage == 1 ]; then
            echo "$coverage"
        else
            echo "Coverage KO"
        fi
    else
        echo "No coverage"
    fi
    echo
}

function valgrind()
{
    echo "---- Valgrind ----"
    if [ -f "$path"/tests/units ]; then
        $valgrind=$(valgrind --leak-check=full --error-exitcode=1 ./"$path"/tests/units 2>&1 | grep -c "ERROR SUMMARY")
        if [ $valgrind == 1 ]; then
            echo "$valgrind"
        else
            echo "Valgrind KO"
        fi
    else
        echo "No valgrind"
    fi
    echo
}

function get_percentage()
{
    Value=$1
    Total=$2
    awk "BEGIN {print (100/$Total*$Value)}"
}

function fillarray()
{
    ext=$1

    for i in ${OTHER_ARRAY[@]}; do
        if [ $i == $(echo .$ext) ]; then
            return
        fi
    done
    OTHER_ARRAY+=($(echo .$ext))
}

function get_language()
{
    C=0
    CPP=0
    HTML=0
    PHP=0
    SQL=0
    CSS=0
    MAKEFILE=0
    PY=0
    BASH=0
    JS=0
    RUBY=0
    JAVA=0
    CSHARP=0
    SWIFT=0
    GO=0
    RUST=0
    DART=0
    KOTLIN=0
    TXT=0
    JSON=0
    ASM=0
    OTHER=0
    OTHER_ARRAY=()

    Files=$(find $path -print | grep -v .git | grep -v /doc)

    indice=0
    nbfile=$(find $path -print | grep -v .git |  grep -v /doc | wc -l)

    for file in $Files; do
        # echo -e "\r Reading file $indice/$nbfile"
        # indice=$((indice+1))
        extension=$(echo $file | rev | cut -d '.' -f 1 | rev)
        if [ -f $file ] && [ -z $(echo $extension | grep "/") ]; then
            size=$(sed -n '$=' $file)
            if [ $extension == "c" ]; then
                C=$((C + size))
            elif [ $extension == "h" ]; then
                C=$((C + size))
            elif [ $extension == "cpp" ]; then
                CPP=$((CPP + size))
            elif [ $extension == "html" ]; then
                HTML=$((HTML + size))
            elif [ $extension == "php" ]; then
                PHP=$((PHP + size))
            elif [ $extension == "sql" ]; then
                SQL=$((SQL + size))
            elif [ $extension == "css" ]; then
                CSS=$((CSS + size))
            elif [ $extension == "py" ]; then
                PY=$((PY + size))
            elif [ $extension == "sh" ]; then
                BASH=$((BASH + size))
            elif [ $extension == "js" ]; then
                JS=$((JS + size))
            elif [ $extension == "rb" ]; then
                RUBY=$((RUBY + size))
            elif [ $extension == "java" ]; then
                JAVA=$((JAVA + size))
            elif [ $extension == "cs" ]; then
                CSHARP=$((CSHARP + size))
            elif [ $extension == "swift" ]; then
                SWIFT=$((SWIFT + size))
            elif [ $extension == "go" ]; then
                GO=$((GO + size))
            elif [ $extension == "rs" ]; then
                RUST=$((RUST + size))
            elif [ $extension == "dart" ]; then
                DART=$((DART + size))
            elif [ $extension == "kt" ]; then
                KOTLIN=$((KOTLIN + size))
            elif [ $extension == "txt" ]; then
                TXT=$((TXT + size))
            elif [ $extension == "json" ]; then
                JSON=$((JSON + size))
            elif [ $extension == "asm" ]; then
                ASM=$((ASM + size))
            elif [ $extension == "s" ]; then
                ASM=$((ASM + size))
            else
                OTHER=$((OTHER + size))
                fillarray $extension
            fi
        elif [[ $(echo $file | grep Makefile) != "" ]]; then
                MAKEFILE=$((MAKEFILE + size))
        fi
    done

    sum=$(( C + CPP + HTML + PHP + SQL + CSS + MAKEFILE + PY + BASH + JS + RB + JAVA + CSHARP + SWIFT + GO + RUST + DART + KOTLIN + TXT + JSON + ASM))

}

function get_heigher()
{
    heigher=0
    heigher_indice=0
    indice=0

    for i in ${language[@]}; do
        if [ ${i} -gt $heigher ]; then
            heigher=${i}
            heigher_indice=$indice
        fi
        indice=$((indice + 1))
    done
    echo $heigher_indice

}

function isempty()
{
    for i in ${language[@]}; do
        if [ ${i} != "0" ]; then
            echo "1"
            return
        fi
    done
    echo "0"
}

function sort_res()
{
    language=("$C" "$CPP" "$HTML" "$PHP" "$SQL" "$CSS" "$MAKEFILE" "$PY" "$BASH" "$JS" "$RUBY" "$JAVA" "$CSHARP" "$SWIFT" "$GO" "$RUST" "$DART" "$KOTLIN" "$TXT" "$JSON" "$ASM")
    language_val=("C" "C++" "HTML" "PHP" "SQL" "CSS" "Makefile" "Python" "Bash" "JavaScript" "Ruby" "Java" "C#" "Swift" "Go" "Rust" "Dart" "Kotlin" "Text" "JSON" "Assembly")

    for ((i=0; i <= $((${#language[@]} - 2)); ++i))
    do
        for ((j=((i + 1)); j <= ((${#language[@]} - 1)); ++j))
        do
            if [[ ${language[i]} -lt ${language[j]} ]]
            then
                tmp=${language[i]}
                language[i]=${language[j]}
                language[j]=$tmp

                tmp=${language_val[i]}
                language_val[i]=${language_val[j]}
                language_val[j]=$tmp
            fi
        done
    done
}


function draw_bar()
{
    len=50
    fill=$1
    total=$2
    percent=$((fill * 100 / total))

    green=$((fill * len / total))
    red=$((len - green))

    if [ $percent -ge 100 ]; then
        echo -ne "\e[1;32m"
        perl -E "print '█' x $len"
        echo -ne "\e[0m"
    else
        echo -ne "\e[1;32m"
        perl -E "print '█' x $green"
        echo -ne "\e[0m"
        echo -ne "\e[1;31m"
        perl -E "print '$3' x $red"
        echo -ne "\e[0m"
        echo -ne "\e[1;37m"
    fi
    echo -e "\e[0m"
}

function draw_bar_triple()
{
    len=50
    first=$1
    second=$2
    third=$3
    total=$((first + second + third))

    red=$((first * len / total))
    green=$((second * len / total))
    yellow=$((third * len / total))

    echo -ne "\e[1;31m"
    perl -E "print '█' x $red"
    echo -ne "\e[0m"

    echo -ne "\e[1;33m"
    perl -E "print '█' x $green"
    echo -ne "\e[0m"

    echo -ne "\e[1;32m"
    perl -E "print '█' x $yellow"
    echo -e "\e[0m"
}

function show_res()
{
    echo "---- Language ----"
    for i in ${!language[@]}; do
        if [[ ${language[i]} -ne 0 ]]; then
            echo "${language_val[i]} : $(draw_bar ${language[i]} $sum "") ($(get_percentage ${language[i]} $sum)%)"
        fi
    done
    echo
}

function get_boucles()
{
    boucle=0

    for i in ${Files[@]}; do
        if [ -f $i ]; then
            act=$(cat $i | grep -c 'for\|while')
            boucle=$((boucle + act))
        fi
    done
    echo $boucle
}

function get_conditions()
{
    conditions=0

    for i in ${Files[@]}; do
        if [ -f $i ]; then
            act=$(cat $i | grep -c 'if\|else\|elif')
            conditions=$((conditions + act))
        fi
    done
    echo $conditions
}

function complementary()
{
    echo "---- Information ----"
    echo "Files : $(find $path -print | wc -l)."
    echo "Directories : $(ls -R $path | grep ":" | wc -l)."
    echo "Total : $sum lines."
    echo "Other : $OTHER lines. (${OTHER_ARRAY[@]})"
    echo "Loops : $(get_boucles)."
    echo "Conditions : $(get_conditions)."

    if [[ $(ls -a $path | grep ".git") != "" ]]; then
        total_issues=$(cd $path;git issues list | wc -l ; cd $power)
        total_issues=$(($total_issues - 3))
        total_issues=$(($total_issues / 2))
        if [ $total_issues -lt 0 ]; then
            total_issues=0
        fi
        closed=$(cd $path;git issues list -s closed | wc -l ; cd $power)
        closed=$(($closed - 3))
        closed=$(($closed / 2))
        if [ $closed -lt 0 ]; then
            closed=0
        fi
        total_issues=$((total_issues + closed))
        power=$(pwd)
        echo
        echo "---- Git info ----"
        echo "First commit : $(cd $path; git log --reverse --pretty=format:"%ad" | head -n 1; cd $power)"
        echo "Last commit : $(cd $path;git log --pretty=format:"%ad" | head -n 1; cd $power)"
        echo "Number of commits : $(cd $path;git log --pretty=format:"%ad" | wc -l; cd $power)"
        echo "Number of contributions : $(cd $path;git log --pretty=format:"%an" | sort | uniq | wc -l; cd $power)"
        echo "Open issues : $(cd $path;git issues list | grep OPEN | wc -l ; cd $power)"
        echo "Closed issues : $closed"
        echo "Total issues : $total_issues"
        echo "Number of branches : $(cd $path;git branch | wc -l ; cd $power)"
        if [ $total_issues -gt 0 ]; then
            echo "Issue state : $(draw_bar $closed $total_issues "█" ) ($(get_percentage $closed $total_issues)%)"
        fi
        echo "Uncommited changes : $(cd $path;git status | grep 'modified' | wc -l; cd $power) files."
    fi
    echo
}

function norme()
{
    echo "---- Norme ----"
    mkdir $path/.inforeptmp
    for file in $Files; do
        extension=$(echo $file | rev | cut -d '.' -f 1 | rev)
        if [ $extension == "c" ]; then
            cp $file $path/.inforeptmp
        elif [ $extension == "h" ]; then
            cp $file $path/.inforeptmp
        fi
    done

    DELIVERY_DIR=$(readlink -f "$path/.inforeptmp")
    REPORTS_DIR=$(readlink -f .)
    EXPORT_FILE="$REPORTS_DIR"/coding-style-reports.log
    ### delete existing report file
    rm -f $EXPORT_FILE

    sudo docker pull ghcr.io/epitech/coding-style-checker:latest 2>&1 > /dev/null
    sudo docker image prune -f 2>&1 > /dev/null

    sudo docker run --rm -i -v "$DELIVERY_DIR":"/mnt/delivery" -v "$REPORTS_DIR":"/mnt/reports" ghcr.io/epitech/coding-style-checker:latest "/mnt/delivery" "/mnt/reports" > /dev/null

    echo -e "Coding style error : $(wc -l < $EXPORT_FILE)\033[0m" && \
    echo -e "Major : \033[31m$(grep -c ": MAJOR:" $EXPORT_FILE)\033[0m" && \
    echo -e "Minor : \033[33m$(grep -c ": MINOR:" $EXPORT_FILE)\033[0m" && \
    echo -e "Info : \033[32m$(grep -c ": INFO:" $EXPORT_FILE)\033[0m" && \

    if [[ $(wc -l < $EXPORT_FILE) -gt 0 ]]; then
        echo -e "Error state : $(draw_bar_triple $(grep -c ": MAJOR:" $EXPORT_FILE) $(grep -c ": MINOR:" $EXPORT_FILE) $(grep -c ": INFO:" $EXPORT_FILE) )"
    fi
    rm -f $EXPORT_FILE
    rm -rf $path/.inforeptmp
    echo

}

get_language
sort_res
show_res
complementary


if [[ ${language_val[0]} == "C" ]]; then
    if [[ $(ls $path | grep Makefile) != "" ]]; then
        building
        testing
        coverage
        valgrind
    fi
    norme
fi


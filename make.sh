##
## github: @maelbcl
## MakefileMaker
## File description:
## To create makefile and had lib and includes

################################################################ Add Makefile #######################################################################

#Add Epitech header
header () {
    echo -e "##"
    echo -e "## EPITECH PROJECT, 2022"
    echo -e "## Makefile"
    echo -e "## File description:"
    if [ -z "$1" ]; then
        echo -e "## Makefile"
    else
        echo -e "## Makefile for $1"
    fi
    echo -e "##"
    echo ""
}

#Add all variable need by makefile
variable () {
    binary=$1
    if [ -z "$1" ]; then
        echo -e "NAME         =        a.out"
    else
        echo -e "NAME         =		    $1"
    fi
    echo -e ""
    echo -e "INCLUDE      =         -I include/ -I include/lib/ -L lib/ \\
                       -lmy -lmyprintf -lformatstring -lparser"
    echo -e ""
    echo -ne "CFLAGS       +=         -Wall -Wextra -pedantic \\
					        -Wstrict-prototypes -fstack-protector\\
					        -Wold-style-definition -std=c99 " && echo -e '$(INCLUDE)'
    echo -e ""
    echo -e "SOURCES      =         src/"
    echo -e ""
    if [ -z "$2" ]; then
        echo -e "SRC          =         \c" && echo -e '$(SOURCES)\c' && echo -e "main.c"
    else
        echo -e "SRC          =         \c" && echo -e '$(SOURCES)\c' && echo -e "$2.c"
    fi
    echo -e ""
    echo -e 'SRC_COUNT    =         $(words $(SRC))'
    echo -e ""
    echo -e "NB           =         0"
    echo -e ""
    echo -e "OBJ          =	        \c" && echo '$(SRC:.c=.o)'
    echo -e ""
    echo -e "TEMPFILES    =         *~ *vgcore* #*#"
    echo -e ""
    echo -e "RM           =         rm -f"
    echo -e ""
    echo -e "ECHO         =         /bin/echo -e"
    echo 'DEFAULT      =         "\033[00m"'
    echo 'BOLD         =         "\e[1m"'
    echo 'RED          =         "\e[31m"'
    echo 'GREEN        =         "\e[32m"'
    echo 'LIGHT_BLUE   =         "\e[94m"'
    echo 'WHITE        =         "\e[1;37m"'
    echo ""
}

#Add basic rules of make file
rules () {
    echo -e "all:\t\c" && echo '$(NAME)'
    echo -e ""
    echo -e '$(NAME):\t$(OBJ)'
    echo -e "\t\t\t@echo"
    echo -e '\t\t\t@($(ECHO) $(BOLD) $(GREEN)✓$(LIGHT_BLUE) \'
    echo -e '\t\t\t"SRC files sucessfully build. "$(DEFAULT))'
    echo -e '\t\t\t@make -C lib/my/ --no-print-directory'
    echo -e '\t\t\t@make -C lib/parser/ --no-print-directory'
    echo -e '\t\t\t@make -C lib/myprintf/ --no-print-directory'
    echo -e '\t\t\t@make -C lib/formatstring/ --no-print-directory'
    echo -e '\t\t\t@gcc -o $(NAME) $(OBJ) $(INCLUDE) \'
	echo -e '\t\t\t&& $(ECHO) $(BOLD) $(GREEN)"\c' && echo '\n► BUILD SUCCESS !"$(DEFAULT) \'
	echo -e '\t\t\t|| ($(ECHO) $(BOLD) $(RED)"\c' && echo '\n► BUILD FAILED"$(DEFAULT) && exit 1)'
    echo -e ""
    echo -e 'debug:\t\tCFLAGS += -g3 -pg'
    echo -e 'debug:\t\tall'
    echo -e ''
    echo -e 'clean:'
	echo -e '\t\t\t@make -C lib/my/ clean --no-print-directory'
	echo -e '\t\t\t@make -C lib/parser/ clean --no-print-directory'
	echo -e '\t\t\t@make -C lib/myprintf/ clean --no-print-directory'
	echo -e '\t\t\t@make -C lib/formatstring/ clean --no-print-directory'
	echo -e '\t\t\t@$(RM) $(OBJ)'
	echo -e '\t\t\t@$(RM) $(TEMPFILES)'
	echo -e '\t\t\t@($(ECHO) $(BOLD) $(GREEN)✓$(LIGHT_BLUE)" Clean SRC "$(DEFAULT))'
    echo -e ''
    echo -e 'fclean:\t\tclean'
	echo -e '\t\t\t@make -C lib/myprintf/ fclean --no-print-directory'
	echo -e '\t\t\t@make -C lib/parser/ fclean --no-print-directory'
	echo -e '\t\t\t@make -C lib/formatstring/ fclean --no-print-directory'
	echo -e '\t\t\t@make -C lib/my/ fclean --no-print-directory'
	echo -e '\t\t\t@$(RM) $(NAME)'
	echo -e '\t\t\t@$(RM) $(OBJ)'
	echo -e '\t\t\t@$(RM) $(TEMPFILES)'
	echo -e '\t\t\t@($(ECHO) $(BOLD) $(GREEN)✓$(LIGHT_BLUE)" Fclean SRC "$(DEFAULT))'
    echo -e ''
    echo -e 're:'
	echo -e '\t\t\t@make fclean --no-print-directory'
	echo -e '\t\t\t@make --no-print-directory'
    echo -e ''
    echo -e '%.o:\t\t%.c'
	echo -e '\t\t\t@$(eval NB=$(shell echo $$(($(NB)+1))))'
	echo -e '\t\t\t@gcc -c -o $@ $^ $(CFLAGS) && python3 build/build.py $< $(NB) \'
	echo -e '\t\t\t$(SRC_COUNT)'
    echo -e ''
    echo -e '.PHONY: all re clean fclean debug'
}

#Manage all make and create make file
echomake () {
    resp=$(echo "yes")
    cp -R ~/delivery/Lib/build $PWD
    if [ -f "$PWD/Makefile" ]; then
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║      \e[0m\e[1mThere is already a Makefile      \e[0m\e[33m║"
        echo -e "                           \e[33m║        \e[0m\e[1mWould you overwrite it ?       \e[0m\e[33m║"
        echo -e "                           \e[33m║          [Type 'yes' or 'no]          ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        read resp
    fi
    clear
    if [ "$resp" = "yes" ]; then
        {
        header $1
        variable $1 $2
        rules
        } > Makefile
        makeanim
    fi
}

############################################################### Load animations #####################################################################

bar () {
    actual=$1
    percent=$(( actual * 100 / 30 ))
    nbsquare=$(( percent / 3))
    if [ "$nbsquare" -gt "$max" ]; then
        nbsquare=$(echo "30")
    fi
    nbspace=$((30 - nbsquare))
    echo -e "\e[0m\c"
    echo -e "\e[32m\c"
    perl -E "print '█' x $nbsquare"
    echo -e "\e[0m\c"
    perl -E "print '░' x $nbspace"
}

srcanim () {
    for (( actual=0; actual<=30; actual++ )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║             \e[0m\e[1mCreate main...            \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}

libanim () {
    for (( actual=0; actual<=30; actual++ )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║           \e[0m\e[1mCreate library...           \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}

includeanim () {
    for (( actual=0; actual<=30; actual++ )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║           \e[0m\e[1mCreate include...           \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}

ignoreanim () {
    for (( actual=0; actual<=30; actual += 2 )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║          \e[0m\e[1mCreate .gitignore...         \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}

makeanim () {
    for (( actual=0; actual<=30; actual++ )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║           \e[0m\e[1mCreate Makefile...          \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}

moulianim () {
    for (( actual=0; actual<=30; actual++ )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║          \e[0m\e[1mCreate Moulinette...         \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}

pushanim () {
    for (( actual=0; actual<=30; actual += 4 )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║               \e[0m\e[1mGit Add...              \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
    for (( actual=0; actual<=30; actual += 5 )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║             \e[0m\e[1mGit Commit...             \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
    for (( actual=0; actual<=30; actual += 3 )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║              \e[0m\e[1mGit Push...              \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}

################################################################### To add things ###################################################################


# To add things
addinclude () {
    if [ -f "$PWD/include/$include_name.h" ]; then
        exit 84
    fi
    {
        echo "/*"
        echo "** EPITECH PROJECT, 2022"
        echo "** $include_name.c"
        echo "** File description:"
        echo "** $include_name"
        echo "*/"
        echo ""
        echo "#ifndef $include_ifndef"
        echo "    #define $include_ifndef"
        if [ -f "$PWD/include/my.h" ]; then
            echo '    #include "my.h"'
        fi
        if [ -f "$PWD/include/printf.h" ]; then
            echo '    #include "printf.h"'
        fi
        if [ -f "$PWD/include/formatstring.h" ]; then
            echo '    #include "formatstring.h"'
        fi
        if [ -f "$PWD/include/parser.h" ]; then
            echo '    #include "parser.h"'
        fi
        echo ""
        echo "    #include <stdbool.h>"
        echo "    #include <stddef.h>"
        if [ ! -z "$libsup" ]; then
            echo -e "$libsup"
        fi
        echo "#endif"
    } > $PWD/include/$include_name.h
}

addlib () {
    if [ ! -d "$PWD/lib" ]; then
        cp -R ~/delivery/Lib/lib $PWD
    fi
    if [ ! -d "$PWD/include" ]; then
        cp -R ~/delivery/Lib/include $PWD
    fi
}

addlib_src ()
{
    if [ ! -d "$PWD/lib" ]; then
        cp -R ~/delivery/Lib/lib/* $PWD/src/
    fi
    if [ ! -d "$PWD/include" ]; then
        cp -R ~/delivery/Lib/include $PWD
    fi
}

addmouli () {
    cp ~/delivery/Lib/mouli.sh $PWD
    cp -R ~/delivery/Lib/tests $PWD
}

addignore () {
    {
        echo "*.o"
        echo "*.a"
        echo "*~"
        echo "#*#"
        echo "*vgcore*"
        echo ".vscode"
        echo "$binary"
    } > $PWD/.gitignore
}

addpush () {
    git add --all
    git commit -m "feat (lib/,src/,include/): Add lib, include and main"
    git push
}

addmain () {
    if [ ! -d "$PWD/src" ]; then
        mkdir $PWD/src
    fi
    {
        echo "/*"
        echo "** EPITECH PROJECT, 2022"
        echo "** $main.c"
        echo "** File description:"
        echo "** $main"
        echo "*/"
        echo ""
        if [[ "$include_name" != "" ]];then
            echo -e '#include "\c' && echo -e "$include_name\c" && echo '.h"'
        fi
        if [ -f "$PWD/include/my.h" ]; then
            echo ""
        elif [ -f "$PWD/include/printf.h" ]; then
            echo ""
        elif [ -f "$PWD/include/formatstring.h" ]; then
            echo ""
        elif [ "$include_name" != "" ]; then
            echo ""
        fi
        echo "int main (UNUSED int ac, UNUSED char **argv, UNUSED char **env)"
        echo "{"
        echo "    return 0;"
        echo "}"
    } > $PWD/src/$main.c
}


add_cmake ()
{
    if [ ! -f "$PWD/CMakeLists.txt" ]; then
        {
            echo "cmake_minimum_required(VERSION 3.16)"
            echo "project($binary C)"
            echo "include_directories(include)"
            echo "set(INSTALL_DOC ON)"
            echo "add_subdirectory(src)"
            echo "add_subdirectory(include)"
            echo ""
        } > $PWD/CMakeLists.txt
    fi
    if [ ! -f "$PWD/include/CMakeLists.txt" ]; then
        {
            echo "file(GLOB include_H . *.h)"
            echo 'install(FILES ${include_H} DESTINATION include)'
            echo ""
        } > $PWD/include/CMakeLists.txt
    fi
    if [ ! -f "$PWD/src/CMakeLists.txt" ]; then
        {
            echo "include_directories(include)"
            echo ""
            echo "add_subdirectory(formatstring)"
            echo "add_subdirectory(my)"
            echo "add_subdirectory(myprintf)"
            echo "add_subdirectory(parser)"
            echo "SET(PROJECT_LIBS formatstring my myprintf parser)"
            echo ""
            echo "add_executable($binary main.c)"
            echo ""
            echo -ne "TARGET_LINK_LIBRARIES($binary " && echo '${PROJECT_LIBS})'
            echo "install(TARGETS $binary DESTINATION bin)"
            echo ""
        } > $PWD/src/CMakeLists.txt

        cp -f ~/delivery/Lib/parser.h $PWD/include
        cp -f ~/delivery/Lib/parser.h $PWD/src/parser
        cp -f ~/delivery/Lib/get_line_pars.c $PWD/src/parser/json/get_line_pars.c
        cp -f ~/delivery/Lib/get_update.c $PWD/src/parser/json/get_update.c
        cp -f ~/delivery/Lib/builder $PWD/builder

    fi
}

################################################################### To get infos ###################################################################
makeanim () {
    for (( actual=0; actual<=30; actual++ )); do
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m║           \e[0m\e[1mCreate Makefile...          \e[0m\e[33m║"
        echo -e "                           \e[33m║    \c" && bar $actual && echo -e "\e[33m     ║"
        echo -e "                           \e[33m║                                       ║"
        echo -e "                           \e[33m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        sleep 0.05
        clear
    done
}
#For the -h
gethelp () {
    echo "Smart tool to get lib, include, makefile and main "
    echo ""
    echo "USAGE :"
    echo "    launch [OPTIONS]"
    echo ""
    echo "OPTIONS :"
    echo "    -a    To get only the main"
    echo "    -cm   To build with CMakelists"
    echo "    -h    To have help"
    echo "    -i    To get only the includes"
    echo "    -l    To get only the library"
    echo "    -m    To get only the Makefile"
}

#To get informations

getinfo_push () {
    clear
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║           \e[0m\e[1mPush it ?                   \e[0m\e[32m║"
    echo -e "                           \e[32m║          [Type 'yes' or 'no]          ║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read push

    if [ "$push" == "yes" ]; then
        addpush > /dev/null
        clear
        pushanim
    fi
    clear
}

getinfo_ignore () {
    clear
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║        \e[0m\e[1mAdd a .gitignore ?             \e[0m\e[32m║"
    echo -e "                           \e[32m║          [Type 'yes' or 'no]          ║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read ignore

    if [ "$ignore" == "yes" ]; then
        addignore
        ignoreanim
    fi
    clear
}

getinfo_mouli () {
    clear
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║           \e[0m\e[1mAdd a mouli ?               \e[0m\e[32m║"
    echo -e "                           \e[32m║          [Type 'yes' or 'no]          ║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read mouli

    if [ "$mouli" == "yes" ]; then
        addmouli
        moulianim
    fi
    clear
}

getinfo_binary () {
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║     \e[0m\e[1mInput a name for the binary :     \e[0m\e[32m║"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read binary
}

getinfo_include () {
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║    \e[0m\e[1mInput a name for the '.h' file :   \e[0m\e[32m║"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read include_name
    clear

    if [ -d "$PWD/include" ]; then
        if [ -f "$PWD/include/$include_name.h" ]; then
            breakbcl=0
            while (($breakbcl == 0)); do
                echo -e "                           \e[31m╬═══════════════════════════════════════╬"
                echo -e "                           \e[31m║                                       ║"
                echo -e "                           \e[31m║        \e[1mThis file already exist.       \e[0m\e[31m║"
                echo -e "                           \e[31m║            \e[1m[Press enter]              \e[0m\e[31m║"
                echo -e "                           \e[31m╬═══════════════════════════════════════╬"
                echo -e "\e[0m"
                read tmp
                clear

                echo -e "                           \e[32m╬═══════════════════════════════════════╬"
                echo -e "                           \e[32m║                                       ║"
                echo -e "                           \e[32m║    \e[0m\e[1mInput a name for the '.h' file :   \e[0m\e[32m║"
                echo -e "                           \e[32m║                                       ║"
                echo -e "                           \e[32m╬═══════════════════════════════════════╬"
                echo -e "\e[0m"
                read include_name
                clear

                if [ -d "$PWD/include" ]; then
                    if [ -f "$PWD/include/$include_name.h" ]; then
                        breakbcl=0
                    else
                        breakbcl=1
                    fi
                else
                    breakbcl=1
                fi

            done
        fi
    fi

    clear
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║     \e[0m\e[1mInput a name for the ifndef :     \e[0m\e[32m║"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read include_ifndef
    include_ifndef=${include_ifndef^^}
    clear

    breakbcl=0
    while (( $breakbcl == 0 )); do
        echo -e "                           \e[32m╬═══════════════════════════════════════╬"
        echo -e "                           \e[32m║                                       ║"
        echo -e "                           \e[32m║        \e[1mInclude a new library ?        \e[0m\e[32m║"
        echo -e "                           \e[32m║     \e[1m[Type 'no' or the new lib]        \e[0m\e[32m║"
        echo -e "                           \e[32m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        read temp
        clear

        if [ "${temp}" != "no" ]; then
            libsup="${libsup}    #include <${temp}.h>\n"
        else
            breakbcl=1
        fi
    done
}

getinfo_main () {
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║    \e[0m\e[1mInput a name for the main file :   \e[0m\e[32m║"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read main
    clear

    if [ -d "$PWD/src" ]; then
        if [ -f "$PWD/src/$main.c" ]; then
            breakbcl=0
            while (($breakbcl == 0)); do
                echo -e "                           \e[31m╬═══════════════════════════════════════╬"
                echo -e "                           \e[31m║                                       ║"
                echo -e "                           \e[31m║        \e[1mThis file already exist.       \e[0m\e[31m║"
                echo -e "                           \e[31m║            \e[1m[Press enter]              \e[0m\e[31m║"
                echo -e "                           \e[31m╬═══════════════════════════════════════╬"
                echo -e "\e[0m"
                read tmp
                clear

                echo -e "                           \e[32m╬═══════════════════════════════════════╬"
                echo -e "                           \e[32m║                                       ║"
                echo -e "                           \e[32m║    \e[0m\e[1mInput a name for the main file :   \e[0m\e[32m║"
                echo -e "                           \e[32m║                                       ║"
                echo -e "                           \e[32m╬═══════════════════════════════════════╬"
                echo -e "\e[0m"
                read main
                clear

                if [ -d "$PWD/src" ]; then
                    if [ -f "$PWD/src/$main.c" ]; then
                        breakbcl=0
                    else
                        breakbcl=1
                    fi
                else
                    breakbcl=1
                fi

            done
        fi
    fi
}

ask_for_cmake ()
{
    breakbcl=0
    while (( $breakbcl == 0 )); do
        echo -e "                           \e[32m╬═══════════════════════════════════════╬"
        echo -e "                           \e[32m║                                       ║"
        echo -e "                           \e[32m║        \e[1mUse CMake ?                \e[0m\e[32m║"
        echo -e "                           \e[32m║     \e[1m[Type 'yes' or 'no']              \e[0m\e[32m║"
        echo -e "                           \e[32m╬═══════════════════════════════════════╬"
        echo -e "\e[0m"
        read temp
        clear

        if [ "${temp}" == "yes" ]; then
            cmake=1
            breakbcl=1
        elif [ "${temp}" == "no" ]; then
            cmake=0
            breakbcl=1
        else
            breakbcl=0
        fi
    done
}

################################################################### Main #################################################################################################################

#For to get main
main () {
    max=$(echo "30")
    if [ "$1" = "-m" ]; then
        main=$(echo "main")
        getinfo_binary
        echomake $binary $main
    elif [ "$1" = "-i" ]; then
        getinfo_include
        addinclude $include
        includeanim
    elif [ "$1" = "-l" ]; then
        addlib
        libaanim
    elif [ "$1" = "-a" ]; then
        getinfo_main
        addmain $main
        srcanim
    elif [[ "$1" = "-cm" ]]; then
            clear
            getinfo_binary
            clear
            getinfo_include
            clear
            getinfo_main
            clear
            getinfo_ignore
            clear
            if [ ! -d "$PWD/lib" ]; then
                libanim
                clear
            elif [ ! -d "$PWD/include" ]; then
                includeanim
                clear
            fi
            clear
            srcanim
            clear
            addmain
            addlib_src
            getinfo_mouli
            getinfo_push
            add_cmake
            addinclude
            mkdir build
            rm -R Makefile
    elif [[ "$1" != "" ]]; then
        gethelp
        exit 0
    else
        clear
        getinfo_binary
        clear
        getinfo_include
        clear
        getinfo_main
        clear
        getinfo_ignore
        clear
        if [ ! -d "$PWD/lib" ]; then
            libanim
            clear
        elif [ ! -d "$PWD/include" ]; then
            libanim
            clear
        fi
        addlib
        includeanim
        clear
        addinclude
        srcanim
        clear
        addmain
        echomake $binary $main
        getinfo_mouli
        getinfo_push
        rm -R *.txt
    fi
    clear
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "                           \e[32m║                                       ║"
    echo -e "                           \e[32m║           \e[1mEverything is good.         \e[0m\e[32m║"
    echo -e "                           \e[32m║            \e[1m[Press enter]              \e[0m\e[32m║"
    echo -e "                           \e[32m╬═══════════════════════════════════════╬"
    echo -e "\e[0m"
    read tmp
    clear
    bash
}

main $1


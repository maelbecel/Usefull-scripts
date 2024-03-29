# Usefull-scripts
Usefull scripts I create that I use really often.

## **Summary**

- [download_mnager.py](#download-manager) (*Keep your downloads clean*)
- [info.sh](#inforep) (*Know everything about your folder*)
- [make.sh](#launch) (*Easy project setup*)
- [norme.sh](#norme) (*Have a beautiful code*)
- [wakapi.sh](#wakapi) (*Check your coding stat*)
- [commitmoji.sh](#commitmoji) (*Add emojis to your commits*)
- [reminder.sh](#reminder) (*You will never forget anything*)

## Download Manager

### Description

This is a little python3 script that you can put in your crontab or just call it with a simple command from your .bashrc or .zshrc like that.
```
$ echo "alias dnlmanager='python3 ~/scripts/download_mnager.py'" >> .bashrc
```
or
```
$ echo "alias dnlmanager='python3 ~/scripts/download_mnager.py'" >> .zshrc
```

It will divide your *Download* folder in 6 parts :

- Images (*png, jpg, jpeg, gif, bmp, webp*)
- Audio (*mp3, wav, flac, ogg, m4a*)
- Text (*txt, doc, docx, odt,pdf, epub, html, htm, xhtml, xml, json*)
- Prinitng (*gcode, stl*)
- Programming (*py, c, cpp, cs, java, js, php, pl, rb, sh, swift, asm, s*)
- Other

It will automatically put the downloaded files in the folder associated with.

### Usage
```
$ python3 download_mnager.py
```

## Inforep

### Description
Bash script that will give you loads of information about the directory given in argument.

It will say:

- Languages uses in the folder (*With percentage for each one*)
- Number if files
- Number of directories
- Number of code lines
- Number of not code lines (*With what file type it is*)
- Number of loops
- Number of conditions

If it's a git repository, it will add:

- Date of first commit
- Date of last commit
- Number of commits
- Number of contributors
- Open issues
- Closed issues
- Total issues
- Number of branches
- Uncommited changes

If it's a C project, it will add:

- Epitech coding style checker

And if the C project have a Makefile, it will add:

- Comilation status
- Unit tests informations
- Coverage informations
- Valgrind status

It can be add to your .bashrc or your .zshrc file like that:

```
$ echo "alias inforep='~/scripts/info.sh'" >> .bashrc
```
or
```
$ echo "alias inforep='~/scripts/info.sh'" >> .zshrc
```

### Usage

```
$ ./info.sh [Folder to check](pwd by default)
```

### Example

```
$ inforep ~/my_rpg
Running on my_rpg...

---- Language ----
C : ████████████████████████████████████████████████ (96,0115%)
Makefile : █ (2,03912%)
JSON :  (1,67361%)
Python :  (0,275729%)

---- Information ----
Files : 18148.
Directories : 45.
Total : 15595 lines.
Other : 96945 lines. (.a .png .jpg .ttf .ogg .log .md)
Loops : 832.
Conditions : 1424.

---- Git info ----
First commit : Mon Mar 21 12:51:26 2022 +0100
Last commit : Thu May 12 22:25:26 2022 +0200
Number of commits : 514
Number of contributions : 7
Open issues : 7
Closed issues : 14
Total issues : 21
Number of branches : 14
Issue state : █████████████████████████████████ █████████████████ (66,6667%)
Uncommited changes : 4 files.

---- Build ----
Makefile OK

---- Unit Test ----
12 unit tests

---- Coverage ----
No coverage

---- Valgrind ----
No valgrind

---- Norme ----
Coding style error : 66
Major : 17
Minor : 47
Info : 2
Error state : ████████████ ███████████████████████████████████ █
```

## Launch

### Description

Bash script to begin your C projects more easily and faster. It will automatically :

- Create the Makefile (*With your personal lib, the binary name you want, and the files you want*)
- Also can create a CMake project (*With the -cm flag*)
- Import your lib headers
- Import your lib files
- Create the header for the project (*Protect for double inclusion*)
- Create the main file (*Including the project header and with the name you want*)
- Add a functional test file.
- Add a git ignore file (*If you want to*)
- Create the first commit (*In case of git repository*)

In case of a CMake project, it remove existing Makefile and create a CMakeLists.txt file, it also add CMakeLists for libs src and includes.

Then you just have to type ```make``` and your project will compile perfectly.

It can be add to your .bashrc or your .zshrc file like that:

```
$ echo "alias launch='~/scripts/make.sh'" >> .bashrc
```
or
```
$ echo "alias launch='~/scripts/make.sh'" >> .zshrc
```

### Usage

```
$ ./make.sh
```
### Example

```
$ ./make.sh
$ tree
.
├── build
│   └── build.py
├── include
│   ├── project.h
│   ├── lib_a.h
│   ├── lib_b.h
│   └── lib_c.h
├── lib
│   ├── lib_a
│   │   ├── lib_a.c
│   │   ├── [...]
│   │   ├── Makefile
│   │   └── lib_a.h
│   ├── lib_b
│   │   ├── lib_b.c
│   │   ├── [...]
│   │   ├── Makefile
│   │   └── lib_b.h
│   └── lib_c
│       ├── lib_c.c
│       ├── [...]
│       ├── Makefile
│       └── lib_c.h
├── Makefile
└── src
    └── main.c
```
```
$ ./make.sh -cm
$ tree
.
├── build
├── include
│   ├── project.h
│   ├── CMakeLists.txt
│   ├── lib_a.h
│   ├── lib_b.h
│   └── lib_c.h
├── CMakeLists.txt
└── src
    ├── CMakeLists.txt
    ├── lib_a
    │   ├── lib_a.c
    │   ├── [...]
    │   ├── CMakeLists.txt
    │   └── lib_a.h
    ├── lib_b
    │   ├── lib_b.c
    │   ├── [...]
    │   ├── CMakeLists.txt
    │   └── lib_b.h
    ├── lib_c
    │   ├── lib_c.c
    │   ├── [...]
    │   ├── CMakeLists.txt
    │   └── lib_c.h
    └── main.c
```
```
$ cat src/main.c
/*
** EPITECH PROJECT, 2022
** main.c
** File description:
** main
*/

#include "project.h"

int main (UNUSED int ac, UNUSED char **argv, UNUSED char **env)
{
    return 0;
}

```
```
$ cat include/project.h
/*
** EPITECH PROJECT, 2022
** project.h
** File description:
** project
*/

#ifndef PROJECT
    #define PROJECT
    #include "lib_a.h"
    #include "lib_b.h"
    #include "lib_c.h"

    #include <stdbool.h>
    #include <stddef.h>
#endif

```

## Norme

### Description

Bash script to check coding style errors based on the C Epitech Coding Style and on the Epitech Docker.

It will give you back:
- File of the error
- Line of the error
- Code of the error
- Message of the error (*If you use -v*)
And at the end :
- Number of total of errors
- Number of major errors
- Number of minor errors
- Number of information errors

It can be add to your .bashrc or your .zshrc file like that:

```
$ echo "alias norme='~/scripts/norme/norme.sh'" >> .bashrc
```
or
```
$ echo "alias launch='~/scripts/norme/norme.sh'" >> .zshrc
```

### Usage
```
$ ./norme.sh [Directory to check] (Optional -v for error messages)
```
### Exemple

```
$ ./norme.sh my_directory -v
Pulling docker for coding style checker...
Running coding style checker...

./src/main.c:10:C-L4 => Misplaced curly brackets
./src/main.c:13:C-L3 => Misplaced spaces
./src/main.c:31:C-F4 => Number of lines
./src/main.c:32:C-F4 => Number of lines
./src/main.c:33:C-F4 => Number of lines
./src/main.c:34:C-A3 => Line break at the end of file
6 coding style error(s) report: 3 major, 2 minor, 1 info.

```

## Wakapi

### Description

This is a bash integration for wakatime. This script will ask wakatime for your stat by your API URL and will show you in your terminal.
It will show you :
- Your coding time this week
- Your coding time today
- How far you are from the week average
- The week average

You just have to replace the ```apiurl``` variable with your own API URL, get the embeddable url from https://wakatime.com/share/embed/. Then select "JSON" and "Coding Activity" and click on "Get embeddable code". Finaly get the url in the AJAX code and paste it in apiurl

It can be add to your .bashrc or your .zshrc file like that:

```
$ echo "alias wakapi='~/scripts/wakapi.sh'" >> .bashrc
```
or
```
$ echo "alias wakapi='~/scripts/wakapi.sh'" >> .zshrc
```

### Usage

```
$ ./wakapi.sh
```

### Example

```
$ ./wakapi.sh
Total time coding this week: 16 hours and 18 minutes.
Total time coding today: 1 hours and 40 minutes.
████████████████████████ ██████████████████████████ -49%
Average time coding this week: 3 hours and 15 minutes  per day.

```

## Commitmoji

### Description

Commitmoji is a simple way to keep your commits clean, fun and with a good format. It's based on the [Gitmoji](https://gitmoji.dev/) project and on the [Karma format](https://karma-runner.github.io/0.8/dev/git-commit-msg.html). It's a bash script that will ask you for a commit message and will add an emoji at the beginning of your commit message. It will also add and push your files. You just have to say what you want to commit and it will do it.

It can be add to your .bashrc or your .zshrc file like that:

```
$ echo "alias commitmoji='~/scripts/commitmoji/commitmoj.sh'" >> .bashrc
```
or
```
$ echo "alias commitmoji='~/scripts/commitmoji/commitmoj.sh'" >> .zshrc
```

### Usage

```
$ ./commitmoji.sh -h
Usage: ./commitmoji.sh [OPTIONS]
       OPTIONS           -h: Display this help
                         -a: Commit as --amend
                         -m [branch to merge][with (default main)]: Merge two branches
                         -w: automatise commit message from whatthecommit.com
                         -wm: automatise commit message from whatthecommit.com and add music at commit
                         -j: automatise commit message with a meme
                         -c: automatise commit message using ChatGPT, remember to
                             add your API key at ~/scripts/commitmoji/chatgptapiKey
Types:
       feat
       fix
       docs
       style
       refactor
       test
       compiler
       performances
       deployment
       security
       remove
       configuration
       badcode
       rename
       assets
       comment
       accessibility
       drunk
       architecture
       easteregg
       gitignore
       errorhandle
       permissions

```

If you don't wanna add issues or messages, just press enter to continue.

### Example

```
$ ./commitmoji.sh
Type of commit: feat
Files: commitmoji/commitmoji.sh
Message : Add autopush possibilty
Issues : 6
In Work ? (y/n) : n

Execute command: (git add commitmoji/commitmoji.sh && git commit -m "✨ (commitmoji/commitmoji.sh): Add autopush possibilty [#6]") ? (y/n) : y
Sucess
Push it ? (y/n) : y
Sucess
```

## Reminder

### Description

Reminder will remind you of things you don't wanna forgot when you're working, you just have to say what do you wanna be reminded of and when. It will ask you for a message and a time and will remind you of it when the time is over.

It can be add to your .bashrc or your .zshrc file like that:

```
reminder () {
    while true; do
        if [ "$(date +%S)" == "00" ]; then
            ~/scripts/reminder/reminder.sh -c 2>/dev/null
            sleep 1
        fi
    done
}
alias remind="~/scripts/reminder/reminder.sh"

```

### Usage

You just need ```kdialog``` to use this script.

```$ sudo apt install kdialog``` or ```$ sudo dnf install kdialog```

```kdialog``` is really useful for creating popup.


```
$ ./reminder.sh -h
Usage: ./reminder.sh [OPTIONS]

OPTIONS           -h: Display this help
                  -a: Add a reminder
                  -d: Delete a reminder
                  -l: List all reminders
                  -r: Remove all reminders
                  -c: Check for reminders
                  -p: Check for old reminders
                  -o: Delete old reminders
```

### Example

```
$ ./reminder.sh -a
Add a reminder
Enter the reminder:
Courses
Enter the date (YYYY-MM-DD):
2022-10-19
Enter the time (HH:MM):
17:50
Reminder added
```

```
$ ./reminder.sh -l
List all reminders
[Today]  1 2022-10-19 17:50 Courses
[Now]  2 2022-10-19 11:59 A table
[Future] 3 2022-10-20 11:59 Resto boulot
[Old]    4 2022-10-18 16:00 Gouter
```


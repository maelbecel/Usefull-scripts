# Usefull-scripts
Usefull scripts that I use really often.

## **Summary**

- [download_mnager.py](#download-manager) (*Keep your downloads clean*)
- [info.sh](#inforep) (*Know everything about your folder*)

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

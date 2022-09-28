# Usefull-scripts
Usefull scripts that I use really often.

## **Summary**

- download_mnager.py (*Keep your downloads clean*)

### download_mnager.py

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

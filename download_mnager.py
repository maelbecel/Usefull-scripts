################
## Download Manager
## github.com/maelbecel
################

import os

images = ["png", "jpg", "jpeg", "gif", "bmp", "webp"]
audio = ["mp3", "wav", "flac", "ogg", "m4a"]
text = ["txt", "doc", "docx", "odt", "pdf", "epub", "html", "htm", "xhtml", "xml", "json"]
printing = ["gcode", "stl"]
downloading = ["crdownload", "part"]
programming = ["py", "c", "cpp", "cs", "java", "js", "php", "pl", "rb", "sh", "swift", "xml", "asm", "s"]
files = [f for f in os.listdir("/home/mbecel/Downloads")]
nottouch = [".", "..", "audio", "text", "programming", "printing", "other", "images"]
notif = "notify-send --urgency=low -i /usr/share/icons/gnome/256x256/status/stock_dialog-warning.png 'Download Manager' \""

for elm in files:
  if (elm in nottouch or elm.split(".")[-1] in downloading):
    continue
  if (os.path.isfile(elm) == False):
      os.system(f"cp -r /home/mbecel/Downloads/'{elm}' /home/mbecel/Downloads/other/ && rm -rf /home/mbecel/Downloads/'{elm}'")
      os.system(notif + f"{elm} already move to other folder\"")
      continue
  file = elm.split(".")
  if (file[-1] in audio):
    os.system(f"mv /home/mbecel/Downloads/'{elm}' /home/mbecel/Downloads/audio/")
    os.system(notif + f"{elm} already move to audio folder\"")
  elif (file[-1] in text):
    os.system(f"mv /home/mbecel/Downloads/'{elm}' /home/mbecel/Downloads/text/")
    os.system(notif + f"{elm} already move to text folder\"")
  elif (file[-1] in printing):
    os.system(f"mv /home/mbecel/Downloads/'{elm}' /home/mbecel/Downloads/printing/")
    os.system(notif + f"{elm} already move to printing folder\"")
  elif (file[-1] in programming):
    os.system(f"mv /home/mbecel/Downloads/'{elm}' /home/mbecel/Downloads/programming/")
    os.system(notif + f"{elm} already move to programming folder\"")
  elif (file[-1] in images):
    os.system(f"mv /home/mbecel/Downloads/'{elm}' /home/mbecel/Downloads/images/")
    os.system(notif + f"{elm} already move to images folder\"")
  else:
    os.system(f"cp -r /home/mbecel/Downloads/'{elm}' /home/mbecel/Downloads/other/ && rm -r /home/mbecel/Downloads/'{elm}'")
    os.system(notif + f"{elm} already move to other folder\"")
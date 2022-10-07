import os,random
from PIL import Image, ImageDraw, ImageFont
import datetime
import subprocess

window = [1920, 1080]

def get_time(time : str):
    if (time < 10):
        return "0" + str(time)
    else:
        return str(time)

now = datetime.datetime.now()


file = random.choice(os.listdir("/home/mbecel/scripts/pimp_bg/images/"))
os.system(f"cp ~/scripts/pimp_bg/images/{file} ~/scripts/pimp_bg/bg.png")
background = Image.open("/home/mbecel/scripts/pimp_bg/bg.png")
font_path = "/home/mbecel/scripts/pimp_bg/Timeless.ttf"

out = subprocess.Popen(['/bin/bash', '/home/mbecel/scripts/pimp_bg/scripts/getplace'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
stdout, stderr = out.communicate()
print(stdout.decode('ASCII'))


font = ImageFont.truetype(font=font_path, size=110)
ImageDraw.Draw(background).text((1450, 40), f"{get_time(now.hour)}:{get_time(now.minute)}", (255, 255, 255), font=font)

font = ImageFont.truetype(font=font_path, size=18)
ImageDraw.Draw(background).text((1750, 50), f"{stdout.decode('ASCII')}", (255, 255, 255), font=font)


background.save("/home/mbecel/scripts/pimp_bg/bg.png")
os.system(f'gsettings set org.gnome.desktop.background picture-uri "file:///home/mbecel/scripts/pimp_bg/bg.png"')
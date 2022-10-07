import os,random
from this import d
from PIL import Image, ImageDraw, ImageFont
import datetime
import subprocess

window = [1920, 1080]

def get_wind_dir(angle):
    dir = "W"
    if (angle > 0):
        dir = "W"
    if (angle > 23):
        dir = "SW"
    if (angle > 68):
        dir = "S"
    if (angle > 113):
        dir = "SE"
    if (angle > 158):
        dir = "E"
    if (angle > 203):
        dir = "NE"
    if (angle > 248):
        dir = "N"
    if (angle > 293):
        dir =  "NW"
    if (angle > 338):
        dir = "W"
    return dir


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


# Show hour
font = ImageFont.truetype(font=font_path, size=110)
ImageDraw.Draw(background).text((1450, 40), f"{get_time(now.hour)}:{get_time(now.minute)}", (255, 255, 255), font=font)

# Show Info ip
font = ImageFont.truetype(font=font_path, size=18)
ImageDraw.Draw(background).text((1750, 50), f"{stdout.decode('ASCII')}", (255, 255, 255), font=font)

# Show tiempo
out = subprocess.Popen(['/bin/bash', '/home/mbecel/scripts/pimp_bg/scripts/gettemp'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
stdout, stderr = out.communicate()
print(stdout.decode('ASCII').split(" "))
list_temp = stdout.decode('ASCII').split(" ")
out = subprocess.Popen(['/bin/bash', '/home/mbecel/scripts/pimp_bg/scripts/gettempmoy'], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
stdout, stderr = out.communicate()
print(stdout.decode('ASCII'))
if (list_temp[0] != "No"):
    font = ImageFont.truetype(font=font_path, size=60)
    ImageDraw.Draw(background).text((1745, 200), f"{list_temp[0]}°C", (255, 255, 255), font=font)
    font = ImageFont.truetype(font=font_path, size=18)
    ImageDraw.Draw(background).text((1500, 190), f"Rain: {list_temp[1]}mm", (255, 255, 255), font=font)
    ImageDraw.Draw(background).text((1500, 210), f"Cloud: {list_temp[2]}%", (255, 255, 255), font=font)
    ImageDraw.Draw(background).text((1500, 230), f"Wind speed: {list_temp[3]} km/h", (255, 255, 255), font=font)
    ImageDraw.Draw(background).text((1500, 250), f"Wind direction: {list_temp[4]}° ({get_wind_dir(int(list_temp[4]))})", (255, 255, 255), font=font)

    ImageDraw.Draw(background).line([(1730, 10), (1730, 300)], fill=(255, 255, 255), width=10)
    ImageDraw.Draw(background).line([(1450, 170), (1900, 170)], fill=(255, 255, 255), width=10)




background.save("/home/mbecel/scripts/pimp_bg/bg.png")
os.system("cp /home/mbecel/scripts/pimp_bg/bg.png /home/mbecel/scripts/pimp_bg/current_bg.png")
os.system(f'gsettings set org.gnome.desktop.background picture-uri "file:///home/mbecel/scripts/pimp_bg/current_bg.png"')
import json
import os
import subprocess

WORKSHOP_DIR = '~/.local/share/Steam/steamapps/workshop/content/431960'
screen = subprocess.run('hyprctl monitors | grep Monitor', shell=True, stdout=subprocess.PIPE, text=True).stdout.split(' ')[1]

# read every top-level directory in the workshop content path
root_dir = os.path.expanduser(WORKSHOP_DIR)
wallpaper_dirs = []
for dir in os.listdir(root_dir):
    if os.path.isdir(root_dir + '/' + dir):
        wallpaper_dirs.append(root_dir + '/' + dir)
print(f'Found {len(wallpaper_dirs)} wallpapers')

wallpapers = []
class Wallpaper:
    def __init__(self, name, path, preview):
        self.name = name
        self.path = path
        self.preview = preview

for wallpaper_dir in wallpaper_dirs:
    with open(wallpaper_dir + '/project.json') as f:
        data = json.load(f)
        wallpapers.append(Wallpaper(data['title'], wallpaper_dir, f'{wallpaper_dir}/{data["preview"]}'))



result = subprocess.run(['gum', 'choose'] + list(map(lambda x: x.name, wallpapers)), stdout=subprocess.PIPE, text=True)
wallpaper = list(filter(lambda x: x.name == result.stdout, wallpapers))[0]


if result.returncode == 0:
    print(f'You selected {result.stdout}')
    wall_id = wallpaper.path.split('/')[-1]
    print(f'Setting wallpaper to {wallpaper.name}')
    subprocess.run('pkill linux-wallpaper', shell=True)
    subprocess.run(['hyprctl', 'dispatch', 'exec', f'linux-wallpaperengine --screen-root HDMI-A-1 {wall_id}'])


from libqtile import hook
import subprocess

def auto_start():
    subprocess.Popen(['notify-send', 'Picom loaded.'])
    subprocess.Popen(['picom', '--config', '/home/libardi/.config/qtile/picom/picom.conf'])

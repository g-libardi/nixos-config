import os
import subprocess



def setup():
    subprocess.run(["notify-send", "\"Styles loaded.\""]) 
    # dark theme configuration
    # for gtk
    subprocess.run(["gsettings", "set", "org.gnome.desktop.interface", "gtk-theme", "adwaita-dark"])
    subprocess.run(["gsettings", "set", "org.gnome.desktop.interface", "color-scheme", "prefer-dark"])
    # for qt
    os.environ["QT_QPA_PLATFORMTHEME"] = "qt6ct"

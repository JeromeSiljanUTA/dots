"""Change theme to to dark/light mode.
"""
import re
import os
import configparser
import subprocess
import shutil

LIGHT_FG = '"#3C3836"'
LIGHT_BG = '"#FBF1C7"'
LIGHT_ICONS = "Gruvbox-Light"
LIGHT_GTK3_THEME_NAME = "Adwaita"
DARK_FG = '"#EBDBB2"'
DARK_BG = '"#282828"'
DARK_ICONS = "Gruvbox-Dark"
DARK_GTK3_THEME_NAME = "Adwaita-Dark"

DUNST_CONFIG_PATH = "~/.config/dunst/dunstrc"
XSETTINGSD_CONFIG_PATH = "~/.config/xsettingsd/xsettingsd.conf"
ROFI_CONFIG_PATH = "~/.config/rofi/"
GTK3_CONFIG_PATH = "~/.config/gtk-3.0/settings.ini"


def restart_ps(ps: str):
    # Kill existing process and restart in the background.
    kill_command = f"killall {ps}"
    start_command = f"{ps} &"

    try:
        subprocess.run(kill_command, shell=True, check=True)
        print(f"{ps} killed successfully.")
    except subprocess.CalledProcessError:
        print(f"No {ps} process found to kill.")

    subprocess.Popen(start_command, shell=True)
    print(f"{ps} restarted in the background.")


def replace_dunst_config(theme: str):
    # Replace background, foreground variables in dunst config based on theme.
    config = configparser.ConfigParser()
    conf_path = os.path.expanduser(DUNST_CONFIG_PATH)

    config.read(conf_path)

    if theme == "dark":
        config.set("global", "background", DARK_BG)
        config.set("global", "foreground", DARK_FG)
        config.set("global", "icon_theme", DARK_ICONS)
    else:
        config.set("global", "background", LIGHT_BG)
        config.set("global", "foreground", LIGHT_FG)
        config.set("global", "icon_theme", LIGHT_ICONS)

    with open(conf_path, "w") as conf_file:
        config.write(conf_file)


def update_dunst(theme: str):
    # Update dunst configuration.
    replace_dunst_config(theme)
    restart_ps("dunst")


def replace_xsettings_config(theme: str):
    # Replace xsettings config and update GTK theme.
    conf_path = os.path.expanduser(XSETTINGSD_CONFIG_PATH)
    with open(conf_path, "w") as conf_file:
        conf_file.write(f'Net/ThemeName "gruvbox-{theme}-medium-blue"')


def update_xsettingsd(theme: str):
    # Update xsettingsd configuration
    replace_xsettings_config(theme)
    restart_ps("xsettingsd")


def replace_rofi_config(theme: str):
    # Replace rofi config based on theme.
    conf_dir_path = f"{os.path.expanduser(ROFI_CONFIG_PATH)}"
    conf_path = f"{os.path.expanduser(ROFI_CONFIG_PATH)}config.rasi"
    target_path = f"{conf_dir_path}gruvbox-{theme}.rasi"
    print(conf_path)
    print(target_path)
    shutil.copyfile(target_path, conf_path)


def replace_gtk3_config(theme: str):
    # Replace gtk3 config based on theme.
    config = configparser.ConfigParser()
    conf_path = os.path.expanduser(GTK3_CONFIG_PATH)

    config.read(conf_path)

    if theme == "dark":
        config.set("Settings", "gtk-theme-name", DARK_GTK3_THEME_NAME)
    else:
        config.set("Settings", "gtk-theme-name", LIGHT_GTK3_THEME_NAME)

    with open(conf_path, "w") as conf_file:
        config.write(conf_file)

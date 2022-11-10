# Welcome to the rice farms
This is mainly to help Chris set stuff up

## Step 1: Get stuff working
Seriously lol just have an install sheesh

Here's something you need to understand. In Linux speech, we don't have "apps", but "packages". Packages have dependencies, which are just other packages that are needed. 

For example, Firefox might need to make use of a GUI toolkit (gtk) in order to work. Because of that, gtk is a dependency. 

95% of the time, `pacman` will resolve dependency issues for you, but in case you see something like `x not working because missing y`, you know to just `pacman -S y` in order to get things working.

### Configuration
Nearly everything configuration wise is done by editing files in Linux. You need to get comfortable with editing files and following whatever configuration syntax they need (you'll pick it up fast)

## Step 2: Gather useful packages
You'll need a terminal emulator to get things done (the cool way). I recommend `alacritty`. I will also be configuring `alacritty` throughout this guide. 

`firefox` and `rofi` are also good choices. `rofi` is an application menu type thing. `man-db` will allow you to see manual pages of programs.

Install those.

## Step 3: GUI
In Linux, you have desktop environments (GNOME, KDE, XFCE, etc.) and window managers (i3, bspwm, sway, etc.). DEs include a bunch of stuff like brightness control, notification bars, etc. whereas window managers only manage your windows. 

I will be using `bspwm` in this guide because it's easy to hack (you'll see what I mean later)

## Brightness control
You probably want to get `xorg-xbacklight` and run `xbacklight -set 20` so that you can actually turn down your brightness. I'll come back to this in a bit, but you can try to set up brightness controls with `sxhkd`. It's not too hard, so you can probably figure it out. 

## Step 4: `bspwm` and `sxhkd`
The `bspwm` guy made `sxhkd` so that you can deal with key binds in `sxhkd` and window events with `bspwm`. I highly recommend skimming through the wiki when you set anything up because that can help you avoid issues. 

Install both of those programs and let's get started. 

So far, I'm assuming you've been in the terminal a lot. That's good. 

We want to edit a couple files now. First, let's make subdirectories `~/.config/bspwm` and `~/.config/sxhkd`. (`~/` is shorthand for `/home/user` and honestly it's great). Yes I did parenthesis as a whole sentence. Oh well. Anyways, go ahead and edit a file at `~/.config/bspwm/bspwmrc`. I'll do this in vim, but do whatever you want. 

### `bspwmrc`
This file runs every time you start up `bspwm`. The first line should be `#!/bin/bash`. This makes sure that we're executing everything in the bash shell. You can think of it to be analogous to selecting a python interpreter.

At the very least, we'd like to start up `sxhkd` to deal with keyboard events, so add `sxhkd &` to start `sxhkd` and get on to the next thing (by the way, `&` forks and goes to the new line, so you can do some interesting multithreaded stuff with that). 

Because we run this file every time `bspwm` starts, we need to give it executable permissions. This just means that unlike normal files, we can run this as bash. That's a good protection from malware. You can think of it to be like an `.exe` in Windows. Just like how in Windows, you have a little box pop up when you click on an `.exe` asking you if you want to run something, we have to set stuff as executable. That can be accomplished with `chmod 755 bspwmrc`.

For the rest of the config stuff, I'll refer you to `man bspwm` and the Arch wiki. It has some good stuff in it. I'll comment stuff in my `bspwmrc` so that you get what's going on. It's pretty simple, but ask me questions if you get stuck.

### `bspc` 
This is a program that interacts with `bspwm`. You can give it commands in real time and it'll update your window manager. It does everything. `man bspc` to find out the details.

### Multi Monitors
Might need to consult the wiki on this, I can't do it now because I'm going to be mainly on campus for the next couple days. I'll show you set up for your laptop first. 

### Desktops
Desktops are like tiling window managers in Windows. They're the core of the workflow, you'll get the hang of them soon enough. 

### `sxhkd`
Here comes the fun stuff. Look at `man sxhkd` for the syntactical details and the comments I'll leave you. I think it's intuitive enough but ask me questions if you need help.

### `feh`
Go ahead and install `feh`. As a challenge, figure out how to set your wallpaper with it. 

You should now have a bare `bspwm` setup. We'll come back to it later, but this is good enough for me to move on to setting up `alacritty`

### `alacritty`
Just open up my `alacritty.yml` and look at the comments.

Install `ttf-ibm-plex`.

### `rofi`
Again copy config over and look at the stuff. I did this over like a week haha it's easier to read and understand than start from scratch.
 Low key I'll set up a git repo with this and you can do pull requests and we can have an epic gruvbox setup.

### GTK Themes
Go ahead and do `yay gruvbox`. Select 7. Then install `lxappearance-gtk3` and set your gtk theme to gruvbox. Thank me later.

## Step 4: Notifications
### `dunst` 
I use `dunst` to run my notifications. Honestly it's pretty darn good and I have a setup that uses no toolbar (I find it distracting). If you want a toolbar, I can show you how to set one up, but I'd invite you to give this option a try. 

Install `dunst`

Note that it's added in the `bspwmrc`. This is because we need to start notifications when we start up our window manager.

I like my notifications and system stuff with Jost, which can be yayed.

## Step 0: Other stuff
### Lowercase Directory Names
I prefer them because it makes it easier to go through stuff on the command line. You have a couple of "default" directories like Downloads, Desktop, etc. You can rename those by installing `xdg-user-dirs`. You can see my `user-dirs.dirs` file and see what I've changed. You'll then want to create the directories you want (eg. desktop, downloads, etc.) and run `xdg-user-dirs-update
`

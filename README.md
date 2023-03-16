# LilyPad
LilyPad is a helper tool that assists when using the [Fennel](https://fennel-lang.org/) programming language in Roblox Studio!
It pairs best with Rojo, as it specifically searches the `./src` directory for `.fnl` files and compiles them to `.lua` files as they change.
Rojo then takes these compiled `.lua` files and syncs them into Roblox Studio. Boom! You can now program Roblox games with a language other than Lua!

## Features
* Automatically watches all `.fnl` files in the `./src` directory and tracks for changes
* Automatically compiles files when they are changed

## Install
### Releases
Simply grab the executable from the [releases](https://github.com/Jamtoad/LilyPad/releases) section and place it in your PATH or wherever you'd like!

## Usage
```lua
Usage: lilypad [COMMAND] [FLAGS]

Manages the development workflow when using the Fennel Programming Language in
Roblox Studio

COMMANDS
    start       :Watches the all the Fennel files in ./src and compiles them to Lua.
                 Places compiled files in the same directory as the target file.
FLAGS
    --version   :Shows the current build version of lilypad.
    --help      :Shows this help text.
```

## Name
I chose LilyPad because my whole GitHub has a "swampy" theme going on. LilyPads are also the backbone/support for a lot of wildlife in swamps. So, LilyPad in this case is the backbone of your Roblox Studio workflow!

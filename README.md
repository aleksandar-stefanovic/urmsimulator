# urmsimulator
Exercise in Vala and publishing to elementary OS's AppCenter.

[![Get it on AppCenter](https://appcenter.elementary.io/badge.svg)](https://appcenter.elementary.io/com.github.aleksandar-stefanovic.urmsimulator)

![Screenshot](data/screenshot.png)

## Current features
 - Executes URM code correctly
 - Ability to load a file
 - Ability to manually set initial values
 - Ability to set execution cap (to avoid infinite loops)
 - When in debug mode, shows the result after each instruction
 - Upon finishing, shows the state of all the used registers
 - Has basic sythax highlighting


## Planned features
 - Graph representation
 - Help and documentation
 - Saving files

## Dependencies

These are the required build dependencies:

```
gtk+-3.0
gtksourceview-3.0
```

## Building

Execute these commands in the root of the project:

```
meson build --prefix=/usr
cd build
ninja
```



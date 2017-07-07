# urmsimulator
Exercise in Vala and publishing to elementary OS's AppCenter.

![Screenshot](data/screenshot.png)

## Dependencies

These are the required build dependencies:

```
gtk+-3.0
granite
gtksourceview-3.0
```

## Building

Execute these commands in the root of the project:

```
mkdir build
cd build
cmake .. -DCMAKE_INSTALL_PREFIX=/usr
make
```



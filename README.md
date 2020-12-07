# ReXeTeXeR
<div style="text-align:center;">

![GitHub](https://img.shields.io/github/license/terfno/rexetexer) ![GitHub repo size](https://img.shields.io/github/repo-size/terfno/rexetexer) ![GitHub last commit](https://img.shields.io/github/last-commit/terfno/rexetexer)

</div>

----

![img](./design/logo.png)

<div style="text-align:center;">awesome cool logo</div>

----

## What is this?
![img](design/img.png)

Its compile Japanese (you can use English) TeX file to PDF without TeX Live on your local machine.
Just required Docker.
It include pBibTeX.

### variation
* For National Institute of Technology, Tsuyama College: [ReXeTeXeR-tsuyama](https://github.com/Terfno/ReXeTeXeR-tsuyama)

## 環境
- Required
  - Docker (or Podman)
- Optional
  - GNU Make
  - Text editor
  - PDF viewer (Skim)

## How to use
### 0. Preparation
Download the latest version from [releases](https://github.com/Terfno/ReXeTeXeR/releases).
Then, unzip the .zip file.

```
.
├── LICENSE
├── Makefile
├── NotoSansJP-Regular.otf
├── NotoSerifJP-Regular.otf
├── README.md
├── RobotoMono.ttf
├── img
│   └── logo.png
├── ref.bib
├── report.pdf
├── report.tex
└── watch.sh
```

After that, run below command at directory where you unzip.
```sh
$ make init
```

#### If you want to use Podman.
If you want to use Podman, you should read and run as follows.
```sh
# General
$ make podman.${TARGET}

# Example: Run `make init` with Podman
$ make podman.init
```

### 1. Launch
```sh
$ make run
```

### 2. Connect
```sh
$ make exec
```
After run this command, your terminal will connect to the container.
The following commands are executed in a container.

### 3. Launch auto compile script
```sh
$ make watch
```

#### If you want to compile just 1 time.
```sh
$ make tex
```

### 4. Write TeX
After `make watch`, edit `. /report.tex` will automatically generate a pdf.
TeX Engine is XeTeX/XeLaTeX, see `./report.tex`.

### 5. View PDF
Open `./report.pdf` with Skim or your favorite PDF viewer.

### 6. Tips
#### Can be incompatible with Auto Save (VS Code)
Auto Save, such as VS Code, can cause incomplete `.tex` files to be compiled because it detects changes in the file and runs the compilation.

This can be resolved by setting `.vscode` to set Auto Save to `onFocusChange` for this workspace only.
Or you can also solve this problem by extending the monitoring interval of watch.sh from 1 to about 5 seconds.

#### PDF Viewer that supports auto-reload of resources
- macOS: [Skim](https://skim-app.sourceforge.io/)
- windows10: [Sumatra PDF](https://www.sumatrapdfreader.org/)
- Linux: [Evince](https://wiki.gnome.org/Apps/Evince)

#### If you want to stop this system.
Exit container(`$ exit`), and run below commands.
```sh
$ make stop
```

If you want to relaunch the system, use `$ make start`.

If you want to delete container, run below commands. (It's not delte image. Safe.)
```sh
$ make rm
```

If you want to delete image, run below commands.
```sh
$ make rmi
```

## thx
- junsrt.bst: http://mirror.las.iastate.edu/tex-archive/biblio/pbibtex/base/junsrt.bst
- BXjscls: https://github.com/zr-tex8r/BXjscls

### Support me!
<a href="https://www.buymeacoffee.com/terfno" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

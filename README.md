# texDocker
おれはxetexが好き

## 環境
* make
* docker
* docker-compose
* そこそこ速いインターネット
* 自動リロードに対応したPDFビューワー
  * macOS: [Skim](https://skim-app.sourceforge.io/)
  * windows10: [Sumatra PDF](https://www.sumatrapdfreader.org/)
  * Linux: [Evince](https://wiki.gnome.org/Apps/Evince)

## 使い方
1. `/docs/` に `report.tex` を置きます。
2. `report.tex` に色々書きます。
3. `/docs/` に `ref.bib` を置きます。
4. `ref.bib` に参照した論文とか、記事を書きます。
5. `$ make up` でdocker-composeを使用して `.tex→.pdf` をやります。
6. `report.pdf` を自動リロードに対応したPDFビューワーで開きます。
7. **未実装**: そのうち監視自動ビルド機能が追加されるので書いたらリアルタイムに、PDFになります。
8. **未実装**: texファイルに構文エラーがあるとビルドが止まる。どうにかする。

## やりたいこと
* `*.tex` を `*.pdf` に変換して吐き出すDockerコンテナーを錬成するDockerfileを書きたい

## やること
* [x] とりあえずTeXの環境をDockerコンテナー内に作る
  * [x] alpine pull
  * [x] xetex install
* [x] ローカルの `*.tex` をコンテナー内にコピーするように変更する→volumesで実装
* [x] コンテナー内にコピーした `*.tex` を `*.pdf` に変換させる
* [x] 変換した `*.pdf` をローカルに吐き出させる
* [x] bibtex対応
* [x] ローカルの `*.pdf` をプレビューする
* [ ] OMakeかなんかで監視してビルド

## memo
```sh
# kpsewhich -var-value=TEXMFHOME
/root/texmf
```

```sh
apk update
apk search
apk add -U --progress -ul --no-cache {{.name}}
```

```sh
xelatex {{.name_of_tex}}.tex
```
これで`{{.name_of_tex}}.pdf`と`{{.name_of_tex}}.log`と`{{.name_of_tex}}.aux`が錬成される

```sh
find / -type f -name "*.ttf"
find / -type f -name "*.otf"
```
これでinstalled fontのlistがとれる

```sh
xelatex report.tex && pbibtex report.aux && xelatex report.tex && xelatex report.tex
```
これでbibtex(pbibtex)に対応したpdfを吐き出せる

## font
Google Fonts

### Courier_Prime
SIL license

レギュラーとイタリック、ボールドを用意

### Gelasio
SIL license

レギュラーとイタリック、ボールドを用意

### Noto Sans JP
SIL license

レギュラーとボールドを用意

### Noto Serif JP
SIL license

レギュラーとボールドを用意

### Roboto
Apache license 2.0

レギュラーとイタリック、ボールドを用意

## pack
* cite.sty: mirrors.ctan.org/macros/latex/contrib/cite/cite.sty
* junsrt.bst: http://mirror.las.iastate.edu/tex-archive/biblio/pbibtex/base/junsrt.bst

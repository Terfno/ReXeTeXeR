# ReXeTeXeR
<div style="text-align:center;">

![GitHub](https://img.shields.io/github/license/terfno/rexetexer)  ![GitHub repo size](https://img.shields.io/github/repo-size/terfno/rexetexer)  ![GitHub last commit](https://img.shields.io/github/last-commit/terfno/rexetexer)

</div>

> *ReXeTeXeR*、逆から読んでも*ReXeTeXeR*  - 2019 terfno

![img](./design/logo.png)
<div style="text-align:center;">マジでかっこいいロゴっぽいやつ</div><br>

## これはなに
![img](design/img.png)
<div style="text-align:center;">動作イメージ(スクショは開発中のもの)</div><br>

日本語の `.tex` (UTF-8) をTeXの環境構築なしに、XeTeX(xelatex)を使って `.pdf` に変換するDockerのコンテナーを作れるファイル群です。勝手に**ReXeTeXeR**と名前をつけました。pBibTeXによるReferenceの自動生成に対応してます。

## そのうちできること
`docs/report.tex` の更新を監視して自動で `.pdf` に変換すること。→ 自動リロードに対応したPDFビューワーを使うことで、`.tex` を `.pdf` でプレビューしながら書けるようになるはずです。

## 現状用意しなければならない環境
* docker
* docker-compose
* そこそこ速いインターネット

### あるとうれしいもの
* GNU Make
* 自動リロードに対応したPDFビューワー
  * macOS: [Skim](https://skim-app.sourceforge.io/)
  * windows10: [Sumatra PDF](https://www.sumatrapdfreader.org/)
  * Linux: [Evince](https://wiki.gnome.org/Apps/Evince)

## 使い方
1. `/docs/` に `report.tex` を置きます。
2. `report.tex` に色々書きます。

```tex
\documentclass[a4paper]{article}
\XeTeXlinebreaklocale "ja"
\usepackage{xltxtra}

% fonts
\usepackage{fontspec}
\setmainfont[Scale=MatchLowercase]{NotoSerifJP-Regular}
\setsansfont[Scale=MatchLowercase]{NotoSansJP-Regular}
\setmonofont[Scale=MatchLowercase]{CourierPrime-Regular}

% bibtex
\usepackage{cite}

\begin{document}

  \title{test}
  \author{terfno}
  \maketitle

  \section{はじめに}
  {\XeTeX} でいい感じにするやつです。

  数式テスト
  \begin{eqnarray}
    2x_1 + x_2 & = & 5 \nonumber \\
    2x_2 & = & 2 \nonumber
  \end{eqnarray}

  引用テスト\cite{lecun2015deep}

  % bibtex
  \bibliographystyle{junsrt}
  \bibliography{ref.bib}

\end{document}

```
<div style="text-align:center;"> /docs/report.tex</div><br>

3. `/docs/` に `ref.bib` を置きます。
4. `ref.bib` に参照した論文とか、記事を書きます。

```bib
@article{lecun2015deep,
  title={Deep learning},
  author={LeCun, Yann and Bengio, Yoshua and Hinton, Geoffrey},
  journal={nature},
  volume={521},
  number={7553},
  pages={436--444},
  year={2015},
  publisher={Nature Publishing Group}
}
```
<div style="text-align:center;"> /docs/ref.bib</div><br>

5. `$ make up` でdocker-composeを使用してコンテナーを建てます。
6. `$ make exec` でコンテナーに入ります。
7. `# xelatex report.tex && pbibtex report.aux && xelatex report.tex && xelatex report.tex` をコンテナー内で実行すると `/docs/` に `.pdf` が吐き出されます。
8. `report.pdf` を自動リロードに対応したPDFビューワーで開いておきます。
9. **未実装**: そのうち監視自動ビルド機能が追加されるので書いたらリアルタイムに、PDFになります。
10. **未実装**: texファイルに構文エラーがあるとビルドが止まる。どうにかする。

## `/font`について
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

## `/pack`について
Referenceを表示するのに必要だった`cite.sty`と`junsrt.bst`が置いてあります。今後必要なライブラリがあれば、ここを使用してコンテナー内に配置する予定です。

* cite.sty: mirrors.ctan.org/macros/latex/contrib/cite/cite.sty
* junsrt.bst: http://mirror.las.iastate.edu/tex-archive/biblio/pbibtex/base/junsrt.bst


## memo
### やりたいこと
* `*.tex` を `*.pdf` に変換して吐き出すDockerコンテナーを錬成するDockerfileを書きたい

### やること
* [x] とりあえずTeXの環境をDockerコンテナー内に作る
  * [x] alpine pull
  * [x] xetex install
* [x] ローカルの `*.tex` をコンテナー内にコピーするように変更する→volumesで実装
* [x] コンテナー内にコピーした `*.tex` を `*.pdf` に変換させる
* [x] 変換した `*.pdf` をローカルに吐き出させる
* [x] bibtex対応
* [x] ローカルの `*.pdf` をプレビューする
* [x] 画像のテスト
* [x] OMakeかなんかで監視してビルド→shとmakeでできた
* [ ] ライセンスの整備
* [ ] ドキュメントの整備
* [ ] 公開記事の整備

### command
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

## 自動で監視してビルド
https://qiita.com/tamanobi/items/74b62e25506af394eae5

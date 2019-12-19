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

## 使い方
0. ReXeTeXeRのために簡単な環境構築をする
1. 自分の作業用ディレクトリに移動する
2. ReXeTeXeRをcloneする
3. Dockerのコンテナを走らせる
4. コンテナに入る
5. `/docs`にある`report.tex`を監視するコマンドをコンテナ内で実行する
6. `/docs`以下にある`ref.bib`と`report.tex`を編集する
7. `report.tex`が更新されると`report.pdf`も自動で更新される
8. 自動リロードに対応したPDFビューワーを使って`report.pdf`を開く
9. `report.tex`がほぼほぼリアルタイムにPDFでプレビューされる
10. うれしいね:smile:



### 0. ReXeTeXeRのために簡単な環境構築をする
#### 用意するもの
* Git
* Docker
* docker-compose
* そこそこ速いインターネット
* 安定した電源

#### やること
環境があるかどうか確認しましょう。

terminal
```sh
$ git version
$ docker version
$ docker-compose version
```

なければ環境構築してください。

### 1. 自分の作業用ディレクトリに移動する
`.tex`をメインで書いているディレクトリに移動してください。
以下は私の場合です。

terminal
```sh
$ cd Documents/git/
```

### 2. ReXeTeXeRをcloneする
このReXeTeXeRをcloneしましょう。

terminal
```sh
$ git clone https://github.com/Terfno/ReXeTeXeR.git
```

cloneできたらいい感じに名前を変えて`.git`を削除するなりしてください。`.tex`をGitで管理する場合は自分のリポジトリにpushできるように設定してください。

### 3. Dockerのコンテナを走らせる
#### GNU Make がある場合
GNU Makeがある場合は以下のコマンドでいけます。
詳細は`Makefile`を読んでください。

terminal
```sh
$ make up
```

#### docker-composeのコマンドを叩く場合
terminal
```sh
$ docker-compose up -d --build
```

オプションは自分で変えても大丈夫です。

### 4. コンテナに入る
#### GNU Makeがある場合
GNU Makeがある場合は以下のコマンドでいけます。
詳細は`Makefile`を読んでください。

terminal
```sh
$ make exec
```

#### Dockerのコマンドを叩く場合
terminal
```sh
$ docker exec -it tex-docker sh
```

### 5. `/docs`にある`report.tex`を監視するコマンドをコンテナ内で実行する
このコンテナではGNU Makeが使えるので、以下のコマンドでいけます。
詳細は`docs/Makefile`を読んでください。

terminal
```
# make watch
```

### 6. `/docs`以下にある`ref.bib`と`report.tex`を編集する
現在のサンプルを以下に示します。
#### `docs/report.tex`
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

% 画像
\usepackage{graphicx}

\begin{document}

  \title{Resume}
  \author{Takahito Sueda}
  \maketitle

  \section{はじめに}
  {\XeTeX} でいい感じにするやつです。

  \section{数式}
  普通に{\TeX}で書けます。
  \begin{eqnarray}
    2x_1 + x_2 & = & 5 \\
    2x_2 & = & 2
  \end{eqnarray}

  \section{引用}
  bibtexを使えます。引用箇所は↓の感じです。Referencesが最後のとこにあります。\\
  引用テストDL\cite{lecun2015deep} \\
  引用テストML\cite{michie1994machine}

  \section{画像}
  graphicx使っていけます。
  \begin{center}
    \includegraphics[width=10cm]{img/logo.png} \\
    ReXeTeXeRのぶちかっこいいロゴ
  \end{center}

  \section{自動監視テスト}
  なんか書くと、コンテナ内のシェルスクリプトがこのファイルの変更を検知して、texのコンパイルコマンドが走ります。

  % bibtex
  \bibliographystyle{junsrt}
  \bibliography{ref.bib}
\end{document}

```

#### `docs/ref.bib`
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
@article{michie1994machine,
  title={Machine learning},
  author={Michie, Donald and Spiegelhalter, David J and Taylor, CC and others},
  journal={Neural and Statistical Classification},
  volume={13},
  year={1994},
  publisher={Technometrics}
}
```

### 7. `report.tex`が更新されると`report.pdf`も自動で更新される
`docs/report.tex`を監視しています。更新を検知するとPDFに変換されます。
参考: https://qiita.com/tamanobi/items/74b62e25506af394eae5

### 8. 自動リロードに対応したPDFビューワーを使って`report.pdf`を開く

* 自動リロードに対応したPDFビューワー
  * macOS: [Skim](https://skim-app.sourceforge.io/)
  * windows10: [Sumatra PDF](https://www.sumatrapdfreader.org/)
  * Linux: [Evince](https://wiki.gnome.org/Apps/Evince)

### 9. `report.tex`がほぼほぼリアルタイムにPDFでプレビューされる
以上の手順を踏むと以下のような動作が可能です。スクショはmacOS上で、左半分のVSCodeでTeXを書き、右のSkimでPDFを開いている状態です。`docs/report.tex`を更新すると右側で見ている`docs/report.pdf`も更新されます。
![img](design/img.png)
<div style="text-align:center;">動作イメージ(スクショは開発中のもの)</div><br>

### 10. うれしいね:smile:
よく"Buy us coffee"って見るんですが、私はコーヒー飲めないので、紅茶か本かなんか贈ってくれると喜びます。
* [my Amazon wish list of books](https://www.amazon.co.jp/hz/wishlist/ls/3F249ZYIVVASC/ref=nav_wishlist_lists_2?_encoding=UTF8&type=wishlist)
[my Amazon wish list(tea, game, etc)](https://www.amazon.co.jp/hz/wishlist/ls/27B0W5F7BN0VF/ref=nav_wishlist_lists_4?_encoding=UTF8&type=wishlist)
[my Amazon wish list of gadget](https://www.amazon.co.jp/hz/wishlist/ls/21AZUN2VWHY3C/ref=nav_wishlist_lists_3?_encoding=UTF8&type=wishlist)

## ディレクトリ
### `/design`について
ReXeTeXeRのロゴのaiファイルとpngがあります。

### `/docs`について
コンテナ内にマウントされています。
* `Makefile`
  * 監視とか変換のコマンドをまとめている
* `watch.sh`
  * 監視→コマンド実行のシェルスクリプト
* `report.tex`
  * 監視されているtexファイル。これを編集する
* `ref.bib`
  * BibTeXのリスト
* `report.pdf`
  * 吐き出されたPDF
* その他諸々
  * 変換時に一緒に出てきます。
  * `.aux`に関してはbibtexが読む。

### `/font`について
Google Fontsからいくつか用意しました。コンテナ内に自動的に配置されます。不要であればDockerfileを編集してください。
* Courier Prime (R,I,B)
* Gelasio (R,I,B)
* Noto Sans JP (R,B)
* Noto Serif JP (R,B)
* Roboto (R,I,B)

### `/src`について
Referenceを表示するのに必要だった`cite.sty`と`junsrt.bst`が置いてあります。今後必要なライブラリがあれば、ここを使用してコンテナー内に配置する予定です。

* cite.sty: mirrors.ctan.org/macros/latex/contrib/cite/cite.sty
* junsrt.bst: http://mirror.las.iastate.edu/tex-archive/biblio/pbibtex/base/junsrt.bst


## memo
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
* [x] ライセンスの整備
* [x] ドキュメントの整備
* [ ] 公開記事の整備

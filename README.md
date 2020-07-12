# ReXeTeXeR

<div style="text-align:center;">

![GitHub](https://img.shields.io/github/license/terfno/rexetexer) ![GitHub repo size](https://img.shields.io/github/repo-size/terfno/rexetexer) ![GitHub last commit](https://img.shields.io/github/last-commit/terfno/rexetexer)

</div>

ぼくのブログ: [TeX の環境構築ダルくね…? せや!](https://medium.com/@terfno/b9892d0d343c?)

![img](./design/logo.png)

<div style="text-align:center;">マジでかっこいいロゴっぽいやつ</div><br>

## これはなに

![img](design/img.png)

<div style="text-align:center;">動作イメージ(スクショは開発中のもの)</div><br>

日本語の `.tex` (UTF-8) を TeX の環境構築なしに、XeTeX(xelatex)を使って `.pdf` に変換する Docker のコンテナーを作れるファイル群です。勝手に**ReXeTeXeR**と名前をつけました。pBibTeX による Reference の自動生成に対応してます。

## 環境
Dockerは必須です。それ以外はオプショナルです。

- Docker(必須)
- GNU Make
- テキストエディタ
- 自動リロードできる PDF ビュワー

## 使い方

0. ReXeTeXeR のために簡単な環境構築をする
1. ReXeTeXeR を準備する
2. 自分の作業用ディレクトリに移動する
3. Docker のイメージをビルドする
4. Docker のコンテナを作成する
5. コンテナに入る
6. `report.tex`を監視するコマンドをコンテナ内で実行する
7. `ref.bib`と`report.tex`を編集する
8. `report.tex`が更新されると`report.pdf`も自動で更新される
9. 自動リロードに対応した PDF ビューワーを使って`report.pdf`を開く
10. `report.tex`がほぼほぼリアルタイムに PDF でプレビューされる
11. うれしいね:smile:

### 0. ReXeTeXeR のために簡単な環境構築をする

#### 🗒 用意するもの

- GNU Make
- Docker
- そこそこ速いインターネット
- 安定した電源

#### ✅ やること

環境があるかどうか確認しましょう。

```sh
$ docker version
$ make --verison
```

なければ環境構築してください。

### 1. ReXeTeXeR を準備する

やること

- Docker イメージの用意
- 作業ディレクトリの作成
- `Makefile`の作成
- `watch.sh`の作成

#### 🐳 Docker のイメージ

Docker Hub から ReXeTeXeR のイメージを pull しましょう。

```sh
$ docker pull terfno/rexetexer
```

#### 📢作業ディレクトリの作成

今回、`.tex`をメインで書くディレクトリに移動してください。なければ適当に作って移動してください。
以下は私の場合です。

```sh
$ cd Documents/report
```

#### ✍ `Makefile`

自身のディレクトリに Makefile を置いてください。中身は以下の通りです。

```make
INAME:=terfno/rexetexer
CNAME:=rexetexer

run:
	@docker run -v ${PWD}:/docs --name ${CNAME} -itd ${INAME} sh

exec:
	@docker exec -it ${CNAME} sh

start:
	@docker start ${CNAME}

stop:
	@docker stop ${CNAME}

# rm
rm:
	@docker rm ${CNAME}

rmi:
	@docker rmi ${INAME}

# tex
tex:
	@xelatex report.tex && pbibtex report.aux && xelatex report.tex && xelatex report.tex

watch:
	@chmod +x ./watch.sh && \
	./watch.sh ./report.tex 'make tex'
```

#### ✍ `watch.sh`

`Makefile`と同じ場所に`watch.sh`というファイルを作成して、以下の内容を記述してください。
監視ビルドに使用されるスクリプトです。

```sh
#!/bin/sh
# see also http://mizti.hatenablog.com/entry/2013/01/27/204343
update() {
  echo `openssl sha256 -r $1 | awk '{print $1}'`
}

INTERVAL=1 #監視間隔, 秒で指定
no=0
last=`update $1`
while true;
do
  sleep $INTERVAL
  current=`update $1`
  if [ "$last" != "$current" ];
  then
    nowdate=`date '+%Y/%m/%d'`
    nowtime=`date '+%H:%M:%S'`
    echo "no:$no\tdate:$nowdate\ttime:$nowtime\tfile:$1"
    eval $2
    last=$current
    no=`expr $no + 1`
  fi
done
```

#### ✅ 確認

今の段階でディレクトリは以下のようになっているはずです。

```
├── Makefile
└── watch.sh
```

### 2. Docker のコンテナを作成する

詳細は`Makefile`を読んでください。

```sh
$ make run
```

これで pull してきた`terfno/rexetexer`というイメージから`rexetexer`というコンテナが作成され、起動します。
このとき、`${PWD}`がマウントされるようになっています。任意に変更することもできます。詳細は`Makefile`を読んでください。

### 3. コンテナに入る

詳細は`Makefile`を読んでください。

```sh
$ make exec
```

入ると、`${PWD}`がマウントされていることを確認できると思います。

### 4. `ref.bib`と`report.tex`を編集する

サンプルを以下に示します。

#### ✍ `report.tex`

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

#### ✍ `ref.bib`

```
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

#### ✅ 確認

今の段階でディレクトリは以下のようになっているはずです。

```
├── Makefile
├── ref.bib
├── report.tex
└── watch.sh
```

### 5. `report.tex`を監視するコマンドをコンテナ内で実行する

このコンテナでは GNU Make が使えるので、以下のコマンドでいけます。
詳細は`Makefile`を読んでください。

```
# make watch
```

このとき監視されるのは`report.tex`なので、任意のファイルを関しする差異は`Makefile`を変更してください。

#### 📢 `.tex`から`.pdf`に一度だけ変換する場合
詳細は`Makefile`を読んでほしいですが、`report.tex`を`report.pdf`に一度だけその場で変換する場合は以下のコマンドでけます。

```
# make tex
```

#### 🤔 ちゃんとエラー解消したはずなのにうまくpdfにならないときは
`*.aux`, `*.bbl`, `*.blg`, `*.log`, `*.toc`あたりのファイルを一度削除して再試行してみてください。

**【重要】エラーは英語だけどちゃんと読めば分かる。**


### 6. `report.tex`が更新されると`report.pdf`も自動で更新される

`report.tex`を監視しています。更新を検知すると PDF に変換されます。

参考: https://qiita.com/tamanobi/items/74b62e25506af394eae5

### 7. 自動リロードに対応した PDF ビューワーを使って`report.pdf`を開く

- 自動リロードに対応した PDF ビューワー
  - macOS: [Skim](https://skim-app.sourceforge.io/)
  - windows10: [Sumatra PDF](https://www.sumatrapdfreader.org/)
  - Linux: [Evince](https://wiki.gnome.org/Apps/Evince)

### 8. `report.tex`がほぼほぼリアルタイムに PDF でプレビューされる

以上の手順を踏むと以下のような動作が可能です。スクショは macOS 上で、左半分の VSCode で TeX を書き、右の Skim で PDF を開いている状態です。`report.tex`を更新すると右側で見ている`report.pdf`も更新されます。

![img](design/img.png)

<div style="text-align:center;">動作イメージ(スクショは開発中のもの)</div><br>

### 9. うれしいね:smile:

よく"Buy us coffee"って見るんですが、私はコーヒー飲めないので、紅茶か本かなんか贈ってくれると喜びます。

- [my Amazon wish list of books](https://www.amazon.co.jp/hz/wishlist/ls/3F249ZYIVVASC/ref=nav_wishlist_lists_2?_encoding=UTF8&type=wishlist)
- [my Amazon wish list of gadget](https://www.amazon.co.jp/hz/wishlist/ls/21AZUN2VWHY3C/ref=nav_wishlist_lists_3?_encoding=UTF8&type=wishlist)
- [my Amazon wish list(tea, game, etc)](https://www.amazon.co.jp/hz/wishlist/ls/27B0W5F7BN0VF/ref=nav_wishlist_lists_4?_encoding=UTF8&type=wishlist)

## ディレクトリ

### `/design`について

ReXeTeXeR のロゴの ai ファイルと png があります。

### `/docs`について

開発中にマウントしているディレクトリです。

- `Makefile`
  - 監視とか変換のコマンドをまとめています
- `watch.sh`
  - 監視 → コマンド実行のシェルスクリプトです
- `report.tex`
  - 監視されている tex ファイルです
  - この tex ファイルを編集します
- `ref.bib`
  - BibTeX のリストです
- `report.pdf`
  - 吐き出された PDF です
- その他諸々
  - 変換時に出てきます
  - `.aux`に関しては bibtex が読みます

### `/font`について

Google Fonts からいくつか用意しました。コンテナ内に自動的に配置されます。不要であれば Dockerfile を編集してください。

- Courier Prime (R,I,B)
- Noto Sans JP (R,B)
- Noto Serif JP (R,B)

### `/src`について

Reference を表示するのに必要だった`cite.sty`と`junsrt.bst`が置いてあります。今後必要なライブラリがあれば、ここを使用してコンテナー内に配置する予定です。

- cite.sty: mirrors.ctan.org/macros/latex/contrib/cite/cite.sty
- junsrt.bst: http://mirror.las.iastate.edu/tex-archive/biblio/pbibtex/base/junsrt.bst

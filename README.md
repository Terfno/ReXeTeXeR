# ReXeTeXeR
<div style="text-align:center;">

![GitHub](https://img.shields.io/github/license/terfno/rexetexer) ![GitHub repo size](https://img.shields.io/github/repo-size/terfno/rexetexer) ![GitHub last commit](https://img.shields.io/github/last-commit/terfno/rexetexer)

</div>

![img](./design/logo.png)

<div style="text-align:center;">マジでかっこいいロゴ</div><br>

## これはなに
![img](design/img.png)

<div style="text-align:center;">動作イメージ(スクショは開発中のもの)</div><br>

日本語の`.tex`(UTF-8)をTeXの環境構築なしに、XeTeX(xelatex)を使って`.pdf`に変換するやつです。
勝手に**ReXeTeXeR**と名前をつけましたpBibTeXによるReferenceの自動生成に対応してます。

### 派生
* 津山高専版: [ReXeTeXeR-tsuyama](https://github.com/Terfno/ReXeTeXeR-tsuyama)

## 環境
DockerかPodmanが必須です。それ以外はオプショナルです。

- Docker or Podman(どちらか1つ)
- GNU Make
- テキストエディタ
- 自動リロードできるPDFビューワー

## 使い方
### 0. 準備
releaseから最新版をダウンロードしてください。
`.zip`を作業ディレクトリに展開してください。
すると、以下のようになるはずです。

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

その後、以下のコマンドでReXeTeXeRをpullします。
```sh
$ make init
```

#### Podmanでの利用
この形でコマンドを実行することでDockerではなくPodmanが利用されます。
```sh
$ make podman.${TARGET}
# Example
$ make podman.init # Run `make init` with Podman
```

### 1. 起動
```sh
$ make run
```

### 2. 接続
```sh
$ make exec
```
これでコンテナに入れます。
以降のコマンドは特に記載がなければコンテナ内で実行するコマンドです。

### 3. 自動コンパイルスクリプトを起動
```sh
$ make watch
```
#### 一度だけコンパイルしたいときは
```sh
$ make tex
```

### 4. TeXを書く
`./report.tex`を編集することで、PDFが錬成されます。
XeTeX(XeLaTeX)です。
画像、引用等については、`test/report.tex`を参照してください。

### 5. PDFを見る
リソースのオートリロードに対応したPDFビューワーを使って`report.pdf`を開くと、ほぼリアルタイムにプレビューされます。

### 6. その他
#### VS CodeのAuto Saveとの相性が悪いこともある
ファイルの変更を察知してコンパイルが走るので、VS CodeなどのAuto Saveで文法が完成していない`.tex`ファイルがコンパイルされることがあります。
`.vscode`にこのワークスペースのみ、Auto Saveが`onFocusChange`になるよう設定すると解消できます。。

#### リソースのオートリロードに対応したPDFビューワー
- macOS: [Skim](https://skim-app.sourceforge.io/)
- windows10: [Sumatra PDF](https://www.sumatrapdfreader.org/)
- Linux: [Evince](https://wiki.gnome.org/Apps/Evince)

#### 止めるときは
コンテナから出て(`$ exit`)、以下のコマンドで止められます。
```sh
$ make stop
```
再度起動する場合は`$ make run`ではなく`$ make start`してください。

コンテナを削除する場合は、以下のコマンドを使用してください。(イメージは削除されないので安心)
```sh
$ make rm
```
イメージを削除する場合は`$ make rmi`です。

## thx
- junsrt.bst: http://mirror.las.iastate.edu/tex-archive/biblio/pbibtex/base/junsrt.bst
- BXjscls: https://github.com/zr-tex8r/BXjscls

### もしよければ:bow:
<a href="https://www.buymeacoffee.com/terfno" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

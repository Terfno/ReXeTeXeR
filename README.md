# ReXeTeXeR

<div style="text-align:center;">

![GitHub](https://img.shields.io/github/license/terfno/rexetexer)  ![GitHub repo size](https://img.shields.io/github/repo-size/terfno/rexetexer)  ![GitHub last commit](https://img.shields.io/github/last-commit/terfno/rexetexer)

</div>

## 使い方
1. `/docs/Makefile`の`$(filename)`を自分のtexファイルの名前に変更する（デフォルトはreport.tex）
2. Dockerのイメージを作る: `$ make build`
3. Dockerのコンテナを作る: `$ make run`
4. コンテナに入る: `$ make exec`
5. `/docs`にある`$(filename).tex`を監視するコマンドをコンテナ内で実行する: `#/docs/ make watch`
6. `/docs`以下にある`ref.bib`と`$(filename).tex`を編集する
7. `$(filename).tex`が更新されると`$(filename).pdf`も自動で更新される
8. 自動リロードに対応したPDFビューワーを使って`$(filename).pdf`を開く
     * macOS: Skim
     * windows10: Sumatra PDF
     * Linux: Evince

## ドキュメント
https://github.com/Terfno/ReXeTeXeR/README.md

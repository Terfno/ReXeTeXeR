# ReXeTeXeR

<div style="text-align:center;">

![GitHub](https://img.shields.io/github/license/terfno/rexetexer)  ![GitHub repo size](https://img.shields.io/github/repo-size/terfno/rexetexer)  ![GitHub last commit](https://img.shields.io/github/last-commit/terfno/rexetexer)

</div>

## 使い方
1. `/docs/Makefile`の`$(filename)`を自分のtexファイルの名前に変更する（デフォルトはreport.tex）
2. Dockerのコンテナを走らせる: `$ make up`
3. コンテナに入る: `$ make exec`
4. `/docs`にある`$(filename).tex`を監視するコマンドをコンテナ内で実行する: `$ make watch`
5. `/docs`以下にある`ref.bib`と`$(filename).tex`を編集する
6. `$(filename).tex`が更新されると`$(filename).pdf`も自動で更新される
7. 自動リロードに対応したPDFビューワーを使って`$(filename).pdf`を開く
     * macOS: Skim
     * windows10: Sumatra PDF
     * Linux: Evince

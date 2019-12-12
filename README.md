# texDocker

## やりたいこと
* `*.tex` を `*.pdf` に変換して吐き出すDockerコンテナーを錬成するDockerfileを書きたい

## やること
* [x] とりあえずTeXの環境をDockerコンテナー内に作る
  * [x] alpine pull
  * [x] xetex install
* [x] ローカルの `*.tex` をコンテナー内にコピーするように変更する→volumesで実装
* [x] コンテナー内にコピーした `*.tex` を `*.pdf` に変換させる
* [x] 変換した `*.pdf` をローカルに吐き出させる
* [ ] ローカルの `*.pdf` をプレビューする

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

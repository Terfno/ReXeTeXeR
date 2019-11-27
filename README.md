# texDocker

## やりたいこと
* `*.tex` を `*.pdf` に変換して吐き出すDockerコンテナーを錬成するDockerfileを書きたい

## やること
* [ ] とりあえずTeXの環境をDockerコンテナー内に作る
  * [ ] alpine pull
  * [x] xetex install
  * [ ] 
* [ ] ローカルの `*.tex` をコンテナー内にコピーするように変更する
* [ ] コンテナー内にコピーした `*.tex` を `*.pdf` に変換させる
* [ ] 変換した `*.pdf` をローカルに吐き出させる
* [ ] ローカルの `*.pdf` をプレビューする

## memo
```sh
# kpsewhich -var-value=TEXMFHOME
/root/texmf
```
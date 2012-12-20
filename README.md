itermcolors-vim
===============

## 概要
vimのcolorschemeからiTerm2のcolorschemeを生成するvimプラグインです。
shellとvimで同じように色が設定できるようになるため、ターミナルに統一感が出ます。
solarizedやtomorrowのようにvimとiTerm2の両方に提供されているcolorschemeもありますが、
colorschemeがvimのものしか提供されていない場合に便利です。


## スクリーンショット
以下はmolokaiというcolorschemeからiTerm2用のcolorschemeを生成し、zshのプロンプトに色をつけた例です。

- molokai風shell
  ![molokai風shell](https://github.com/akiomik/itermcolors-vim/raw/master/image/screenshot-shell.png)

- molokai風colorscheme
  ![molokai風colorscheme](https://github.com/akiomik/itermcolors-vim/raw/master/image/screenshot-colorscheme.png)


## 使い方
1. git cloneしたあと、`autoload/itermcolors.vim`と`plugin/itermcolors.vim`をそれぞれ`$HOME/.vim/`下に配置してください。

2. vim上で以下のコマンドを実行することにより、
   現在使用しているcolorschemeをもとに{colorscheme名}.itermcolorsというファイルがカレントディレクトリに作成されます。

  ```viml
:ITermColors
  ```

3. 作成された{colorscheme名}.itermcolorsを開くか、iTerm2の設定画面からimportしてください。


## 注意点
- iTerm2用のcolorschemeが作成できるのは、GUIカラーが指定されているvimのcolorschemeのみになります。
- iTerm2用のcolorschemeは、同名のファイルが存在する場合でも上書きされますのでご注意ください。


## TODO
- なるべく同じ色が選択されないようにする
  (ターミナルの設定によっては背景色と前景色が被ってしまい、字が読めなくなることがあるため)


## ライセンス
NYSLが適用されます。
詳しくはNYSL.txtをお読みください。

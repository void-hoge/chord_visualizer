# chord_visualizer
## installation
- UNIX(Mac/Linux)に対応、Windowsは非対応
- processingの実行環境が必要
- converterをconverter/build/内にビルド
  - g++-11で記述しているが、CMakeList.txtで変更できる。

## usage
- 順序の数列を記述したテキストファイルを用意
- `./run filename`で実行
- 例えば、`./run test`
- 現在はn=6を設定している。

## inputfile
```
6
1 2 3 5 6 4
```
- 1行目に変数の数、2行目に順列piを記述したファイル
- 上のものは現在[test](test)に書いてある。

## 仕組み
- converterは標準入力を受けて標準出力で結果を返す。
- converterの出力をファイルに書き出す。
- それをchord_visualizerに渡す。
- 全体をrunで制御

## TODO
- nを変化できるようにする。

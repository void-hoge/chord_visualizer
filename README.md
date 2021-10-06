# chord_visualizer
## installation
- processingの実行環境が必要
- converterをconverter/build/内にビルド

## usage
- 順序の数列を記述したテキストファイルを用意
- `sh run.sh filename`で実行
- 現在はn=5を設定している。

## inputfile
```
5
1 2 3 5 4
```
- 1行目に変数の数、2行目に順列piを記述したファイル

## 仕組み
- converterは標準入力を受けて標準出力で結果を返す。
- converterの出力をファイルに書き出す。
- それをchord_visualizerに渡す。
- 全体をrun.shで制御

## TODO
- nを変化できるようにする。

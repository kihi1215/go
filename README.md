## go 1.15
- 本体とデバッグ環境。
- あとは、VS-Codeでデバッグしようとすると、色々追加されるものを先に追加しようと思ったが、やめておく。
vs-code で リモートでのgo言語の拡張機能を有効にする手作業は必要なので、その時にメッセージにしたがって、追加パッケージを入れればいいかな。（色々多すぎて嫌になったw）

### build & run sample
- `docker build -t go115:1 .`
- `docker run -dit --name godev1 -h godev1 -p 8180:80 go115:1`

### メモ
- bash のプロンプトの設定って dockerfile でどうやって設定するのが正解なのかな。
- delve の [github](https://github.com/go-delve) はここ。
- delve いるかな？ gcloud 関連のテスト環境をローカルでやらずに、GCPにテストプロジェクト作ってcloud上でテストするなら、いらないか... gcloud のローカルテスト環境は、ローカルが汚れるのでかなり躊躇する...
- CGO_ENABLED=0 は 最終的には scratch をベースにバイナリファイルだけのイメージを作るので、設定してしまう。開発時は無駄なのかもしれないけど...
- GO111MODULE=on は dlv を入れるときに、 /go/src にいっぱい入ってくるので、モジュールモードにした。（モジュールモードってのが今の主流？みたいなのがどこかに書いてあったような気もしたので、設定しておく。
- go get aaa bbb ccc ddd eee と一気にいっぱい入れようとすると、docker build で エラーになった。半分づつにすると動いたりしたけど、未調査。

### DockerHub から取得して使う時の例。（ローカルにgo環境をインストールせずにfmtなどを行える）
- 'docker run -dit --name go115b -h go115b -p 8181:80 --mount type=bind,source="$(pwd)",target=/go/src/`basename $(pwd)` -w /go/src/`basename $(pwd)` kihi1215/go:1.2'

- `docker exec -it go115 go mod init`
- `docker exec -it go115 go mod tidy`
- `docker exec -it go115 go fmt`
- `docker exec -it go115 go install`  
 ( build するとカレンとに実行モジュールができてしまう)

### My Rule
- 環境変数 `PORT` は必ず定義しておく。（google cloud run を使うことが多いから）Goプログラム内で環境変数から取得できない場合は落とす。

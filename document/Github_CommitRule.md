# Github ルール

Github を使用する中で必要なルールをまとめています。

## Github ブランチ名

機能やデザイン追加(実装)  
`feature/機能またはデザイン/issue番号`

バグ修正  
`fix/機能またはデザイン/issue番号または機能名`

ドキュメント作成  
`doc/なんのドキュメントか/issueがあればissue番号`

ex.
`feature/design/12`  
`fix/QRCodeReader/camera`  
`doc/iOSDebug`

## Github コミットメッセージ

`add：新規機能追加(新しいファイルを追加する場合)`  
`update：機能修正`  
`remove：ファイルを削除する場合`  
`fix：バグ修正`  
`doc：ドキュメント作成`  
`clean：リファクタリングやコメント削除のみの場合`

ex. `update: ボタンを押下時コンソール結果に'test'を出力するように変更`

## Github プッシュ/PR

- 必ずブランチを切りプッシュすること
- develop や main に直接プッシュをしない

### PR について

- 必ず誰が作業したかわかるように`Assignees`を設定する
- コードレビューを必ずはさみたいので機能側の実装なら他の機能側の実装をしている人、デザインなら他のデザインを実装している人を必ず２人以上`Reviewers`に設定する
- どんな PR なのかわかりやすいように必ず`Labels`をつける

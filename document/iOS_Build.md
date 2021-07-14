# iOSデバックについて

## エラー対処

> [!] Automatically assigning platform `iOS` with version `14.1` on target `Runner` because no platform was specified. Please specify a platform for this target in your Podfile. See `https://guides.cocoapods.org/syntax/podfile.html#platform`.

「プラットフォームが指定されていなかったため、ターゲット「ランナー」にバージョン「8.0」のプラットフォーム「iOS」を自動的に割り当てました。 Podfileでこのターゲットのプラットフォームを指定してください。」
と言われているので`./ios/Podfile`の`# platform :ios, '9.0'`をコメントアウト解除しバージョンを上げとく
例: `platform :ios, '12.0'`

これだけで治らない場合はPodfileにこのように文を追加する

```ruby
post_install do |installer|
  installer.pods_project.targets.each do |target|
    flutter_additional_ios_build_settings(target)
# ---------------追加---------------------------
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '9.0'
    end
#----------------------------------------------
  end
end
```

> resource fork,Finder information, or similar detritus not allowedCommand CodeSign failed with a nonzero exit code

[修正方法](https://stackoverflow.com/questions/39652867/code-sign-error-in-macos-high-sierra-xcode-resource-fork-finder-information)
`xattr -cr アプリケーションのパス`
`xattr -lr アプリケーションのパス/ios/Runner`

を順に実行することで修正できる。

## 参考文献

[基本画面作成参考](https://qiita.com/pe-ta/items/e547c4cf460319f5093c#point%E8%A7%A3%E8%AA%AC%E7%94%BB%E9%9D%A2%E9%81%B7%E7%A7%BB%E6%99%82%E3%81%AB%E5%80%A4%E3%82%92%E6%B8%A1%E3%81%99)
[画面遷移参考](https://itome.team/blog/2019/12/flutter-advent-calendar-day10/)
[ダークモード対応](https://note.com/kacho_/n/n2f6b7c5df9d2)
[error: compiling for iOS 8.0, but module ‘SwiftProtobuf’ has a minimum deployment target of iOS 9.0](https://selegee.com/7500/)
[error: Runner.app/Info.plist does not exist. The Flutter "Thin Binary" build phase must run after "Copy Bundle Resources"](https://qiita.com/121a/items/c0ab6aef257295ebb2de)

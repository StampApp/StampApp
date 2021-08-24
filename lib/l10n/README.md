# i18n について

アプリにいろんな言語に対応出来るような機能を組み込んだり、そういう設計にしたりする事。

## 使い方

lib/l10n 下のファイルにキーとそれに対応する値を記述します。

```Dart
// lib/l10n/app_en.arb
{
    "@@locale":"en",
    "example":"example"
}

// lib/l10n/app_ja.arb
{
    "@@locale":"ja",
    "example":"例"
}
```

## 今後拡張するにあたって

現在は日本語と英語に対応している。
それ以外の言語にも対応したい場合は、lib/Widget/Main の MyApp 内の supportedLocales で追加したい言語を追加し、lib/l10n 下に追加したい言語のファイルを作成する。

# u1e2k.github.io

このリポジトリは GitHub Pages（Jekyll）でホスティングされている個人サイトのソースです。

## 概要
- サイト生成: Jekyll
- 配置先: GitHub Pages（`main` ブランチを利用）

主なファイル・ディレクトリ:

- `index.markdown` - サイトのトップページのソース（Markdown/Jekyll）
- `about.markdown` - About ページのソース
- `_posts/` - ブログ投稿（Jekyll の投稿形式）
- `css/` と `img/` - サイトのスタイルシートと画像
- `_config.yml` - Jekyll 設定
- `_site/` - ビルド結果（自動生成。通常はコミット不要だが、このリポジトリでは既に存在します）

## ローカルでの動作確認
必要なもの:

- Ruby（推奨: 3.x 系）
- Bundler（`gem install bundler`）

セットアップと起動:

```bash
# 依存をインストール
bundle install

# 開発用サーバを起動（デフォルト: http://127.0.0.1:4000）
bundle exec jekyll serve
```

ブラウザで `http://127.0.0.1:4000` にアクセスして確認してください。

## 編集について
- 新しい記事は `_posts/` に Jekyll の命名規則（`YYYY-MM-DD-title.markdown`）で追加します。
- ページのコンテンツは `index.markdown` や `about.markdown` を編集してください。
- スタイル調整は `css/main.scss` と `_sass/` 内の SCSS ファイルを編集します。

### CSS/SCSS 構成（2025-12-03 更新）
スタイルシートを保守性向上のため SASS/SCSS に移行しました:

```
_sass/
  _variables.scss  # 色、サイズ、ブレークポイントの定義
  _base.scss       # リセット、基本スタイル
  _layout.scss     # レイアウト（ヒーロー、プロジェクト、フッター）
  _components.scss # コンポーネント（ボタン、カード、タグ）
  _blog.scss       # ブログ記事関連スタイル
  _responsive.scss # レスポンシブ対応
  _animations.scss # 背景アニメーション
css/
  main.scss        # 上記をすべて import するエントリーポイント
```

スタイル変更時は:
- 色やサイズの変更 → `_sass/_variables.scss` を編集
- 各セクションのスタイル → 対応する `_sass/*.scss` を編集
- 新しいコンポーネント → `_sass/` に新規ファイル作成し `css/main.scss` で import

#### GitHub Pages の Sass 対応について
GitHub Pages は Jekyll 3.9.x を使用しており、古い Sass 実装（LibSass）を採用しています。そのため:

- **`@import` 構文を使用** - モダンな `@use` / `@forward` 構文は非対応
- **ローカル環境での警告** - 最新の Dart Sass では `@import` が非推奨のため警告が出ますが、動作には問題ありません
- **GitHub Pages では警告なし** - デプロイ先では古い Sass が使われるため警告は表示されません

もし最新の Sass 機能を使いたい場合は、GitHub Actions で Jekyll をビルドして `gh-pages` ブランチにデプロイする方法があります。

## デプロイ
このリポジトリは GitHub Pages 用に構成されています。`main` ブランチにプッシュすると自動的に公開されます（リポジトリの GitHub Pages 設定を確認してください）。

## 備考
- `_site/` はビルド成果物です。通常は `.gitignore` に含めることを推奨しますが、このリポジトリでは既に生成済みのファイルが含まれています。
- 何か追加したい情報（連絡先、ライセンス、カスタムドメイン設定など）があれば教えてください。README を更新します。

---

作成日: 2025-11-18

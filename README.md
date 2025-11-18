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
- スタイル調整は `css/main.css` を編集します。

## デプロイ
このリポジトリは GitHub Pages 用に構成されています。`main` ブランチにプッシュすると自動的に公開されます（リポジトリの GitHub Pages 設定を確認してください）。

## 備考
- `_site/` はビルド成果物です。通常は `.gitignore` に含めることを推奨しますが、このリポジトリでは既に生成済みのファイルが含まれています。
- 何か追加したい情報（連絡先、ライセンス、カスタムドメイン設定など）があれば教えてください。README を更新します。

---

作成日: 2025-11-18

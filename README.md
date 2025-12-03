# u1e2k.github.io

このリポジトリは GitHub Pages でホスティングされている個人サイトのソースです。

**🎉 2025-12-03: JekyllからAstroに移行しました！**

## 概要

- **静的サイトジェネレーター**: Astro
- **ランタイム**: Bun
- **ホスティング**: GitHub Pages（GitHub Actions経由）
- **スタイリング**: Sass/SCSS

## 主な機能

- ⚡️ 高速なビルドとホットリロード（Bun + Astro）
- 📝 Markdownベースのブログ（Content Collections）
- 🎨 レスポンシブデザイン
- 🌙 ダークモード対応
- ✨ アニメーション背景

## プロジェクト構造

```
/
├── public/          # 静的ファイル（画像、CSS等）
│   ├── css/        # Sassファイル
│   └── img/        # 画像ファイル
├── src/
│   ├── content/    # Markdownコンテンツ
│   │   ├── config.ts
│   │   └── blog/   # ブログ記事
│   ├── layouts/    # レイアウトコンポーネント
│   │   ├── Layout.astro
│   │   └── Post.astro
│   └── pages/      # ページファイル
│       ├── index.astro
│       ├── about.astro
│       └── blog/
│           └── [slug].astro
├── .github/
│   └── workflows/
│       └── deploy.yml  # GitHub Actions デプロイ設定
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

## ローカル開発

### 前提条件

- [Bun](https://bun.sh/) がインストールされていること
  ```bash
  curl -fsSL https://bun.sh/install | bash
  ```

### セットアップと起動

```bash
# 依存関係のインストール
bun install

# 開発サーバーの起動（http://localhost:4321）
bun run dev

# 本番ビルド
bun run build

# ビルド結果のプレビュー
bun run preview
```

## ブログ記事の追加

1. `src/content/blog/` ディレクトリに新しいMarkdownファイルを作成
2. Front Matter を追加:

```yaml
---
title: "記事のタイトル"
date: 2025-12-03
categories: [tools, web-dev]
---

記事の内容をここに書く...
```

3. 開発サーバーで確認後、コミット・プッシュ

## スタイルのカスタマイズ

スタイルは `public/css/` ディレクトリのSassファイルで管理されています:

- `_variables.scss` - 色、サイズ、ブレークポイントの定義
- `_base.scss` - リセット、基本スタイル
- `_layout.scss` - レイアウト（ヒーロー、プロジェクト、フッター）
- `_components.scss` - コンポーネント（ボタン、カード、タグ）
- `_blog.scss` - ブログ記事関連スタイル
- `_responsive.scss` - レスポンシブ対応
- `_animations.scss` - 背景アニメーション

## デプロイ

このリポジトリは GitHub Actions を使用して自動デプロイされます。

1. `main` ブランチにプッシュ
2. GitHub Actions が自動的にビルド
3. GitHub Pages に自動デプロイ

### GitHub Pages 設定

リポジトリの **Settings** > **Pages** で:
- **Source**: GitHub Actions を選択

## 移行について

Jekyll から Astro への移行の詳細は以下のドキュメントを参照してください:

- [MIGRATION_GUIDE.md](./MIGRATION_GUIDE.md) - 移行手順の詳細
- [SETUP.md](./SETUP.md) - セットアップガイド

## トラブルシューティング

詳細は [SETUP.md](./SETUP.md) を参照してください。

### よくある問題

- **Bunがインストールできない**: Node.js + npm/pnpm でも動作します
- **ビルドエラー**: `rm -rf node_modules && bun install` で再インストール
- **スタイルが反映されない**: `public/css/` のSassファイルを確認

## 参考リンク

- [Astro公式ドキュメント](https://docs.astro.build/)
- [Bunドキュメント](https://bun.sh/docs)
- [GitHub Pages + Astro デプロイガイド](https://docs.astro.build/en/guides/deploy/github/)

---

最終更新日: 2025-12-03

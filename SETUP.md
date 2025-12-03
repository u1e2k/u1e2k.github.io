# セットアップガイド

このプロジェクトは **Astro** を使用した静的サイトジェネレーターで、**Bun** ランタイムで動作します。

## 前提条件

- [Bun](https://bun.sh/) がインストールされていること

## セットアップ手順

### 1. 依存関係のインストール

```bash
bun install
```

### 2. 開発サーバーの起動

```bash
bun run dev
```

開発サーバーが `http://localhost:4321` で起動します。

### 3. 本番ビルド

```bash
bun run build
```

ビルド結果は `dist/` ディレクトリに出力されます。

### 4. ビルド結果のプレビュー

```bash
bun run preview
```

## 静的アセットの移動

既存のJekyllプロジェクトから移行する場合、以下のコマンドで静的ファイルをコピーします:

```bash
# 画像ファイルのコピー
cp -r img/ public/img/

# faviconのコピー（存在する場合）
cp favicon.ico public/favicon.ico 2>/dev/null || true
```

## プロジェクト構造

```
/
├── public/          # 静的ファイル（画像、favicon等）
│   ├── css/        # コンパイル済みCSS
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
├── astro.config.mjs
├── package.json
└── tsconfig.json
```

## デプロイ

このプロジェクトは GitHub Pages に自動デプロイされます。

### GitHub Actions ワークフロー

`.github/workflows/deploy.yml` で設定されており、`main` ブランチにプッシュすると自動的にビルド・デプロイされます。

### GitHub Pages 設定

リポジトリの設定で以下を確認してください:

1. **Settings** > **Pages**
2. **Source**: GitHub Actions を選択

## トラブルシューティング

### Bunがインストールできない場合

Node.js + npm/pnpm でも動作します:

```bash
npm install
npm run dev
npm run build
```

### ビルドエラーが発生する場合

- `src/content/config.ts` のスキーマがfront-matterと一致しているか確認
- 記事のfront-matterのdate形式が正しいか確認
- 依存関係が正しくインストールされているか確認

```bash
rm -rf node_modules
bun install
```

## 参考リンク

- [Astro公式ドキュメント](https://docs.astro.build/)
- [Bunドキュメント](https://bun.sh/docs)
- [GitHub Pages + Astro デプロイガイド](https://docs.astro.build/en/guides/deploy/github/)

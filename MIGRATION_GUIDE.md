# JekyllからAstroへの移行ガイド

## 現在の状態
- ブランチ: `feature/astro-migration` 作成済み
- 既存のJekyllファイルは保持されています

## 次のステップ

### 1. Bunの確認とインストール
```bash
# Bunがインストールされているか確認
bun --version

# インストールされていない場合
curl -fsSL https://bun.sh/install | bash
```

### 2. Astroプロジェクトの初期化

既存のJekyllファイルを一時的に移動してから、Astroをセットアップします。

```bash
# 作業ディレクトリに移動
cd /workspaces/u1e2k.github.io

# Jekyllファイルをバックアップ（任意）
mkdir .jekyll_backup
mv _posts _layouts _sass _config.yml Gemfile* .jekyll_backup/
mv about.markdown index.markdown .jekyll_backup/

# 404.htmlとREADME.mdは残す
# .git/ディレクトリは絶対に削除しない

# Astroプロジェクトを初期化
bun create astro@latest .

# プロンプトが表示されたら:
# - "Empty" テンプレートを選択
# - TypeScript: "Strict" を推奨
# - 依存関係のインストール: Yes
# - Gitリポジトリの初期化: No (既存のリポジトリを使用)
```

### 3. 開発サーバーの起動確認

```bash
bun run dev
# http://localhost:4321 で確認
```

### 4. コンテンツの移行

#### ブログ記事の移行

```bash
# コンテンツディレクトリの作成
mkdir -p src/content/blog

# 記事を移動（バックアップから）
cp .jekyll_backup/_posts/2025-10-31-welcome-to-jekyll.markdown src/content/blog/
cp .jekyll_backup/_posts/2025-12-01-plamo-mixer-release.markdown src/content/blog/
cp .jekyll_backup/_posts/2025-12-03-sir-time-release.markdown src/content/blog/
```

**コレクション設定ファイルの作成:**

`src/content/config.ts` を作成:

```typescript
import { defineCollection, z } from 'astro:content';

const blog = defineCollection({
  type: 'content',
  schema: z.object({
    title: z.string(),
    date: z.date(),
    categories: z.array(z.string()).optional(),
    layout: z.string().optional(),
  }),
});

export const collections = { blog };
```

#### Aboutページの移行

```bash
# ページディレクトリの作成
mkdir -p src/pages

# Aboutページを移動
cp .jekyll_backup/about.markdown src/pages/about.md
```

`src/pages/about.md` のfront-matterを調整:

```yaml
---
layout: ../layouts/Layout.astro
title: About
---
```

#### 静的アセットの移行

```bash
# 画像やその他の静的ファイルを移動
cp -r img/ public/img/
cp favicon.ico public/favicon.ico 2>/dev/null || true
```

### 5. スタイルの移行

```bash
# スタイルディレクトリの作成
mkdir -p src/styles

# Sassファイルを移動
cp .jekyll_backup/_sass/*.scss src/styles/
```

**Sass依存関係のインストール:**

```bash
bun add -D sass
```

### 6. レイアウトコンポーネントの作成

`src/layouts/Layout.astro` を作成:

```astro
---
interface Props {
  title: string;
}

const { title } = Astro.props;
---

<!DOCTYPE html>
<html lang="ja">
  <head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width" />
    <link rel="icon" type="image/x-icon" href="/favicon.ico" />
    <title>{title}</title>
  </head>
  <body>
    <slot />
  </body>
</html>
```

### 7. トップページの作成

`src/pages/index.astro` を作成:

```astro
---
import { getCollection } from 'astro:content';
import Layout from '../layouts/Layout.astro';

const posts = (await getCollection('blog')).sort(
  (a, b) => b.data.date.valueOf() - a.data.date.valueOf()
);
---

<Layout title="ポートフォリオ">
  <main>
    <h1>ブログ記事</h1>
    <ul>
      {posts.map((post) => (
        <li>
          <a href={`/blog/${post.slug}`}>
            {post.data.title}
          </a>
          <time datetime={post.data.date.toISOString()}>
            {post.data.date.toLocaleDateString('ja-JP')}
          </time>
        </li>
      ))}
    </ul>
  </main>
</Layout>
```

### 8. ブログ記事ページの動的ルーティング

`src/pages/blog/[...slug].astro` を作成:

```astro
---
import { getCollection } from 'astro:content';
import Layout from '../../layouts/Layout.astro';

export async function getStaticPaths() {
  const posts = await getCollection('blog');
  return posts.map((post) => ({
    params: { slug: post.slug },
    props: post,
  }));
}

const post = Astro.props;
const { Content } = await post.render();
---

<Layout title={post.data.title}>
  <article>
    <h1>{post.data.title}</h1>
    <time datetime={post.data.date.toISOString()}>
      {post.data.date.toLocaleDateString('ja-JP')}
    </time>
    <Content />
  </article>
</Layout>
```

### 9. Astro設定の調整

`astro.config.mjs` を編集:

```javascript
import { defineConfig } from 'astro/config';

export default defineConfig({
  site: 'https://u1e2k.github.io',
  // GitHub Pagesの場合、リポジトリ名がサブディレクトリになる場合は以下を追加
  // base: '/u1e2k.github.io',
});
```

### 10. GitHub Actions ワークフローの設定

`.github/workflows/deploy.yml` を作成:

```yaml
name: Deploy to GitHub Pages

on:
  push:
    branches: [ main ]
  workflow_dispatch:

permissions:
  contents: read
  pages: write
  id-token: write

jobs:
  build:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout
        uses: actions/checkout@v4
      
      - name: Setup Bun
        uses: oven-sh/setup-bun@v1
        with:
          bun-version: latest
      
      - name: Install dependencies
        run: bun install
      
      - name: Build
        run: bun run build
      
      - name: Upload artifact
        uses: actions/upload-pages-artifact@v3
        with:
          path: ./dist

  deploy:
    environment:
      name: github-pages
      url: ${{ steps.deployment.outputs.page_url }}
    runs-on: ubuntu-latest
    needs: build
    steps:
      - name: Deploy to GitHub Pages
        id: deployment
        uses: actions/deploy-pages@v4
```

### 11. ビルドテスト

```bash
# 本番ビルドを実行
bun run build

# dist/ディレクトリが生成され、HTMLファイルが含まれていることを確認
ls -la dist/
```

### 12. コミットとプッシュ

```bash
git add .
git commit -m "feat: Complete Astro migration with Bun"
git push -u origin feature/astro-migration
```

### 13. プルリクエストの作成

GitHub上で `feature/astro-migration` から `main` へのPRを作成します。

### 14. GitHub Pagesの設定確認

リポジトリの Settings > Pages で以下を確認:
- Source: GitHub Actions を選択

### 15. マージとデプロイ

PRをマージすると、GitHub Actionsが自動的にビルド・デプロイを実行します。

---

## 注意事項

1. **Jekyllファイルの削除タイミング**: Astroが正常に動作することを確認してから、`.jekyll_backup/` ディレクトリと残っているJekyllファイルを削除してください。

2. **カスタムドメイン**: カスタムドメインを使用している場合、`public/CNAME` ファイルを作成してドメイン名を記載してください。

3. **404ページ**: 既存の `404.html` をAstroプロジェクトに統合する場合は `src/pages/404.astro` として作成してください。

4. **スタイルの適用**: Jekyllのスタイルを完全に再現するには、既存のSassファイルをAstroコンポーネントでインポートし、必要に応じて調整してください。

---

## トラブルシューティング

### Bunがインストールできない場合
Node.js + npmまたはpnpmでも同様に動作します:
```bash
npm create astro@latest .
npm run dev
npm run build
```

### ビルドエラーが発生する場合
- `src/content/config.ts` のスキーマがfront-matterと一致しているか確認
- 記事のfront-matterのdate形式が正しいか確認
- 依存関係が正しくインストールされているか確認

---

## 参考リンク

- [Astro公式ドキュメント](https://docs.astro.build/)
- [Bunドキュメント](https://bun.sh/docs)
- [GitHub Pages + Astro デプロイガイド](https://docs.astro.build/en/guides/deploy/github/)

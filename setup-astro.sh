#!/bin/bash

# Astro移行のための最終セットアップスクリプト

echo "=== Astro移行 - 最終セットアップ ==="
echo ""

# 画像ファイルのコピー
echo "1. 静的アセットをpublicディレクトリにコピー中..."
if [ -d "img" ]; then
  cp -r img/ public/img/
  echo "✓ img/ -> public/img/ コピー完了"
else
  echo "⚠ img/ ディレクトリが見つかりません"
fi

# faviconのコピー（存在する場合）
if [ -f "favicon.ico" ]; then
  cp favicon.ico public/favicon.ico
  echo "✓ favicon.ico -> public/favicon.ico コピー完了"
else
  echo "⚠ favicon.ico が見つかりません"
fi

echo ""
echo "2. 依存関係のインストール中..."
bun install

echo ""
echo "3. 型チェック実行中..."
bun run astro check || true

echo ""
echo "=== セットアップ完了 ==="
echo ""
echo "次のステップ:"
echo "  1. 開発サーバーを起動: bun run dev"
echo "  2. ブラウザで http://localhost:4321 にアクセス"
echo "  3. 動作確認後、ビルドをテスト: bun run build"
echo ""
echo "問題がなければ以下のコマンドでコミット:"
echo "  git add ."
echo "  git commit -m 'feat: Complete Astro migration'"
echo "  git push -u origin feature/astro-migration"
echo ""

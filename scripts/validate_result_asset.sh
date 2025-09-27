#!/bin/bash
set -euo pipefail
APP_RES="${TARGET_BUILD_DIR}/${UNLOCALIZED_RESOURCES_FOLDER_PATH}"
# Asset Catalog はバイナリ統合されるため、.app 内に明示的な画像ファイルは無い。
# 代わりにソース側を検査：
ROOT="${SRCROOT:-$(pwd)}"
set -x
if ! grep -R "result_girl.imageset" -n "${ROOT}/" >/dev/null; then
  echo "[ERR] result_girl.imageset が見つかりません" ; exit 9
fi
if ! grep -R "Image(\"result_girl\")" -n "${ROOT}/" >/dev/null; then
  echo "[ERR] Image(\"result_girl\") がコード内で参照されていません" ; exit 10
fi
echo "[OK] result_girl asset & reference found."

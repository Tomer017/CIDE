#!/usr/bin/env bash
# Downloads bundled C/C++ extensions from Open VSX into bundled-extensions/.
# Run this before build.sh so prepare_vscode.sh can stage them.

set -euo pipefail

mkdir -p bundled-extensions

download_extension() {
  local publisher="$1"
  local name="$2"
  local output="bundled-extensions/${publisher}.${name}.vsix"

  if [[ -f "${output}" ]]; then
    echo "Already present: ${publisher}.${name}"
    return
  fi

  echo "Fetching metadata: ${publisher}.${name} ..."
  local api_response
  api_response=$(curl -sSf "https://open-vsx.org/api/${publisher}/${name}/latest")

  local download_url
  download_url=$(echo "${api_response}" | jq -r '.files.download // empty')

  if [[ -z "${download_url}" ]]; then
    echo "ERROR: could not resolve download URL for ${publisher}.${name}" >&2
    echo "API response: ${api_response}" >&2
    exit 1
  fi

  echo "Downloading ${publisher}.${name} from ${download_url} ..."
  curl -sSfL "${download_url}" -o "${output}"
  echo "Saved: ${output}"
}

download_extension "llvm-vs-code-extensions" "vscode-clangd"
download_extension "vadimcn" "vscode-lldb"
download_extension "twxs" "cmake"

echo "All bundled extensions downloaded."

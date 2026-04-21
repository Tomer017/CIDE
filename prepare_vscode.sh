#!/usr/bin/env bash
# shellcheck disable=SC1091,2154

set -e

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  cp -rp src/insider/* vscode/
else
  cp -rp src/stable/* vscode/
fi

cp -f LICENSE vscode/LICENSE.txt

cd vscode || { echo "'vscode' dir not found"; exit 1; }

{ set +x; } 2>/dev/null

# {{{ product.json
cp product.json{,.bak}

setpath() {
  local jsonTmp
  { set +x; } 2>/dev/null
  jsonTmp=$( jq --arg 'value' "${3}" "setpath(path(.${2}); \$value)" "${1}.json" )
  echo "${jsonTmp}" > "${1}.json"
  set -x
}

setpath_json() {
  local jsonTmp
  { set +x; } 2>/dev/null
  jsonTmp=$( jq --argjson 'value' "${3}" "setpath(path(.${2}); \$value)" "${1}.json" )
  echo "${jsonTmp}" > "${1}.json"
  set -x
}

setpath "product" "checksumFailMoreInfoUrl" "https://go.microsoft.com/fwlink/?LinkId=828886"
setpath "product" "documentationUrl" "https://go.microsoft.com/fwlink/?LinkID=533484#vscode"
setpath_json "product" "extensionsGallery" '{"serviceUrl": "https://open-vsx.org/vscode/gallery", "itemUrl": "https://open-vsx.org/vscode/item", "latestUrlTemplate": "https://open-vsx.org/vscode/gallery/{publisher}/{name}/latest", "controlUrl": "https://raw.githubusercontent.com/EclipseFdn/publish-extensions/refs/heads/master/extension-control/extensions.json"}'

setpath "product" "introductoryVideosUrl" "https://go.microsoft.com/fwlink/?linkid=832146"
setpath "product" "keyboardShortcutsUrlLinux" "https://go.microsoft.com/fwlink/?linkid=832144"
setpath "product" "keyboardShortcutsUrlMac" "https://go.microsoft.com/fwlink/?linkid=832143"
setpath "product" "keyboardShortcutsUrlWin" "https://go.microsoft.com/fwlink/?linkid=832145"
setpath "product" "licenseUrl" "https://github.com/${GH_REPO_PATH}/blob/main/LICENSE"
setpath_json "product" "linkProtectionTrustedDomains" '["https://open-vsx.org"]'
setpath "product" "releaseNotesUrl" "https://go.microsoft.com/fwlink/?LinkID=533483#vscode"
setpath "product" "reportIssueUrl" "https://github.com/${GH_REPO_PATH}/issues/new"
setpath "product" "requestFeatureUrl" "https://go.microsoft.com/fwlink/?LinkID=533482"
setpath "product" "tipsAndTricksUrl" "https://go.microsoft.com/fwlink/?linkid=852118"
setpath "product" "twitterUrl" "https://go.microsoft.com/fwlink/?LinkID=533687"

if [[ "${DISABLE_UPDATE}" != "yes" ]]; then
  setpath "product" "downloadUrl" "https://github.com/${GH_REPO_PATH}/releases"
fi

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  setpath "product" "nameShort" "CIDE - Insiders"
  setpath "product" "nameLong" "CIDE - Insiders"
  setpath "product" "applicationName" "cide-insiders"
  setpath "product" "dataFolderName" ".cide-insiders"
  setpath "product" "linuxIconName" "cide-insiders"
  setpath "product" "quality" "insider"
  setpath "product" "urlProtocol" "cide-insiders"
  setpath "product" "serverApplicationName" "cide-server-insiders"
  setpath "product" "serverDataFolderName" ".cide-server-insiders"
  setpath "product" "darwinBundleIdentifier" "com.cide.app.Insiders"
  setpath "product" "win32AppUserModelId" "CIDE.CIDEInsiders"
  setpath "product" "win32DirName" "CIDE Insiders"
  setpath "product" "win32MutexName" "cideinsiders"
  setpath "product" "win32NameVersion" "CIDE Insiders"
  setpath "product" "win32RegValueName" "CIDEInsiders"
  setpath "product" "win32ShellNameShort" "CIDE Insiders"
  setpath "product" "win32AppId" "{{2A9F3C1E-8B7D-4F5A-9E6C-0D3B2A8F1C7E}"
  setpath "product" "win32x64AppId" "{{5C8E2F4A-1D9B-4E7C-3F0A-6B2D8C5E1F9A}"
  setpath "product" "win32arm64AppId" "{{8F1D5A3C-4B2E-4F8D-7C6A-1E9B3F5D2A4C}"
  setpath "product" "win32UserAppId" "{{3B7F2E9D-5C1A-4F6E-8D0B-2A4C7F9E3B1D}"
  setpath "product" "win32x64UserAppId" "{{6E4C1F8A-2D5B-4A9E-3F7C-0B8D6E2F4A1C}"
  setpath "product" "win32arm64UserAppId" "{{1F9D6C3A-8E2B-4F5D-0A7C-3B5E9F1D6C2A}"
  setpath "product" "tunnelApplicationName" "cide-insiders-tunnel"
  setpath "product" "win32TunnelServiceMutex" "cideinsiders-tunnelservice"
  setpath "product" "win32TunnelMutex" "cideinsiders-tunnel"
  setpath "product" "win32ContextMenu.x64.clsid" "B3F9E2D1-7A4C-4E8F-6B0D-5C2A9F1E3D7B"
  setpath "product" "win32ContextMenu.arm64.clsid" "F1A8D4C2-9E3B-4F7A-2C5E-8D0B6F4A1C9E"
else
  setpath "product" "nameShort" "CIDE"
  setpath "product" "nameLong" "CIDE"
  setpath "product" "applicationName" "cide"
  setpath "product" "dataFolderName" ".cide"
  setpath "product" "linuxIconName" "cide"
  setpath "product" "quality" "stable"
  setpath "product" "urlProtocol" "cide"
  setpath "product" "serverApplicationName" "cide-server"
  setpath "product" "serverDataFolderName" ".cide-server"
  setpath "product" "darwinBundleIdentifier" "com.cide.app"
  setpath "product" "win32AppUserModelId" "CIDE.CIDE"
  setpath "product" "win32DirName" "CIDE"
  setpath "product" "win32MutexName" "cide"
  setpath "product" "win32NameVersion" "CIDE"
  setpath "product" "win32RegValueName" "CIDE"
  setpath "product" "win32ShellNameShort" "CIDE"
  setpath "product" "win32AppId" "{{27B03506-4CDE-45F5-AE6E-CAF2EA2A4E14}"
  setpath "product" "win32x64AppId" "{{4CE80B48-0742-4FEB-B1ED-672D0F3617A4}"
  setpath "product" "win32arm64AppId" "{{129DFB73-9F6D-4E99-AC3E-5179E7FE5177}"
  setpath "product" "win32UserAppId" "{{CFE7F0B0-3CBD-412A-A307-443D441288D0}"
  setpath "product" "win32x64UserAppId" "{{ED383973-5A73-42F5-8715-F5FA05E3EF64}"
  setpath "product" "win32arm64UserAppId" "{{ADEFF792-CC4F-4FB8-9865-1AF9EE7CA31C}"
  setpath "product" "tunnelApplicationName" "cide-tunnel"
  setpath "product" "win32TunnelServiceMutex" "cide-tunnelservice"
  setpath "product" "win32TunnelMutex" "cide-tunnel"
  setpath "product" "win32ContextMenu.x64.clsid" "A8FB88DD-C036-45D5-B48D-536CC2B5D56A"
  setpath "product" "win32ContextMenu.arm64.clsid" "C461A53D-466E-4640-9B22-FE1D1736EB1C"
fi

setpath_json "product" "tunnelApplicationConfig" '{}'

jsonTmp=$( jq -s '.[0] * .[1]' product.json ../product.json )
echo "${jsonTmp}" > product.json && unset jsonTmp

cat product.json
# }}}

# include common functions
. ../utils.sh

# {{{ apply patches

echo "APP_NAME=\"${APP_NAME}\""
echo "APP_NAME_LC=\"${APP_NAME_LC}\""
echo "ASSETS_REPOSITORY=\"${ASSETS_REPOSITORY}\""
echo "BINARY_NAME=\"${BINARY_NAME}\""
echo "GH_REPO_PATH=\"${GH_REPO_PATH}\""
echo "GLOBAL_DIRNAME=\"${GLOBAL_DIRNAME}\""
echo "ORG_NAME=\"${ORG_NAME}\""
echo "TUNNEL_APP_NAME=\"${TUNNEL_APP_NAME}\""

if [[ "${DISABLE_UPDATE}" == "yes" ]]; then
  mv ../patches/disable-update.patch.yet ../patches/disable-update.patch
fi

for file in ../patches/*.patch; do
  if [[ -f "${file}" ]]; then
    apply_patch "${file}"
  fi
done

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  for file in ../patches/insider/*.patch; do
    if [[ -f "${file}" ]]; then
      apply_patch "${file}"
    fi
  done
fi

if [[ -d "../patches/${OS_NAME}/" ]]; then
  for file in "../patches/${OS_NAME}/"*.patch; do
    if [[ -f "${file}" ]]; then
      apply_patch "${file}"
    fi
  done
fi

for file in ../patches/user/*.patch; do
  if [[ -f "${file}" ]]; then
    apply_patch "${file}"
  fi
done
# }}}

set -x

# {{{ install dependencies
export ELECTRON_SKIP_BINARY_DOWNLOAD=1
export PLAYWRIGHT_SKIP_BROWSER_DOWNLOAD=1

if [[ "${OS_NAME}" == "linux" ]]; then
  export VSCODE_SKIP_NODE_VERSION_CHECK=1

  if [[ "${npm_config_arch}" == "arm" ]]; then
    export npm_config_arm_version=7
  fi
elif [[ "${OS_NAME}" == "windows" ]]; then
  if [[ "${npm_config_arch}" == "arm" ]]; then
    export npm_config_arm_version=7
  fi
else
  if [[ "${CI_BUILD}" != "no" ]]; then
    clang++ --version
  fi
fi

node build/npm/preinstall.ts

mv .npmrc .npmrc.bak
cp ../npmrc .npmrc

for i in {1..5}; do
  if [[ "${CI_BUILD}" != "no" && "${OS_NAME}" == "osx" ]]; then
    CXX=clang++ npm ci && break
  else
    npm ci && break
  fi

  if [[ $i == 5 ]]; then
    echo "Npm install failed too many times" >&2
    exit 1
  fi
  echo "Npm install failed $i, trying again..."
  sleep $(( 15 * (i + 1)))
done

mv .npmrc.bak .npmrc
# }}}

# {{{ install bundled extensions into .build/extensions/ before gulp packaging
if compgen -G "../bundled-extensions/*.vsix" > /dev/null 2>&1; then
  echo "Installing bundled extensions..."
  mkdir -p .build/extensions

  for vsix in ../bundled-extensions/*.vsix; do
    [[ -f "${vsix}" ]] || continue
    vsix_basename=$(basename "${vsix}")
    echo "  Staging: ${vsix_basename}"

    tmp_dir=$(mktemp -d)
    unzip -q "${vsix}" -d "${tmp_dir}"

    if [[ ! -f "${tmp_dir}/extension/package.json" ]]; then
      echo "  Skipping ${vsix_basename}: no extension/package.json found" >&2
      rm -rf "${tmp_dir}"
      continue
    fi

    publisher=$(jq -r '.publisher' "${tmp_dir}/extension/package.json")
    name=$(jq -r '.name' "${tmp_dir}/extension/package.json")
    version=$(jq -r '.version' "${tmp_dir}/extension/package.json")
    ext_dir=".build/extensions/${publisher}.${name}-${version}"

    rm -rf "${ext_dir}"
    mv "${tmp_dir}/extension" "${ext_dir}"
    rm -rf "${tmp_dir}"

    echo "  Staged ${publisher}.${name}@${version}"
  done
fi
# }}}

# package.json
cp package.json{,.bak}

setpath "package" "version" "${RELEASE_VERSION%-insider}"

replace 's|Microsoft Corporation|CIDE|' package.json

cp resources/server/manifest.json{,.bak}

if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
  setpath "resources/server/manifest" "name" "CIDE - Insiders"
  setpath "resources/server/manifest" "short_name" "CIDE - Insiders"
else
  setpath "resources/server/manifest" "name" "CIDE"
  setpath "resources/server/manifest" "short_name" "CIDE"
fi

# announcements
replace "s|\\[\\/\\* BUILTIN_ANNOUNCEMENTS \\*\\/\\]|$( tr -d '\n' < ../announcements-builtin.json )|" src/vs/workbench/contrib/welcomeGettingStarted/browser/gettingStarted.ts

../undo_telemetry.sh

replace 's|Microsoft Corporation|CIDE|' build/lib/electron.ts
replace 's|([0-9]) Microsoft|\1 CIDE|' build/lib/electron.ts

if [[ "${OS_NAME}" == "linux" ]]; then
  if [[ "${VSCODE_QUALITY}" == "insider" ]]; then
    sed -i "s/code-oss/cide-insiders/" resources/linux/debian/postinst.template
  else
    sed -i "s/code-oss/cide/" resources/linux/debian/postinst.template
  fi

  sed -i 's|Visual Studio Code|CIDE|g' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/'"${GH_REPO_PATH}"'#download-install|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com/home/home-screenshot-linux-lg.png|https://github.com/'"${GH_REPO_PATH}"'/raw/main/docs/screenshot.png|' resources/linux/code.appdata.xml
  sed -i 's|https://code.visualstudio.com|https://github.com/'"${GH_REPO_PATH}"'|' resources/linux/code.appdata.xml

  sed -i 's|Microsoft Corporation <vscode-linux@microsoft.com>|CIDE contributors|' resources/linux/debian/control.template
  sed -i 's|Visual Studio Code|CIDE|g' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/'"${GH_REPO_PATH}"'#download-install|' resources/linux/debian/control.template
  sed -i 's|https://code.visualstudio.com|https://github.com/'"${GH_REPO_PATH}"'|' resources/linux/debian/control.template

  sed -i 's|Microsoft Corporation|CIDE contributors|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code Team <vscode-linux@microsoft.com>|CIDE contributors|' resources/linux/rpm/code.spec.template
  sed -i 's|Visual Studio Code|CIDE|' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com/docs/setup/linux|https://github.com/'"${GH_REPO_PATH}"'#download-install|' resources/linux/rpm/code.spec.template
  sed -i 's|https://code.visualstudio.com|https://github.com/'"${GH_REPO_PATH}"'|' resources/linux/rpm/code.spec.template
elif [[ "${OS_NAME}" == "windows" ]]; then
  sed -i 's|https://code.visualstudio.com|https://github.com/'"${GH_REPO_PATH}"'|' build/win32/code.iss
  sed -i 's|Microsoft Corporation|CIDE|' build/win32/code.iss
fi

cd ..

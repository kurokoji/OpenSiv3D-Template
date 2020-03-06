#!/bin/bash

source ./version

if [ "$(uname)" = 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr "$(uname -s)" 1 5)" = 'Linux' ]; then
  OS='Linux'
else
  echo 'Windows'
fi


if [ "${OS}" = 'Mac' ]; then
  TEMPLATE_DIR="./siv3d_v${CURRENT_VERSION}_macOS"

  if ! [ -e ".archive/${TEMPLATE_DIR}.zip" ]; then
    curl --create-dirs -o ".archive/${TEMPLATE_DIR}.zip" "https://siv3d.jp/downloads/Siv3D/siv3d_v${CURRENT_VERSION}_macOS.zip"
  fi

  unzip ".archive/${TEMPLATE_DIR}.zip"
  cp -r "${TEMPLATE_DIR}/include" .
  cp -r "${TEMPLATE_DIR}/lib" .

  if ! [ -e ./resources ]; then
    mkdir resources
  fi

  cp -r "${TEMPLATE_DIR}/examples/empty/App/engine" ./resources
  cp "${TEMPLATE_DIR}/examples/empty/icon.icns" ./resources

  rm -r ${TEMPLATE_DIR}

elif [ "${OS}" = 'Linux' ]; then
  echo 'Not support'
else
  echo 'Not support'
fi

#!/bin/bash

CURRENT_VERSION='0.4.1'

if [ "$(uname)" = 'Darwin' ]; then
  OS='Mac'
elif [ "$(expr substr "$(uname -s)" 1 5)" = 'Linux' ]; then
  OS='Linux'
else
  echo 'hoge'
fi


if [ "${OS}" = 'Mac' ]; then
  wget "https://siv3d.jp/downloads/Siv3D/siv3d_v${CURRENT_VERSION}_macOS.zip"
  unzip "./siv3d_v${CURRENT_VERSION}_macOS"
  cp -r "./siv3d_v${CURRENT_VERSION}_macOS/include" .
  cp -r "./siv3d_v${CURRENT_VERSION}_macOS/lib" .
  cp -r "./siv3d_v${CURRENT_VERSION}_macOS/examples/empty/App/engine" .
  cp "./siv3d_v${CURRENT_VERSION}_macOS/examples/empty/icon.icns" .

  rm -r "./siv3d_v${CURRENT_VERSION}_macOS"
  rm "./siv3d_v${CURRENT_VERSION}_macOS.zip"

elif [ "${OS}" = 'Linux' ]; then
  echo 'hoge'
else
  echo 'hoge'
fi

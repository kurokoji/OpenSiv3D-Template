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
  rm "./siv3d_v${CURRENT_VERSION}_macOS.zip"
  rm -r "./siv3d_v${CURRENT_VERSION}_macOS"
  rm -r "./include"
  rm -r "./lib"
  rm -r "./engine"
  rm "./icon.icns"

elif [ "${OS}" = 'Linux' ]; then
  echo 'hoge'
else
  echo 'hoge'
fi

#!/bin/bash

rm -rf ./nvim
rm ./ghostty-config

cp -r ~/.config/nvim ./ 
cp ~/.config/ghostty/config ./ghostty-config

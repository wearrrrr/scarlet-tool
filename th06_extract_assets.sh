#!/bin/bash
# Created by wearr :3
title=$(base64 -d <<<"ICAgICAgICAgICAgICAgICAgICBfICAgICAgXyAgICAgICAgICBfICAgICAgICAgICAgICBfIAogICAgICAgICAgICAgICAgICAgfCB8ICAgIHwgfCAgICAgICAgfCB8ICAgICAgICAgICAgfCB8CiBfX18gIF9fXyBfXyBfIF8gX198IHwgX19ffCB8XyBfX19fX198IHxfIF9fXyAgIF9fXyB8IHwKLyBfX3wvIF9fLyBfYCB8ICdfX3wgfC8gXyB8IF9ffF9fX19fX3wgX18vIF8gXCAvIF8gXHwgfApcX18gfCAoX3wgKF98IHwgfCAgfCB8ICBfX3wgfF8gICAgICAgfCB8fCAoXykgfCAoXykgfCB8CnxfX18vXF9fX1xfXyxffF98ICB8X3xcX19ffFxfX3wgICAgICAgXF9fXF9fXy8gXF9fXy98X3w=")
system_language==$(locale | grep LANGUAGE | cut -d= -f2 | cut -d_ -f1)

printf "\x1b[48;5;%sm%3d\e[m " "124" "1"

printf "\e[1;91m${title}\n"

function checkDirectoryValid() {
    if [[ ! -d $1 ]]
    then 
        if [ $system_language = "jp" ]; then
            echo "ディレクトリが見つかりませんでした。 '${1}'"
        else
            echo "Directory not found. '${1}'"
        fi
        exit
    else 
        if [ $system_language = "jp" ]; then
            echo "ディレクトリ 「OK」。"
        else
            echo "Directory [OK]"
        fi
    fi
}

function extract() {
    if [ $system_language = "jp" ]; then
        echo "抽出中: $1..."
    else
        echo "Extracting: $1..."
    fi
    mkdir -p extracted_assets/$file
    thdat -C extracted_assets/$1 -x 6 $1 1> /dev/null
}

if [ $system_language = "jp" ]; then
    echo "Scarlet Toolにようこそ！" 
    printf "EoSDゲームファイルの場所: "
    read assets_directory
    checkDirectoryValid $assets_directory
    cd $assets_directory
    echo "アセットを抽出中..."
    mkdir -p extracted_assets
    for file in *.DAT; do
    (( n = RANDOM % 10 ))
        # score.dat is unextractable for now.
        if [ $file == "score.dat" ]; then
            continue
        fi
        extract "$file"
        sleep $(( n / 10 )).$(( n % 10 ))
    done
    echo "抽出が完了しました！"
    echo "ウェアラーが作成した「Scarlet Tool」"
else
    echo "Welcome to Scarlet Tool!"
    printf "EoSD Game Files Location: "
    read assets_directory
    checkDirectoryValid $assets_directory
    cd $assets_directory
    echo "Extracting assets..."
    mkdir -p extracted_assets
    for file in *.DAT; do
    (( n = RANDOM % 10 ))
        if [ $file == "score.DAT" ]; then
            continue
        fi
        extract "$file"
        sleep $(( n / 10 )).$(( n % 10 ))
    done
    echo "Extraction complete!"
    echo "Scarlet Tool by wearr"
fi
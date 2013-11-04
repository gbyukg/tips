#!/bin/env/bash
shopt -s -o nounset

readonly tip_dir="$HOME/.tips"
cur_file=${tip_dir}
file_count=0

cd ${tip_dir}

cat_file()
{
  local random_file
  local random_num

  # 忽略ig_开头的文件
  files=($(ls -F ${cur_file}| grep -iv '^ig_.*'))
  file_count=${#files[@]}
  if [[ ${file_count} -eq 0 ]]; then
    [ ${cur_file} == ${tip_dir} ] && echo "根目录\"${tip_dir}\"为空目录" && exit
    [ ${cur_file} != ${tip_dir} ] && cur_file="${cur_file%/*/}" && cat_file && return
  fi

  # 获取随机文件
  random_num=$((RANDOM%+${file_count}))
  random_file=${files[${random_num}]}
  cur_file="${cur_file}/${random_file}"
  # echo $cur_file

  [ ! -d ${cur_file} ] && cat ${cur_file} || {
    cat_file
  }

}

cat_file


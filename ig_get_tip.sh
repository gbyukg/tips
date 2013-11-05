#!/usr/bin/env bash

#set -e
shopt -s -o nounset

readonly tip_dir="$HOME/.tips"
cur_file=${tip_dir}

while getopts :f:l: opt
do
  case $opt in
    f)
      cur_file="${tip_dir}/${OPTARG}"
      ;;
    l)
      cur_file="${OPTARG}"
      ;;
    *)
      cur_file=${tip_dir}
      ;;
esac
done

cd ${tip_dir} || {
  echo "not found directory ${tip_dir}"
  exit 1
}

cat_file()
{
  local random_file
  local random_num
  local file_count

  # 忽略ig_开头的文件
  files=($(ls -F ${cur_file}| grep -iv '^ig_.*'))
  file_count=${#files[@]}
  if [[ ${file_count} -eq 0 ]]; then
    [ ${cur_file} == ${tip_dir} ] && {
      echo "根目录\"${tip_dir}\"为空目录"
      exit 1
    } || {
      cur_file="${cur_file%/*/}"
      cat_file
      return
    }
  fi

  # 获取随机文件
  random_num=$((RANDOM%+${file_count}))
  random_file=${files[${random_num}]}
  cur_file="${cur_file}/${random_file}"

  [ ! -d ${cur_file} ] && cat ${cur_file} || {
    cat_file
  }

}

cat_file
echo ${cur_file}


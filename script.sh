#!/bin/bash
function create_file_xls {  # функция для обработки файлов в директории
 for file in "$1"/*  # цикл для перебора файлов
  do
  this_file="${file##*/}" # выделение имени файла из абсолютного пути
  if [ -d "$file" ] # проверка - является ли файл директорией
  then
   create_file_xls "$file" # рекурсивный вызов функции для обработки файлов во вложенной директории
  else
   name="${this_file%.[^.]*}" # выделение имени файла с помощью регулярного выражения
   extension="${this_file##*.}" # выделение расширения файла
   data_of_change=$(date +%Y-%m-%d -r "$file" 2>/dev/null)  # дата последнего изменения с помощью команды data
   if [[ -z "$name" && -n "$extension" ]]; then          # проверка для файлов без имени
    name=".$extension"
    extension=""
   fi
   size=$(wc -c 2>/dev/null <"$file" | awk '{print $1}' ) # получение размера файла в байтах (выделение первого аргумента команды wc -c с помощью awk)
   duration=$(mediainfo --Inform="General;%Duration%" $file) # получение размера файла в байтах (выделение первого аргумента команды wc -c с помощью awk)
   let "duration_sec=duration/1000" # получение длины видео в с
   echo -e "$name \t $extension \t $data_of_change \t $size "B" \t $duration_sec" >> result.xls # дозапись строки вывода в файл .xls
   fi
  done
}
IFS=$'\t'
echo "Enter the name of the directory"                # вывод в командную строку предложения о вводе нужной папки для перебора
read div                                              # считывание данных из командной строки
if [ -d "$div" ]; then                                # проверка на верность пути
  create_file_xls "$div"                              # вызов функции для обработки файлов в директории
else
  echo "Неверный путь"
fi
echo "End of the script"

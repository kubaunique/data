########## USERS VAR ###############
path_main_folder="/content/drive/MyDrive/white_river_dataset"  
percent_files="13" 
########## USERS VAR ###############

################################# SORT DATA TO FOLDERS ######################################################
echo "Создаю папку val"
mkdir -p "$path_main_folder/val"

ls "$path_main_folder" | grep -v -E "val|train" | while read -r CLASS; do
    echo "=== Обработка класса: $CLASS ==="
    class_path="$path_main_folder/$CLASS"
    val_class_path="$path_main_folder/val/$CLASS"
    
    mkdir -p "$val_class_path"

    total_files=$(ls "$class_path" | wc -l)
    val_count=$(($total_files * $percent_files / 100))
    
    echo "Всего файлов: $total_files | Переносим в val: $val_count"

    ls "$class_path" | shuf | head -n "$val_count" | while read -r FILE; do
        mv "$class_path/$FILE" "$val_class_path/"
    done
done
################################# SORT DATA TO FOLDERS ######################################################


################################# MOVE REMAINING DATA TO TRAIN ######################################################
echo "Создаю папку train и перемещаю оставшиеся"
mkdir -p "$path_main_folder/train"

ls "$path_main_folder" | grep -v -E "val|train" | while read -r CLASS; do
    mv "$path_main_folder/$CLASS" "$path_main_folder/train/"
done
################################# MOVE REMAINING DATA TO TRAIN ######################################################

echo "Разделение завершено. Созданы папки train/ и val/"

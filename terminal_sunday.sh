#!/bin/bash

# Определение цветов для вывода
RED="\033[41m  \033[0m"
GREEN="\033[42m  \033[0m"
GAP=" " # Зазор между элементами

# Проверка наличия необходимых аргументов
if [ $# -lt 1 ]; then
  echo "Usage: $0 birthdate [username]"
  echo "Example: $0 1985-06-08 Joe"
  exit 1
fi

birthdate=$1 # Первый аргумент - дата рождения
name=${2:-$USER} # Второй аргумент - имя пользователя, по умолчанию $USER

life_expectancy=80     # Ожидаемая продолжительность жизни в годах
last_year_index=$((life_expectancy - 1))

case "$(uname)" in
  "Linux")
    birth_year=$(date -d "$birthdate" +"%Y")
    birth_timestamp=$(date -d "$birthdate" +%s)
    ;;
  "Darwin")
    birth_year=$(date -j -f "%Y-%m-%d" "$birthdate" +"%Y")
    birth_timestamp=$(date -j -f "%Y-%m-%d" "$birthdate" +%s)
    ;;
  *) echo "Unsupported OS"; exit 1 ;;
esac

current_year=$(date +"%Y")
current_timestamp=$(date +%s)
years_passed=$((current_year - birth_year))
weeks_passed=$(( (current_timestamp - birth_timestamp) / 604800 ))
total_weeks=$((life_expectancy * 52))
weeks_remaining=$((total_weeks - weeks_passed))

# Выводим имя и оставшееся количество недель
echo -e "$name, only $weeks_remaining Sundays remain\n"

# Выводим сетку с группировкой по годам 20x4
for (( row=0; row<4; row++ )); do
    for (( col=0; col<20; col++ )); do
        year_index=$((row * 20 + col))
          if (( year_index == 0 )); then
            echo $birth_year
          fi
        if (( year_index < years_passed )); then
            # Прошедшие годы закрашиваем красным
            echo -ne "${RED}${GAP}"
        else
            # Еще не прошедшие годы закрашиваем зеленым
            echo -ne "${GREEN}${GAP}"
        fi
    done
    echo # Новая строка после каждой строки сетки
    if (( year_index != $last_year_index )); then
      echo
    fi
done

printf ' %.0s' {1..55}
last_year=$((birth_year + last_year_index))
echo $last_year

echo -e "\nHow are you going to spend these Sundays, $name?"

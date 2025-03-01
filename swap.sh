#!/bin/bash
#Проверка на наличие информации о свопах
sudo swapon --show
free -h
#Проверка доступного места на жестком диске
df -h
read -p "Достаточно места? Если нет, нажмите "n": " answer
if [ $answer = n ] ; then
  exit 0
else
  echo "Продолжаем настройку SWAP"
fi
#Создание SWAP файла
read "На сколько GB будет создан SWAP файл? Введи цифру: " G
sudo fallocate -l "$G"G /swapfile
ls -lh /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
sudo swapon --show
if [ -e /etc/fstab ] ; then
  echo
else
  echo "Файл /etc/fstab отсутствует"
  exit 1
fi
sudo cp /etc/fstab /etc/fstab.bak
echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab

#!/bin/bash

make_swap() {
#Проверка на наличие информации о свопах
sudo swapon --show
free -h
if [ -e /swapfile ] ; then
  echo "Файл swapfile уже создан."
  exit 0
fi
#Проверка доступного места на жестком диске
df -h
read -p "Достаточно места? Если нет, нажмите "n": " answer
if [ "$answer" = n ] ; then
  exit 0
else
  echo "Продолжаем настройку SWAP"
fi
#Создание SWAP файла
read -p "На сколько GB будет создан SWAP файл? Введи цифру: " G
sudo fallocate -l "$G"G /swapfile
sudo chmod 600 /swapfile
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
}

delete_swap() {
sudo swapoff -v /swapfile
echo "Удали упоминание о файле подкачке из /etc/fstab"
sudo vim /etc/fstab
sudo rm /swapfile
}

read -p "Создать или удалить SWAPFILE?
Создать(1)
Удалить(2)
: " or 
case $or in
  1) make_swap ;;
  2) delete_swap ;;
  *) exit
esac

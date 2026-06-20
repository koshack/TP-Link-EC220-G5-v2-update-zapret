#!/bin/bash

# Скачиваем конкретную версию zapret (например, v72.12)
wget -O /tmp/zapret.tar.gz https://github.com/bol-van/zapret/releases/download/v72.12/zapret-v72.12-openwrt-embedded.tar.gz

# Распаковываем
tar -xzf /tmp/zapret.tar.gz -C /tmp/

# Копируем бинарники в исходники прошивки (путь подходит для репозитория danayer)
cp /tmp/zapret-v72.12-openwrt-embedded/binaries/linux-mipsel/nfqws ./trunk/user/zapret/nfqws
cp /tmp/zapret-v72.12-openwrt-embedded/binaries/linux-mipsel/tpws ./trunk/user/zapret/tpws

#!/bin/bash

# Сначала скачиваем и распаковываем исходники Padavan (это делает сам workflow, но мы можем это сделать для поиска)
# Но проще — после того, как исходники распакованы, мы можем поискать файлы nfqws и tpws

# Дождёмся, пока исходники будут готовы (это произойдёт в шаге "Download sources and toolchain" до нашего скрипта)

# Ищем все файлы nfqws и tpws в распакованной папке padavan-ng
echo "=== Searching for nfqws and tpws in padavan-ng ==="
find padavan-ng -name "nfqws" -o -name "tpws" 2>/dev/null || echo "Not found"

# Если файлы найдены, выведем их пути и размеры
find padavan-ng -name "nfqws" -o -name "tpws" -exec ls -la {} \; 2>/dev/null

# Теперь скачаем свежие бинарники и скопируем их поверх найденных
# Но сначала определим, где они лежат (если найдены)
NFQWS_PATH=$(find padavan-ng -name "nfqws" | head -1)
TPWS_PATH=$(find padavan-ng -name "tpws" | head -1)

if [[ -n "$NFQWS_PATH" && -n "$TPWS_PATH" ]]; then
    echo "Found nfqws at $NFQWS_PATH"
    echo "Found tpws at $TPWS_PATH"

    # Скачиваем актуальную версию zapret
    wget -O /tmp/zapret.tar.gz https://github.com/bol-van/zapret/releases/download/v72.12/zapret-v72.12-openwrt-embedded.tar.gz
    tar -xzf /tmp/zapret.tar.gz -C /tmp/

    # Копируем новые бинарники поверх старых
    cp /tmp/zapret-v72.12-openwrt-embedded/binaries/linux-mipsel/nfqws "$NFQWS_PATH"
    cp /tmp/zapret-v72.12-openwrt-embedded/binaries/linux-mipsel/tpws "$TPWS_PATH"

    echo "Updated nfqws and tpws"
else
    echo "ERROR: nfqws or tpws not found in padavan-ng sources"
fi

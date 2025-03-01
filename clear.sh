#!/bin/bash
#Освобождегние папки /var/cache
for a in `ls /var/cache/apt/archives | grep '\.deb$' | cut -d _ -f1 | sort | uniq`; do
    ls -tr /var/cache/apt/archives/${a}_* | sed '$ d' | xargs -r -p sudo rm -v
done

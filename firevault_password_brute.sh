#!/bin/bash
curl <wordlist url>  > /var/tmp/words.txt
input="/var/tmp/words.txt"
sed -e "s/^M//" $input > /var/tmp/betterwords.txt
dict="/var/tmp/betterwords.txt"

while IFS= read line
do
        echo "Trying password: $line"
        diskutil coreStorage unlockVolume <Volume ID Here> -passphrase $line
        if [ $? -eq 0 ]; then
                echo "Device unlocked!\nPassword is: $line"
                break
        else
                continue
        fi
done < "$dict"

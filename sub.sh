#!/bin/bash 

url=$1


if [ ! -d "$url" ]; then
        mkdir $url 
fi

if [ ! -d "$url/recon" ]; then
        mkdir $url/recon
fi

echo "[+] Harvesting SubDomains with AssetFinder..."
assetfinder $url >> $url/recon/assets.txt

cat $url/recon/assets.txt | grep $1 >> $url/recon/final.txt
rm $url/recon/assets.txt



#echo "[+] Harvesting SubDomains with Amass..."
#amass enum -d $url >>  $url/recon/amass.txt
#sort -u $url/recon/amass.txt >> $url/recon/final.txt
#rm $url/recon/amass.txt



echo "[+] Probing for alive domains ..."
cat  $url/recon/final.txt | sort -u | httprobe -s -p https:443 | sed 's/https\?:\/\///' | tr -d ':443' >> $url/recon/alive.txt


#!/bin/bash

md5sum mystery_img1.txt mystery_img2.txt msg.txt fcfm.png > check.txt

VAR1="5db9862819edb16f9ac0f3b1c406e79d  mystery_img.txt
b091a841da98ca516635f4dfea1dbaf5  mystery_img2.txt
40744679dff4bf36705c00f9cb815579  msg.txt
4260808329804b5f553cf3e3d5a446c6  fcfm.png"

VAR2="`cat check.txt`"

if [[ "$var1" -eq "$var2" ]] ; then
	base64 --decode < mystery_img1.txt > mystery_img1_decoded.jpg
	base64 --decode < mystery_img2.txt > mystery_img2_decoded.jpg
	base64 < msg.txt > msg_encoded.txt
	base64 < fcfm.png > fcfm_encoded.txt
	$echo "Se ha realizado con exito"
else
	$echo "Los archivos han sido modificados"
fi


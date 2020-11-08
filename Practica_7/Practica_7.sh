#!/bin/sh

ip address
public="`curl ifconfig.me`"

nmap 10.0.2.*>private.txt
nmap scanme.nmap.org>segment.txt
nmap $public>public.txt

base64 < private.txt > private_encoded.txt
base64 < segment.txt > segment_encoded.txt
base64 < public.txt > public_encoded.tx



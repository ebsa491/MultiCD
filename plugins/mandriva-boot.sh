#!/bin/sh
set -e
#Mandriva installer plugin for multicd.sh
#version 6.5
#Copyright (c) 2011 libertyernie
#
#Permission is hereby granted, free of charge, to any person obtaining a copy
#of this software and associated documentation files (the "Software"), to deal
#in the Software without restriction, including without limitation the rights
#to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
#copies of the Software, and to permit persons to whom the Software is
#furnished to do so, subject to the following conditions:
#
#The above copyright notice and this permission notice shall be included in
#all copies or substantial portions of the Software.
#
#THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
#IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
#FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
#AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
#LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
#OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
#THE SOFTWARE.
if [ $1 = scan ];then
	if [ -f mandriva-boot.iso ];then
		echo "Mandriva netboot installer"
	fi
elif [ $1 = copy ];then
	if [ -f mandriva-boot.iso ];then
		echo "Copying Mandriva netboot installer..."
		mcdmount mandriva-boot
		mkdir $WORK/boot/mandriva
		cp -r $MNT/mandriva-boot/isolinux/alt0 $WORK/boot/mandriva/
		cp -r $MNT/mandriva-boot/isolinux/alt1 $WORK/boot/mandriva/
		umcdmount mandriva-boot
	fi
elif [ $1 = writecfg ];then
if [ -f mandriva-boot.iso ];then
cat >> $WORK/boot/isolinux/isolinux.cfg << "EOF"
label alt0
  menu label Install ^Mandriva
  kernel /boot/mandriva/alt0/vmlinuz
  append initrd=/boot/mandriva/alt0/all.rdz  vga=788 splash=silent
label alt0-vgahi
  menu label Install Mandriva (hi-res installer)
  kernel /boot/mandriva/alt0/vmlinuz
  append initrd=/boot/mandriva/alt0/all.rdz  vga=791
label alt0-text
  menu label Install Mandriva (text-mode installer)
  kernel /boot/mandriva/alt0/vmlinuz
  append initrd=/boot/mandriva/alt0/all.rdz  text
label alt1
  menu label Install Mandriva (server kernel)
  kernel /boot/mandriva/alt1/vmlinuz
  append initrd=/boot/mandriva/alt1/all.rdz vga=788 splash=silent
EOF
fi
else
	echo "Usage: $0 {scan|copy|writecfg}"
	echo "Use only from within multicd.sh or a compatible script!"
	echo "Don't use this plugin script on its own!"
fi

make
insmod romfs.ko hided_file_name="aa" encryp_file_name="bb" exec_file_name="cc"
mount -o loop ../test.img ../t
echo "\npractice 1\n"
find ../t
echo "\npractice 2\n"
cat ../t/bb
echo "\npractice 3\n"
ls -l ../t
echo "\ntest finish!\n"
umount ../test.img
rmmod romfs.ko
make clean

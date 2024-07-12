exe="appImageCraft" #你需要发布的程序名称
des="/run/media/root/Study/opt/myApp/ImageCraft/" #程序所在路径
deplist=$(ldd $exe | awk  '{if (match($3,"/")){ printf("%s "),$3 } }')
cp $deplist $des

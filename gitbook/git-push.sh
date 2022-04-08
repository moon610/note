 
#if [ ! $1 ]
#then
#  echo "####### 请输入commit值 #######"
#  exit;
#fi
 
#给出一个默认的项目路径
#path="/Users/duodian/Desktop/work/miniProgram"
 
 
#先进入项目当中
 
#cd $path
 
#echo "####### 进入自己的项目 #######"
 

echo "开始编译gitbook"

gitbook build . note

 
echo "开始执行git命令"
 
git add .
 
git status
 
#写个sleep 1s 是为了解决并发导致卡壳
 
sleep 1s
 
echo "####### 添加文件 #######"
 
#git commit -m "$1"

git commit -m "update note `date +%Y-%m-%d,%H:%M:%S`" 
 
echo "####### commit #######"
 
sleep 1s
 
echo "####### 开始推送note #######"
 
#if [ ! $3 ]
#then
#  echo "####### 请输入自己提交代码的分支 #######"
#  exit;
#fi
 
#git push origin "$3"

git push
 
echo "####### 推送成功note #######"

echo "####### 复制到GitPage #######"

cp -rf ./note ../../moon610.github.io

echo "####### 进入GitPage目录 #######"

cd ../../moon610.github.io

echo "开始执行git命令"
 
git add .
 
git status
 
#写个sleep 1s 是为了解决并发导致卡壳
 
sleep 1s
 
echo "####### 添加文件 #######"
 
git commit -m "update note `date +%Y-%m-%d,%H:%M:%S`" 
 
echo "####### commit #######"
 
sleep 1s
 
echo "####### 开始推送page #######"

git push origin develop
 
echo "####### 推送成功page #######"
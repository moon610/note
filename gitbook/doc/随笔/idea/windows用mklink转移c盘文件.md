
符号链接是在文件系统上实现的链接，对操作系统上大多数软件来说是透明的，也就是说，当软件访问符号链接时，其实际上是在访问该符号链接所指向的文件(夹)

**注意：软链接的创建需要管理员权限，确保cmd是管理员模式。对于文件夹的软链接创建，一定要加上"/D"。通过相对路径创建的软链接在移动后无法使用，绝对路径创建的移动后不影响使用。符号链接可以直接右键删除，或通过rmdir命令删除，不会影响原文件，但del命令则会把目标文件删除。**
       创建的符号链接显示的类型是文件夹，实际上相当于是指向D盘真实的resource路径的快捷方式，符号链接本身不占空间。  路径映射的过程对迅雷来说是透明的，迅雷对这个符号链接的操作实际上是对resource文件夹的操作，因此迅雷可以正常运行。   另外，符号链接和目录联接是有快捷方式的那个箭头的，只不过我修改了注册表所以这里不显示。  符号链接与Linux下的软链接很相似，因此网上很多资料都会把ntfs的符号链接叫做软链接。
用Disk Space Fan 4对C盘进行扫描，发现Adobe的数据文件占用了1G多的空间，而这些数据根本用不着放固态浪费空间，于是可以把这个文件夹剪切到D盘合适路径下，这个路径由自己决定，放哪都可以。  因为这个文件夹放在“C:ProgramData”，为了方便管理我在D盘也新建了ProgramData文件夹，然后把Adobe这个文件夹剪切过来。   期间需要对文件夹的权限做下处理，因为部分软件对文件夹设了权限，只有赋予了权限才能移动、编辑文件夹。  需要注意的是，在移动文件时要先把软件相关的进程和服务关闭。  文件传输结束后输入命令：
mklink /d "C:\ProgramData\Adobe" "D:\ProgramData\Adobe" 
**以上例子只是方便理解，实际操作不太推荐使用剪切，而应该把文件夹复制过去，没问题了再把原来文件删除，避免数据丢失，数据无价，谨慎操作。**



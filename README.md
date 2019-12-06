# rm_
    Linux代替rm命令防止错误删除文件  

# Build
    git clone https://github.com/niuyuling/rm_.git  
    cd rm_  
    make clean; make  
    
# Help Information
    root@niuyuling:/mnt/c/Users/niuyuling/Desktop/rm# touch a.txt b.txt ../c.txt  
    root@niuyuling:/mnt/c/Users/niuyuling/Desktop/rm# ./rm_ a.txt b.txt  ../c.txt  
    /delete/ 垃圾桶目录存在  
    移动到 /delete/a.txt  
    移动到 /delete/b.txt  
    移动到 /delete/c.txt  
    a.txt 删除成功  
    b.txt 删除成功  
    ../c.txt 删除成功  
    root@niuyuling:/mnt/c/Users/niuyuling/Desktop/rm#  
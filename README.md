# rm_
    代替rm命令防止错误删除文件  
    基于coreutils-8.32 mv源代码

# Build
    git clone https://github.com/niuyuling/rm_.git  
    cd rm_ 
    apt-get build-dep coreutils
    bash build_mv.sh
    
# Help Information
    root@niuyuling:/mnt/c/Users/niuyuling/Desktop/Arm-tool# rm_ busybox-1.31.1  
    rm_ 
    busybox-1.31.1  
    /tmp/   
    3   
    root@niuyuling:/mnt/c/Users/niuyuling/Desktop/Arm-tool# 
    
    #支持配置文件
    root@NIUYULING:/mnt/c/Users/niuyuling/Desktop/rm_# cat /etc/rm_.conf
    /opt/
    root@NIUYULING:/mnt/c/Users/niuyuling/Desktop/rm_#
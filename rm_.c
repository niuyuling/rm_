#include "rm_.h"

int copyfile(char *old_file, char *new_file)
{
    FILE *fp1 = NULL;           //指向源文件
    FILE *fp2 = NULL;           //指向目的文件
    char buffer[1024] = { 0 };  //缓存
    int n = 0;                  //文件大小

    if ((old_file == NULL) || (new_file == NULL)) {
        return -1;
    }

    if ((fp1 = fopen(old_file, "r")) != NULL) {
        if ((fp2 = fopen(new_file, "w")) != NULL) {
            while ((n = fread(buffer, 1, sizeof(buffer), fp1)) > 0) {
                fwrite(buffer, n, 1, fp2);
                memset(buffer, 0, sizeof(buffer));
            }
            fclose(fp1);
            fclose(fp2);
            return 1;
        }
    }

    return 0;
}

int main(int argc, char **argv)
{
    char new_file[CACHE_SIZE];
    bzero(new_file, 0);

    if ((getuid()) != 0) {
        printf("Root用户运行?\n");
        return -1;
    }

    if (argc == 1) {
        printf("%s file1 file2 file3 ...\n", argv[0]);
        return -1;
    }

    if (!access(DELETE, 0)) {
        printf("%s 垃圾桶目录存在\n", DELETE);
    } else {
        printf("%s 创建垃圾桶目录\n", DELETE);
        if ((mkdir(DELETE, S_IRWXU | S_IRGRP | S_IXGRP | S_IROTH | S_IXOTH)) ==
            0) {
            printf("%s 创建垃圾桶成功\n", DELETE);
        }
    }

    for (int i = 1; i < argc; i++) {
        bzero(new_file, 0);
        strcpy(new_file, DELETE);
        
        char *p;        // 去除./ ../ ../../ ...
        p=strrchr(argv[i],'/');
        if (p != NULL)
            p=p+1;
        else {
            p=argv[i];
        }       
        strcat(new_file, p);
        
        printf("移动到 %s\n", new_file);
        
        cp(argv[i], new_file);

    }

    for (int i = 1; i < argc; i++) {
        if (remove(argv[i]) == 0) {
            printf("%s 删除成功\n", argv[i]);
        } else {
            printf("%s 删除失败\n", argv[i]);
        }
    }

    return 0;
}

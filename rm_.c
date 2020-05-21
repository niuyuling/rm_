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

int mkdir_r(const char *path)
{
    if (path == NULL) {
        return -1;
    }
    char *temp = strdup(path);
    char *pos = temp;

    /* 去掉开头的 './' 或 '/' */
    if (strncmp(temp, "/", 1) == 0) {
        pos += 1;
    } else if (strncmp(temp, "./", 2) == 0) {
        pos += 2;
    }

    /* 循环创建目录 */
    for (; *pos != '\0'; ++pos) {
        if (*pos == '/') {
            *pos = '\0';
            mkdir(temp, 0755);
            //printf("for %s\n", temp);
            *pos = '/';
        }
    }

    /* 如果最后一级目录不是以'/'结尾，
       遇到'\0'就中止循环，
       不会创建最后一级目录 */
    if (*(pos - 1) != '/') {
        //printf("if %s\n", temp);
        mkdir(temp, 0755);
    }
    free(temp);
    return 0;
}

void help_information(void)
{
    puts("\
    RM_\n\
Secure deletion of files and directories\n\
Author: aixiao@aixiao.me\n\
\n\
Usage: rm_ [optinos] [File] [File]...\n\
    Options:\n\
        -h,-?           :    print help\n\
        -c file         :    config file (default: /etc/rm_.conf)\n\
        -t directory    :    Trash can directory\n\
        \
    ");
}

int main(int argc, char **argv)
{
    char buffer[1024];
    char new_file[CACHE_SIZE];
    char tmp[CACHE_SIZE];
    char config[CACHE_SIZE];
    char directory[CACHE_SIZE];
    int opt, i;
    char *p, *p1;
    FILE *fp;

    memset(directory, 0, CACHE_SIZE);
    memset(config, 0, CACHE_SIZE);
    strcpy(config, "/etc/rm_.conf");
    char optstring[] = "c:t:h?";
    while (-1 != (opt = getopt(argc, argv, optstring))) {
        switch (opt) {
        case 'c':
            strcpy(config, optarg);
            break;
        case 't':
            strcpy(directory, optarg);
            break;
        case 'h':
        case '?':
            help_information();
            exit(0);
            break;
        }

    }

    // 配置文件读取
    memset(buffer, 0, CACHE_SIZE);
    memset(new_file, 0, CACHE_SIZE);
    memset(tmp, 0, CACHE_SIZE);
    fp = fopen(config, "r");
    if (fp == NULL) {
        printf("读取配置文件错误！\n");
        exit(1);
    }
    fread(buffer, sizeof(buffer), 1, fp);
    fclose(fp);
    p = strchr(buffer, '\n');
    if (p) {
        buffer[strlen(buffer) - 1] = 0;
    } else {
        printf("配置文件读取错误!\n");
        exit(1);
    }
    if ((p = strchr(buffer, '\n'))) {
        printf("配置文件读取错误!\n");
        exit(1);
    }
    if (directory != NULL) {
        if (strlen(directory) == 0) {
            ;
        } else {
             memset(buffer, 0, strlen(buffer));
             strcpy(buffer, directory);
        }
    }
    
    if (buffer[strlen(buffer)-1] != '/') {
        printf("垃圾桶目录格式错误!\n");
        exit(1);
    }
    
    // 检测root用户
    if ((getuid()) != 0) {
        printf("Root用户运行?\n");
        return -1;
    }
    
    // 创建目录
    if (!access(buffer, 0)) {
        //printf("%s 垃圾桶目录存在\n", buffer);
        ;
    } else {
        printf("%s 创建垃圾桶目录\n", buffer);
        mkdir_r(buffer);
    }

    // 备份文件
    for (i = optind; i < argc; i++) {
        strcpy(new_file, buffer);

        // 假如 argv[i] 为 "../a/" 就取 a
        // 假如 argv[i] 为 "../a" 就取 a
        // 假如 argv[i] 为 "../a/b" 就取 b
        // 假如 argv[i] 为 "../a/b/" 就取 b
        // 假如 argv[i] 为 "a" 就取 a
        // 假如 argv[i] 为 "a/" 就取 a
        p = strrchr(argv[i], '/');
        if (p != NULL) {
            if (argv[i][strlen(argv[i]) - 1] == '/') {
                memcpy(tmp, argv[i], strlen(argv[i]) - 1);
                p = strrchr(tmp, '/');
                p1 = strchr(tmp, '/');
                if (p1 != NULL) {
                    p = strrchr(tmp, '/');
                    p = p + 1;
                } else
                    p = tmp;
            } else {
                p = p + 1;
            }
        } else {
            p = argv[i];
        }

        strcat(new_file, p);
        printf("移动到 %s\n", new_file);

        if(fork() == 0) {
            if (execlp("cp", "cp", "-rf", argv[i], new_file, (char *)0) == -1)
                printf("execlp pwd error");
        }
        wait(NULL);

    }

    // 删除文件
    for (i = optind; i < argc; i++) {
        if(fork() == 0) {
            if (execlp("rm", "rm", "-rf", argv[i], (char *)0) == -1)
                printf("execlp pwd error");
        }
        wait(NULL);
    }

    return 0;
}


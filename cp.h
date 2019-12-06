#ifndef CP_H
#define CP_H

#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <stdlib.h>
#include <linux/limits.h>
#include <dirent.h>
#include <sys/stat.h>
#include <errno.h>
#include <sys/types.h>
#include <fcntl.h>
#include <stdint.h>

#define PARAM_NONE 	0
#define PARAM_F 	1
#define PARAM_R 	2
#define PARAM_L 	4
#define PARAM_S 	8
#define PARAM_V 	16

#define MY_ERR(x) my_err(x,__LINE__)

void my_err(const char *err_string, int line);
void cp(const char *src, const char *dst);
void get_name(char *name, const char *pathname);
void cp_real(int fd, const char *src, const char *dst);

#endif

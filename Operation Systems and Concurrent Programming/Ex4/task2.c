#include <fcntl.h> 
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int main(int argc, char *argv[]){
    if (argc != 2){
        write(1, "Wrong number of arguments\n",26);
        return -1;
    }
    int file1 = open(argv[1], O_WRONLY | O_CREAT, 0666);
    if (file1 == -1)
    {
        printf("errno: %d\n", errno);
        perror("Opening a file");
        return 1;
    }
    char buf[20];
    int n;
    while((n=read(0, buf, 20)) > 0){
        write(1, buf, n);
        write(file1, buf, n);
    }
    close(file1);
    return 0;
}
#include <fcntl.h> 
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int main(int argc, char *argv[]){
    if (argc != 3){
        write(1, "Wrong number of arguments\n",26);
        return -1;
    }
    int file1 = open(argv[1], O_RDONLY);
    if (file1 == -1)
    {
        printf("errno: %d\n", errno);
        perror("Opening a file");
        return 1;
    }
    int file2 = open(argv[2], O_RDWR | O_CREAT, 0666);
    if (file2 == -1)
    {
        printf("errno: %d\n", errno);
        perror("Opening a file");
        close(file1);
        return 1;
    }
    char buf[20];
    int n;
    while((n=read(file1, buf, 20)) > 0){
        write(file2, buf, n);
    }
    close(file2);
    close(file1);
    return 0;
}
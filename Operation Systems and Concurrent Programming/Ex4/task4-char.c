#include <fcntl.h> 
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int main(int argc, char *argv[]){
    if (argc != 2){
        write(1, "Wrong number of arguments\n",26);
        return -1;
    }
    int file1 = open(argv[1], O_RDONLY, 0666);
    if (file1 == -1)
    {
        printf("errno: %d\n", errno);
        perror("Opening a file");
        return 1;
    }
    lseek(file1, 1, SEEK_END);
    char a[1];
    do{
        int n = read(file1,a,1);
        write(1,a,n);
    }while (lseek(file1,-2,SEEK_CUR) != SEEK_SET);
    int n = read(file1,a,1);
    write(1,a,n);
    close(file1);
    return 0;
}
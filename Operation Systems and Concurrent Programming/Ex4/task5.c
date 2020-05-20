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
    char f1[2];
    char f2[2];
    int n1 =read(file1, f1, 2);
    int n2 = read(file1, f2, 2);
    while(n1>0 && n2>0){
        if(f1[0] <= f2[0]){
            write(1, f1, 2);
            n1 = read(file1, f1, 2);
        }else{
            write(1, f2, 2);
            n2 = read(file2, f2, 2);
        }
    }
    while(n1 > 0){
        write(1, f1,2);
        n1 = read(file1, f1,2);
    }
    while(n2 > 0){
        write(1, f2,2);
        n2 = read(file2, f2,2);
    }
    close(file2);
    close(file1);
    return 0;
}
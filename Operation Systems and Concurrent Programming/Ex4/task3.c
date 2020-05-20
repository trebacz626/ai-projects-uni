#include <fcntl.h> 
#include <unistd.h>
#include <stdio.h>
#include <errno.h>

int main(int argc, char *argv[]){
    if (argc != 2){
        write(1, "Wrong number of arguments\n",26);
        return -1;
    }
    int file1 = open(argv[1], O_RDONLY | O_CREAT, 0666);
    if (file1 == -1)
    {
        printf("errno: %d\n", errno);
        perror("Opening a file");
        return 1;
    }
    char a[1];
    int n_chars =0;
    int n_lines = 0;
    int n;
    while((n=read(file1, a, 1)) > 0){
        n_chars++;
        if(a[0] == '\n'){
            n_lines++;
        }
    }
    n_lines++;
    close(file1);
    printf("chars: %d\nlines: %d\n", n_chars, n_lines);
    return 0;
}
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/wait.h>

int main()
{
    int fd[2];
    pid_t ch1, ch2, ch3;
    pipe(fd);
    if ((ch1 = fork()) == 0)
    {
        close(fd[0]);
        dup2(fd[1], 1);
        execlp("ls", "ls", "-l", "/tmp", NULL);
        exit(1);
    }
    else
    {
        int fd2[2];
        pipe(fd2);
        if ((ch2 = fork()) == 0)
        {
            close(fd[1]);
            close(fd2[0]);
            dup2(fd[0], 0);
            dup2(fd2[1], 1);
            execlp("sort", "sort", "-n", "-k", "5,5", NULL);
            exit(1);
        }
        else
        {
            if((ch3 = fork()) == 0)
            {
                close(fd[0]);
                close(fd[1]);
                close(fd2[1]);
                dup2(fd2[0], 0);
                execlp("tail", "tail", "-5", NULL);
                exit(1);
            }
            else
            {
                close(fd[0]);
                close(fd[1]);
                close(fd2[0]);
                close(fd2[1]);
                wait(NULL);
                wait(NULL);
                wait(NULL);
                exit(0);
            }
        }
    }
}
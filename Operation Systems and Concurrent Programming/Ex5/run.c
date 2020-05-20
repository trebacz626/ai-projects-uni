#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <sys/time.h>
#include <sys/wait.h>
#include <sys/types.h>

int main(int argc, char *argv[])
{
    struct timeval end_tv;
    struct timeval start_tv;
    if (fork() == 0)
    {
        execvp(argv[1], argv+1);
    }
    else
    {
        gettimeofday(&start_tv, NULL);
        wait(NULL);
        gettimeofday(&end_tv, NULL);
        float exec_time = end_tv.tv_sec - start_tv.tv_sec + (end_tv.tv_usec - start_tv.tv_usec) / 1000000.0;
        printf("Time: %f\n", exec_time);
    }
    return 0;
}
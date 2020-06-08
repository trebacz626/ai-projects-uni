#include <sys/mman.h>
#include <fcntl.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#define N 2

int main(int argc, char *argv[])
{
    sem_t *sem_reader, *sem_writer;
    sem_reader = sem_open("/reader", 0, 0600, 0);
    sem_writer = sem_open("/writer", 0, 0600, 0);
    while (1)
    {
        sem_wait(sem_writer);
        for(int i = 0; i < N; i++){
            sem_wait(sem_reader);
            printf("Writer occupies %d places in library\n",i+1);
        }
        printf("Writer starts writing\n");
        sleep(5);
        printf("Writer finished writing\n");
        for(int i = 0; i < N; i++){
            sem_post(sem_reader);
            printf("Writer freed %d places in library\n",i+1);
        }
        sem_post(sem_writer);
        sleep(10);
    }
}
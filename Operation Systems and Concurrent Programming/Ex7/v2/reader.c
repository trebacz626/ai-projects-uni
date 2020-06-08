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
        sem_wait(sem_reader);
        sem_post(sem_writer);
        printf("Reader starts reading\n");
        sleep(4);
        printf("Reader finished reading\n");
        sem_post(sem_reader);
        sleep(2);

    }
}
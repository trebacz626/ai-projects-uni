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
    sem_reader = sem_open("/reader", O_CREAT, 0600, N);
    sem_writer = sem_open("/writer", O_CREAT, 0600, 1);
}
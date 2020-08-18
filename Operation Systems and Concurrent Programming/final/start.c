#include <sys/mman.h>
#include <fcntl.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>

#define N 10
int main(int argc, char *argv[])
{
    sem_t *sem_consumer_counter, *sem_producer_counter, *sem_producer_sync, *sem_consumer_sync;
    sem_consumer_counter = sem_open("/consumer_counter", O_CREAT, 0600, 0);
    sem_producer_counter = sem_open("/producer_counter", O_CREAT, 0600, N);
    sem_consumer_sync = sem_open("/consumer_sync", O_CREAT, 0600, 1);
    sem_producer_sync = sem_open("/producer_sync", O_CREAT, 0600, 1);
    int fd = shm_open("/memory", O_CREAT | O_RDWR, 0600);
    ftruncate(fd, (N+2)*sizeof(int));
    int *addr = mmap(NULL, (N+2)*sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

    addr[N+1] = -1;//consumer index
    addr[N+2] = -1;// producer index
}
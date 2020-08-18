#include <sys/mman.h>
#include <fcntl.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>
#include <stdlib.h>
#include <sys/time.h> 
#include <time.h>
#define N 10

int main(int argc, char *argv[])
{
    sem_t *sem_consumer_counter, *sem_producer_counter, *sem_producer_sync;
    sem_consumer_counter = sem_open("/consumer_counter", 0, 0600, 0);
    sem_producer_counter = sem_open("/producer_counter", 0, 0600, 0);
    sem_producer_sync = sem_open("/producer_sync", 0, 0600, 0);
    int fd = shm_open("/memory", O_CREAT | O_RDWR, 0600);
    int *addr = mmap(NULL, (N+2)*sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);
    srand(time(0));
    int product_type = atoi(argv[1]);
    // printf("I produce %d\n", product_type);
    while (1)
    {  
        //pretend that you are doing sth
        sleep(rand() % 5); 
        sem_wait(sem_producer_counter);
        sem_wait(sem_producer_sync);
        //produce to buffer
        struct timeval start;
        // gettimeofday(&start, NULL);
        // printf("time %ld.%ld\n", start.tv_sec,start.tv_usec);
        addr[N+2] = (addr[N+2]+1) % N;
        addr[addr[N+2]] = product_type;
        printf("produced %d\n", product_type);
        sem_post(sem_producer_sync);
        sem_post(sem_consumer_counter);
    }
}
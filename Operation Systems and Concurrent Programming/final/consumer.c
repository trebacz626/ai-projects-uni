#include <sys/mman.h>
#include <fcntl.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>
#include <time.h>
#include <stdlib.h>

#define N 10


int main(int argc, char *argv[])
{
    sem_t *sem_consumer_counter, *sem_producer_counter, *sem_consumer_sync;
    sem_consumer_counter = sem_open("/consumer_counter", 0, 0600, 0);
    sem_producer_counter = sem_open("/producer_counter", 0, 0600, 0);
    sem_consumer_sync = sem_open("/consumer_sync", 0, 0600, 0);
    int fd = shm_open("/memory", O_RDWR, 0600);
    if(sem_consumer_counter == SEM_FAILED || sem_producer_counter == SEM_FAILED || sem_consumer_sync == SEM_FAILED || fd == -1){
        printf("Could not access means of synchronisations, please run start first \n");
        return 1;
    }
    int *addr = mmap(NULL, (N+2)*sizeof(int), PROT_READ|PROT_WRITE, MAP_SHARED, fd, 0);

    while (1)
    {

        sem_wait(sem_consumer_counter);
        sem_wait(sem_consumer_sync);
        //consume from buffer
        addr[N+1] = (addr[N+1]+1) % N;
        printf("Consuming %d\n", addr[addr[N+1]]);
        // end consume from buffer
        sem_post(sem_consumer_sync);
        //pretend that you are doing sth 
        sleep(rand() % 5);
        sem_post(sem_producer_counter);
    }
}
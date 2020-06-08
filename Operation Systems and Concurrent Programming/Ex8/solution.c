#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <semaphore.h>
#include <pthread.h>
#include <unistd.h>

#define N 20

const int SIZE = 10000;

sem_t sem_consumer, sem_producer;
int buffer[N];

void *producer(void *arg)
{
    int i = 0;
    while (i < SIZE)
    {
        sem_wait(&sem_producer);
        buffer[i % N] = i;
        sem_post(&sem_consumer);
        i++;
    }
}

void *consumer(void *arg)
{
    int i = 0;
    while (i < SIZE)
    {
        sem_wait(&sem_consumer);
        printf("reading digit %d\n", buffer[i % N]);
        sem_post(&sem_producer);
        i++;
    }
}

int main()
{
    sem_init(&sem_consumer, 1, 0);
    sem_init(&sem_producer, 1, N);
    pthread_t th_producer, th_consumer;

    pthread_create(&th_consumer, NULL, consumer, NULL);
    pthread_create(&th_producer, NULL, producer, NULL);

    pthread_join(th_producer, NULL);
    pthread_join(th_consumer, NULL);
    return 0;
}
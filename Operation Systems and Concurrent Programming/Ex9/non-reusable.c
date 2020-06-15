#include <stdio.h>
#include <stdlib.h>
#include <sys/mman.h>
#include <sys/stat.h>
#include <fcntl.h>
#include <semaphore.h>
#include <pthread.h>
#include <unistd.h>


const int n = 5;
int numOfWaitingThreads = 0;
pthread_mutex_t m;
pthread_cond_t c;

void barrier(int n)
{
     pthread_mutex_lock(&m);
     numOfWaitingThreads++;
     if( numOfWaitingThreads == n){
         pthread_cond_broadcast(&c);

     }else{
         while(numOfWaitingThreads != n){
             pthread_cond_wait(&c,&m);
         }
     }
     pthread_mutex_unlock(&m);
}

void *worker(void *args){
    int i =*((int*) args);
    printf("Worker %d is working\n", i);
    sleep(i);
    barrier(n);
    printf("Worker %d goes with his friends to a bar\n", i);
}

int main()
{
    pthread_mutex_init(&m, NULL);
    pthread_cond_init(&c, NULL);
    pthread_t th_worker [n];
    int ids[n];
    for(int i = 0; i < n; i++){
        ids[i] = i;
        pthread_create(&th_worker[i],NULL,worker,&ids[i]);
    }
    for( int i = 0; i < n; i++){
        pthread_join(th_worker[i], NULL);
    }
    printf("Finished\n");
    return 0;
}
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
int numOfThreadsThatLeftBarrier = 0;
pthread_mutex_t m;
pthread_cond_t c;
pthread_cond_t left;

void barrier(int n)
{
     pthread_mutex_lock(&m);
     numOfWaitingThreads++;
     if( numOfWaitingThreads == n){
         pthread_cond_broadcast(&c);
         while(numOfThreadsThatLeftBarrier != n-1){
             pthread_cond_wait(&left,&m);
         }
        numOfWaitingThreads = 0;
        numOfThreadsThatLeftBarrier=0;

     }else{
         while(numOfWaitingThreads != n){
             pthread_cond_wait(&c,&m);
         }
         numOfThreadsThatLeftBarrier++;
         if(numOfThreadsThatLeftBarrier == n-1){
             pthread_cond_signal(&left);
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
    pthread_cond_init(&left, NULL);
    pthread_t th_worker [n];
    int shiftDuration[n];
    for(int i = 0; i < n; i++){
        shiftDuration[i] = i;
        pthread_create(&th_worker[i],NULL,worker,&shiftDuration[i]);
    }
    for( int i = 0; i < n; i++){
        pthread_join(th_worker[i], NULL);
    }
    printf("Finished %d %d\n",numOfWaitingThreads,numOfThreadsThatLeftBarrier);//checking if barrier could be reused
    return 0;
}
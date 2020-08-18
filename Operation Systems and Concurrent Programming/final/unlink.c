#include <sys/mman.h>
#include <fcntl.h>
#include <semaphore.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <sys/stat.h>

int main(int argc, char *argv[])
{
    sem_unlink("/consumer_counter");
    sem_unlink("/producer_counter");
    sem_unlink("/consumer_sync");
    sem_unlink("/producer_sync");
    shm_unlink("/memory");
}
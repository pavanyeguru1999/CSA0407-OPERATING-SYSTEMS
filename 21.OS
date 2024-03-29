#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <semaphore.h>
#include <unistd.h>
#define NUM_READERS 3
#define NUM_WRITERS 2
int shared_resource = 0;
int readers_count = 0;
sem_t mutex;  
sem_t wrt;    
void *reader(void *arg) {
    int reader_id = *((int *)arg);
    while (1) {
        sem_wait(&mutex);
        readers_count++;
        if (readers_count == 1) {
            sem_wait(&wrt); 
        }
        sem_post(&mutex);
        printf("Reader %d read: %d\n", reader_id, shared_resource);
        usleep(rand() % 10); 
        sem_wait(&mutex);
        readers_count--;
        if (readers_count == 0) {
            sem_post(&wrt); 
        }
        sem_post(&mutex);

        usleep(rand() % 10); 
    }
}
void *writer(void *arg) {
    int writer_id = *((int *)arg);
    while (1) {
        sem_wait(&wrt);
        shared_resource++;
        printf("Writer %d wrote: %d\n", writer_id, shared_resource);
        sem_post(&wrt);

        usleep(rand() % 10); 
    }
}
int main() {
    pthread_t reader_threads[NUM_READERS], writer_threads[NUM_WRITERS];
    int reader_ids[NUM_READERS], writer_ids[NUM_WRITERS];
    sem_init(&mutex, 0, 1);
    sem_init(&wrt, 0, 1);
    for (int i = 0; i < NUM_READERS; i++) {
        reader_ids[i] = i + 1;
        pthread_create(&reader_threads[i], NULL, reader, &reader_ids[i]);
    }
    for (int i = 0; i < NUM_WRITERS; i++) {
        writer_ids[i] = i + 1;
        pthread_create(&writer_threads[i], NULL, writer, &writer_ids[i]);
    }
    for (int i = 0; i < NUM_READERS; i++) {
        pthread_join(reader_threads[i], NULL);
    }
    for (int i = 0; i < NUM_WRITERS; i++) {
        pthread_join(writer_threads[i], NULL);
    }
    sem_destroy(&mutex);
    sem_destroy(&wrt);
    return 0;
}

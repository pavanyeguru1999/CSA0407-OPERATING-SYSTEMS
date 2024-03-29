#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#include <unistd.h>

#define BUFFER_SIZE 5
#define NUM_ITEMS 10

int buffer[BUFFER_SIZE];
int in = 0;
int out = 0;
int count = 0;

pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
pthread_cond_t full = PTHREAD_COND_INITIALIZER;
pthread_cond_t empty = PTHREAD_COND_INITIALIZER;

void *producer(void *arg) {
    int i;
    for (i = 0; i < NUM_ITEMS; i++) {
        pthread_mutex_lock(&mutex);
        while (count == BUFFER_SIZE) {
            pthread_cond_wait(&empty, &mutex);
        }
        buffer[in] = i;
        printf("Produced item: %d\n", buffer[in]);
        in = (in + 1) % BUFFER_SIZE;
        count++;
        pthread_cond_signal(&full);
        pthread_mutex_unlock(&mutex);
        usleep(100000); 
    }
    pthread_exit(NULL);
}

void *consumer(void *arg) {
    int i;
    for (i = 0; i < NUM_ITEMS; i++) {
        pthread_mutex_lock(&mutex);
        while (count == 0) {
            pthread_cond_wait(&full, &mutex);
        }
        int item = buffer[out];
        printf("Consumed item: %d\n", item);
        out = (out + 1) % BUFFER_SIZE;
        count--;
        pthread_cond_signal(&empty);
        pthread_mutex_unlock(&mutex);
        usleep(100000); 
    }
    pthread_exit(NULL);
}

int main() {
    pthread_t producer_thread, consumer_thread;

    if (pthread_create(&producer_thread, NULL, producer, NULL) != 0) {
        perror("pthread_create");
        exit(EXIT_FAILURE);
    }
    if (pthread_create(&consumer_thread, NULL, consumer, NULL) != 0) {
        perror("pthread_create");
        exit(EXIT_FAILURE);
    }

    
    if (pthread_join(producer_thread, NULL) != 0) {
        perror("pthread_join");
        exit(EXIT_FAILURE);
    }
    if (pthread_join(consumer_thread, NULL) != 0) {
        perror("pthread_join");
        exit(EXIT_FAILURE);
    }

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>
#define NUM_THREADS 2
#define COUNT_MAX 10
int count = 0;
pthread_mutex_t mutex;
void *increment_counter(void *thread_id) {
    int tid = *(int *)thread_id;
    for (int i = 0; i < COUNT_MAX; i++) {
        pthread_mutex_lock(&mutex);
        count++;
        printf("Thread %d: Count = %d\n", tid, count);
        pthread_mutex_unlock(&mutex);
    }
    pthread_exit(NULL);
}
int main() {
    pthread_t threads[NUM_THREADS];
    int thread_ids[NUM_THREADS];
    if (pthread_mutex_init(&mutex, NULL) != 0) {
        printf("Mutex initialization failed\n");
        return 1;
    }
    for (int i = 0; i < NUM_THREADS; i++) {
        thread_ids[i] = i;
        if (pthread_create(&threads[i], NULL, increment_counter, (void *)&thread_ids[i]) != 0) {
            printf("Thread creation failed\n");
            return 1;
        }
    }
    for (int i = 0; i < NUM_THREADS; i++) {
        pthread_join(threads[i], NULL);
    }
    pthread_mutex_destroy(&mutex);

    return 0;
}

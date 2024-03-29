#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *thread_function(void *arg) {
    printf("Inside the thread function\n");
    pthread_exit(NULL);
}

int main() {
    pthread_t tid;
    int result;

    result = pthread_create(&tid, NULL, thread_function, NULL);
    if (result != 0) {
        perror("pthread_create");
        exit(EXIT_FAILURE);
    }

    printf("Thread created successfully\n");

    pthread_exit(NULL); 

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *thread_function(void *arg) {
    printf("Inside the thread function\n");
    pthread_exit(NULL);
}

int main() {
    pthread_t tid;
    int result;

    result = pthread_create(&tid, NULL, thread_function, NULL);
    if (result != 0) {
        perror("pthread_create");
        exit(EXIT_FAILURE);
    }

    printf("Thread created successfully\n");
    result = pthread_join(tid, NULL);
    if (result != 0) {
        perror("pthread_join");
        exit(EXIT_FAILURE);
    }

    printf("Thread joined successfully\n");

    pthread_exit(NULL);
}

#include <stdio.h>
#include <pthread.h>

void *thread_function(void *arg) {
    printf("Inside the thread function\n");
    pthread_exit(NULL);
}

int main() {
    pthread_t tid1, tid2;
    int result;

    pthread_create(&tid1, NULL, thread_function, NULL);
    pthread_create(&tid2, NULL, thread_function, NULL);
    if (pthread_equal(tid1, tid2)) {
        printf("Thread IDs are equal\n");
    } else {
        printf("Thread IDs are not equal\n");
    }

    pthread_exit(NULL);
}

#include <stdio.h>
#include <stdlib.h>
#include <pthread.h>

void *thread_function(void *arg) {
    printf("Inside the thread function\n");
    pthread_exit(NULL);
}

int main() {
    pthread_t tid;
    int result;

    result = pthread_create(&tid, NULL, thread_function, NULL);
    if (result != 0) {
        perror("pthread_create");
        exit(EXIT_FAILURE);
    }

    printf("Thread created successfully\n");

    pthread_exit(NULL); 
}

#include <stdio.h>
#include <stdlib.h>

#define MAX_REQUESTS 100
void fcfs(int requests[], int num_requests, int initial_position) {
    int current_position = initial_position;
    int total_seek_time = 0;

    printf("Sequence of disk access:\n");
    printf("%d ", current_position);

    for (int i = 0; i < num_requests; i++) {
        total_seek_time += abs(requests[i] - current_position);
        current_position = requests[i];
        printf("%d ", current_position);
    }

    printf("\nTotal seek time: %d\n", total_seek_time);
}

int main() {
    int requests[MAX_REQUESTS];
    int num_requests, initial_position;

    printf("Enter the number of disk requests: ");
    scanf("%d", &num_requests);

    if (num_requests <= 0 || num_requests > MAX_REQUESTS) {
        printf("Invalid number of requests\n");
        return 1;
    }

    printf("Enter the initial position of the disk head: ");
    scanf("%d", &initial_position);

    printf("Enter the disk requests:\n");
    for (int i = 0; i < num_requests; i++) {
        scanf("%d", &requests[i]);
    }

    fcfs(requests, num_requests, initial_position);

    return 0;
}

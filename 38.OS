#include <stdio.h>
#include <stdlib.h>

#define MAX_REQUESTS 100
#define DIRECTION_LEFT -1
#define DIRECTION_RIGHT 1
void scan(int requests[], int num_requests, int initial_position, int direction, int max_cylinder) {
    int current_position = initial_position;
    int total_seek_time = 0;
    int visited[MAX_REQUESTS] = {0};
    int min_cylinder = 0, max_cylinder_index = 0;

    printf("Sequence of disk access:\n");
    printf("%d ", current_position);

    for (int i = 0; i < num_requests; i++) {
        if (requests[i] < min_cylinder) {
            min_cylinder = requests[i];
        }
        if (requests[i] > max_cylinder) {
            max_cylinder = requests[i];
            max_cylinder_index = i;
        }
    }

    requests[num_requests++] = current_position;

    for (int i = 0; i < num_requests - 1; i++) {
        for (int j = i + 1; j < num_requests; j++) {
            if (direction == DIRECTION_RIGHT && requests[i] > requests[j]) {
                int temp = requests[i];
                requests[i] = requests[j];
                requests[j] = temp;
            } else if (direction == DIRECTION_LEFT && requests[i] < requests[j]) {
                int temp = requests[i];
                requests[i] = requests[j];
                requests[j] = temp;
            }
        }
    }

    int current_position_index = 0;
    for (int i = 0; i < num_requests; i++) {
        if (requests[i] == current_position) {
            current_position_index = i;
            break;
        }
    }

    printf("%d ", requests[current_position_index]);
    for (int i = current_position_index + 1; i < num_requests; i++) {
        if (!visited[i]) {
            printf("%d ", requests[i]);
            total_seek_time += abs(requests[i] - current_position);
            current_position = requests[i];
            visited[i] = 1;
        }
    }
    if (direction == DIRECTION_RIGHT && max_cylinder_index < num_requests - 1) {
        printf("%d ", max_cylinder);
        total_seek_time += abs(max_cylinder - current_position);
        current_position = max_cylinder;
    }
    for (int i = current_position_index - 1; i >= 0; i--) {
        if (!visited[i]) {
            printf("%d ", requests[i]);
            total_seek_time += abs(requests[i] - current_position);
            current_position = requests[i];
            visited[i] = 1;
        }
    }

    printf("\nTotal seek time: %d\n", total_seek_time);
}

int main() {
    int requests[MAX_REQUESTS];
    int num_requests, initial_position, direction, max_cylinder;

    printf("Enter the number of disk requests: ");
    scanf("%d", &num_requests);

    if (num_requests <= 0 || num_requests > MAX_REQUESTS) {
        printf("Invalid number of requests\n");
        return 1;
    }

    printf("Enter the initial position of the disk head: ");
    scanf("%d", &initial_position);

    printf("Enter the direction of movement (1 for right, -1 for left): ");
    scanf("%d", &direction);
    if (direction != DIRECTION_RIGHT && direction != DIRECTION_LEFT) {
        printf("Invalid direction\n");
        return 1;
    }

    printf("Enter the maximum cylinder number: ");
    scanf("%d", &max_cylinder);

    printf("Enter the disk requests:\n");
    for (int i = 0; i < num_requests; i++) {
        scanf("%d", &requests[i]);
    }

    scan(requests, num_requests, initial_position, direction, max_cylinder);

    return 0;
}

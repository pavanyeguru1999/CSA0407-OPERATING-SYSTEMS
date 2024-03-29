#include <stdio.h>

struct Process {
    int id, arrival, burst, completion, turnaround, waiting;
};

int main() {
    int n, total_waiting = 0, total_turnaround = 0;
    printf("Enter the number of processes: ");
    scanf("%d", &n);
    struct Process p[n];

    printf("Enter arrival time and burst time for each process:\n");
    for (int i = 0; i < n; i++) {
        printf("Process %d: ", i + 1);
        scanf("%d%d", &p[i].arrival, &p[i].burst);
        p[i].id = i + 1;
    }

    p[0].completion = p[0].burst;
    p[0].turnaround = p[0].completion - p[0].arrival;
    p[0].waiting = p[0].turnaround - p[0].burst;
    total_waiting += p[0].waiting;
    total_turnaround += p[0].turnaround;

    for (int i = 1; i < n; i++) {
        p[i].completion = p[i - 1].completion + p[i].burst;
        p[i].turnaround = p[i].completion - p[i].arrival;
        p[i].waiting = p[i].turnaround - p[i].burst;
        total_waiting += p[i].waiting;
        total_turnaround += p[i].turnaround;
    }

    printf("\nProcess\tArrival\tBurst\tCompletion\tTurnaround\tWaiting\n");
    for (int i = 0; i < n; i++) {
        printf("%d\t%d\t%d\t%d\t\t%d\t\t%d\n", p[i].id, p[i].arrival, p[i].burst, p[i].completion, p[i].turnaround, p[i].waiting);
    }

    printf("\nAverage Turnaround Time: %.2f\n", (float)total_turnaround / n);
    printf("Average Waiting Time: %.2f\n", (float)total_waiting / n);

    return 0;
}

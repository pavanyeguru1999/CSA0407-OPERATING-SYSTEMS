#include <stdio.h>

#define MAX_BLOCKS 10
#define MAX_PROCESS 10

void bestFit(int blockSize[], int m, int processSize[], int n) {
    int allocation[MAX_PROCESS];
    int i, j, minIdx;
    for (i = 0; i < n; i++)
        allocation[i] = -1;
    for (i = 0; i < n; i++) {
       
        minIdx = -1;
        for (j = 0; j < m; j++) {
            if (blockSize[j] >= processSize[i]) {
                if (minIdx == -1 || blockSize[j] < blockSize[minIdx])
                    minIdx = j;
            }
        }

        if (minIdx != -1) {
            
            allocation[i] = minIdx;

            
            blockSize[minIdx] -= processSize[i];
        }
    }

  
    printf("\nProcess No.\tProcess Size\tBlock No.\n");
    for (i = 0; i < n; i++) {
        printf(" %d\t\t%d\t\t", i+1, processSize[i]);
        if (allocation[i] != -1)
            printf("%d\n", allocation[i] + 1);
        else
            printf("Not Allocated\n");
    }
}

int main() {
    int blockSize[MAX_BLOCKS], processSize[MAX_PROCESS];
    int m, n, i;

    printf("Enter the number of memory blocks: ");
    scanf("%d", &m);
    printf("Enter the size of each memory block:\n");
    for (i = 0; i < m; i++)
        scanf("%d", &blockSize[i]);

    printf("Enter the number of processes: ");
    scanf("%d", &n);
    printf("Enter the size of each process:\n");
    for (i = 0; i < n; i++)
        scanf("%d", &processSize[i]);

    bestFit(blockSize, m, processSize, n);

    return 0;
}

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_LINE_LENGTH 1000

int main(int argc, char *argv[]) {
    if (argc < 3) {
        printf("Usage: %s <search_pattern> <filename>\n", argv[0]);
        return 1;
    }

    char *search_pattern = argv[1];
    char *filename = argv[2];

    FILE *file = fopen(filename, "r");
    if (file == NULL) {
        perror("fopen");
        return 1;
    }

    char line[MAX_LINE_LENGTH];
    while (fgets(line, sizeof(line), file)) {
        if (strstr(line, search_pattern) != NULL) {
            printf("%s", line);
        }
    }

    fclose(file);
    return 0;
}

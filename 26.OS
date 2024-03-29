#include <stdio.h>
#include <stdlib.h>

int main() {
    FILE *fp;
    char filename[] = "example.txt";
    char buffer[100];
    fp = fopen(filename, "w");
    if (fp == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    fprintf(fp, "Hello, this is a test.\n");
    printf("Data written to the file.\n");
    fclose(fp);
    fp = fopen(filename, "r");
    if (fp == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }

  
    fgets(buffer, sizeof(buffer), fp);
    printf("Data read from the file:\n%s", buffer);
    fclose(fp);

    
    fp = fopen(filename, "a");
    if (fp == NULL) {
        perror("fopen");
        exit(EXIT_FAILURE);
    }
    fprintf(fp, "This is an additional line.\n");
    printf("Additional data written to the file.\n");
    fclose(fp);

    return 0;
}

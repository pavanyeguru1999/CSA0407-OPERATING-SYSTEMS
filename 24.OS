#include <stdio.h>
#include <stdlib.h>
#include <fcntl.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/stat.h>

int main() {
    int fd, nbytes;
    char buffer[100];
    char filename[] = "example.txt";

    fd = creat(filename, S_IRUSR | S_IWUSR);
    if (fd == -1) {
        perror("creat");
        exit(EXIT_FAILURE);
    }
    printf("File created successfully.\n");
    write(fd, "Hello, this is a test.\n", 23);
    printf("Data written to the file.\n");

    close(fd);
    printf("File closed.\n");

    fd = open(filename, O_RDONLY);
    if (fd == -1) {
        perror("open");
        exit(EXIT_FAILURE);
    }

    nbytes = read(fd, buffer, sizeof(buffer));
    if (nbytes == -1) {
        perror("read");
        exit(EXIT_FAILURE);
    }

    buffer[nbytes] = '\0';
    printf("Data read from the file:\n%s\n", buffer);

    close(fd);
    printf("File closed.\n");

    if (unlink(filename) == -1) {
        perror("unlink");
        exit(EXIT_FAILURE);
    }
    printf("File deleted.\n");

    return 0;
}

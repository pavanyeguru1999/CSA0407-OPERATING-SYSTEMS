#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>

int main(int argc, char *argv[]) {
    DIR *dir;
    struct dirent *entry;

    
    if (argc == 1) {
        dir = opendir(".");
    } else {
       
        dir = opendir(argv[1]);
    }

    if (!dir) {
        perror("opendir");
        exit(EXIT_FAILURE);
    }

    
    while ((entry = readdir(dir)) != NULL) {
        printf("%s\n", entry->d_name);
    }

   
    closedir(dir);

    return 0;
}

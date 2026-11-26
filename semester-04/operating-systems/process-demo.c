#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <sys/types.h>
#include <sys/wait.h>

int main(void) {
    pid_t child = fork();
    if (child < 0) {
        perror("fork");
        return EXIT_FAILURE;
    }
    if (child == 0) {
        puts("Child: calculation 12 + 8 = 20");
        fflush(stdout);
        _exit(7);
    }

    int status;
    if (waitpid(child, &status, 0) < 0) {
        perror("waitpid");
        return EXIT_FAILURE;
    }
    if (WIFEXITED(status)) {
        printf("Parent: child exit code = %d\n", WEXITSTATUS(status));
    }
    return EXIT_SUCCESS;
}

#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

int main(void) {
    long page = sysconf(_SC_PAGESIZE);
    if (page <= 0) return EXIT_FAILURE;
    size_t count = 4 * (size_t)page;
    unsigned char *buffer = calloc(count, 1);
    if (!buffer) return EXIT_FAILURE;
    for (size_t i = 0; i < count; i += (size_t)page) {
        buffer[i] = 1;
    }
    printf("Page size: %ld bytes\n", page);
    printf("Allocated %zu bytes, touched 4 pages\n", count);
    free(buffer);
    puts("Memory released");
    return EXIT_SUCCESS;
}

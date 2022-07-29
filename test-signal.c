#include "libmini.h"

void handler(int s) {
    char msg[] = "hello\n";
    write(1, msg, strlen(msg));
    exit(0);
}

int main() {
    signal(SIGUSR1, handler);
    while(1);
    return 0;
}

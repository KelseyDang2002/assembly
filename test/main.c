#include <stdio.h>

extern double assembly();

int main(int argc, char* argv[]) {
  printf("\nmain: Hello\n");
  double call = assembly();
  // printf("%s\n", call);
  return 0;
}

#include <iostream>

#include <test.h>

int main(int argc, char **argv) {
  Test test;
  std::cout << test.isItReally() << std::endl;
  std::cout << test.testTheClass() << std::endl;
  std::cout << test.isItReally() << std::endl;
  return 1;
}

#include <iostream>

#include <class-a.h>
#include <class-b.h>

int main(int argc, char **argv) {
  ClassA class_a;
  ClassB class_b;

  class_a.printCounter();
  std::cout << "Class A counter now at " << class_a.getCounter() << std::endl;
  std::cout << "Class B activity is: " << class_b.isClassActive() << std::endl;
  std::cout << "ExampleApp was copiled with C++ version " << __cplusplus << std::endl;
  return 1;
}

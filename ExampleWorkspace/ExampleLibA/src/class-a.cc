#include "class-a.h"

unsigned int ClassA::counter_ = 0;

ClassA::ClassA() {
  std::cout << "Class A initialized, counter is: " << ++counter_ << '\n';
}

void ClassA::printCounter() {
  std::cout << "Counter of Class A is: " << ++counter_ << '\n';
  return;
}

#include "class-b.h"

#include <iostream>
#include <unordered_set>

#include <class-c.h>

ClassB::ClassB() {
  is_true_ = true;
  ClassC class_c;
  std::cout << "Class B initialized, activation is: " << is_true_ << '\n';
}

bool ClassB::isClassActive() {
  std::cout << "Class B currently active? " << is_true_ << '\n';
  is_true_ = !is_true_;
  return is_true_;
}

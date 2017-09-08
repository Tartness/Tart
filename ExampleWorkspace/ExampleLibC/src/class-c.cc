#include "class-c.h"

#include <iostream>
#include <unordered_set>

ClassC::ClassC() {
  is_true_ = true;
  std::cout << "Class C initialized, activation is: " << is_true_ << '\n';
}

bool ClassC::isClassCActive() {
  std::cout << "Class C currently active? " << is_true_ << '\n';
  is_true_ = !is_true_;
  return is_true_;
}

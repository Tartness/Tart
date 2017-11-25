#include "class-c.h"

#include <iostream>
#include <unordered_set>

ClassC::ClassC() {
  is_true_ = true;
  std::cout << "Class C initialized, activation is: " << is_true_ << '\n';
  std::cout << "ExampleLibC was copiled with C++ version " << __cplusplus << std::endl;
  std::cout << "ExampleLibC TART_TARGET_OS is :" << TART_TARGET_OS << std::endl;
  std::cout << "ExampleLibC TART_TARGET_ARCH is :" << TART_TARGET_ARCH << std::endl;
}

bool ClassC::isClassCActive() {
  std::cout << "Class C currently active? " << is_true_ << '\n';
  is_true_ = !is_true_;
  return is_true_;
}

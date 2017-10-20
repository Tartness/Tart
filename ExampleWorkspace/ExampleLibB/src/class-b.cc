#include "class-b.h"

#include <iostream>
#include <unordered_set>

#include <class-c.h>
#include <class-d.h>

ClassB::ClassB() {
  is_true_ = true;
  ClassC class_c;
  ClassD class_d;
  std::cout << "Class B initialized, activation is: " << is_true_ << std::endl;
  #ifdef TART_TEST_DEFINITION
    std::cout << "Class B was compiled with defined TART_TEST_DEFINITION";
  #else
    std::cout << "Class B was compiled without defined TART_TEST_DEFINITION";
  #endif
}

bool ClassB::isClassActive() {
  std::cout << "Class B currently active? " << is_true_ << '\n';
  is_true_ = !is_true_;
  return is_true_;
}

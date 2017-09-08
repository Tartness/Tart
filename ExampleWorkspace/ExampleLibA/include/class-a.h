// copyright 2017 Tartness

#ifndef CLASS_A_H_
#define CLASS_A_H_

#include <iostream>
#include <vector>

class ClassA {
 public:
  ClassA();
  unsigned int getCounter() {
    return ++counter_;
  }
  void printCounter();
 private:
  static unsigned int counter_;
};

#endif  // CLASS_A_H_

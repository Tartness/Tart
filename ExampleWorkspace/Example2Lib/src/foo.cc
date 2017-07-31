#include "foo.h"

#include <iostream>
#include <unordered_set>

#include <bar.h>

bool isItFoo(){
  std::cout << "Foo it is!" << std::endl;
  std::unordered_set<int> test_set = {1, 2, 3, 4};
  return isItBar();
}

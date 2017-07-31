#include "foo.h"

#include <iostream>

#include <bar.h>

bool isItFoo(){
  std::cout << "Foo it is!" << std::endl;
  return isItBar();
}

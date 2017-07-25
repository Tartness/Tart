#include <iostream>
#include <vector>

class Test {
 public:
  bool testTheClass() {
    std::cout << "/* message */" << '\n';
    is_true_ = !is_true_;
    return is_true_;
  }
  bool isItReally();
 private:
  bool is_true_;
}

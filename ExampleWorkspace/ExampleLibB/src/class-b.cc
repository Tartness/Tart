#include "class-b.h"

#include <iostream>
#include <unordered_set>

// Inlcude OpenGL
#ifdef __APPLE__
  #include "TargetConditionals.h"
  #if TARGET_IPHONE_SIMULATOR
    #include <OpenGLES/ES3/gl.h>
    #include <OpenGLES/ES3/glext.h>
  #elif TARGET_OS_IPHONE
    #include <OpenGLES/ES3/gl.h>
    #include <OpenGLES/ES3/glext.h>
  #elif TARGET_OS_MAC
    #include <OpenGL/gl3.h>
    #include <OpenGL/gl3ext.h>
  #else
    #error "Unknown Apple platform"
  #endif
#elif ANDROID
  #include <GLES3/gl31.h>
  #include <GLES3/gl3ext.h>
  #include <GLES3/gl3platform.h>
#else 
  #include <glad/glad.h>
#endif

#include <class-c.h>
#include <class-d.h>

ClassB::ClassB() {
  is_true_ = true;
  ClassC class_c;
  ClassD class_d;
  std::cout << "Class B initialized, activation is: " << is_true_ << std::endl;
  #ifdef TART_TEST_DEFINITION
    std::cout << "Class B was compiled with defined TART_TEST_DEFINITION" << std::endl;
  #else
    std::cout << "Class B was compiled without defined TART_TEST_DEFINITION" << std::endl;
  #endif  
  std::cout << "Pi is " << MY_CONSTANT << std::endl;
  std::cout << "ExampleLibB was copiled with C++ version " << __cplusplus << std::endl;
}

bool ClassB::isClassActive() {
  std::cout << "Class B currently active? " << is_true_ << '\n';
  is_true_ = !is_true_;
  return is_true_;
}

#include <iostream>

#include <OpenGL/gl.h>
#include <OpenGL/glu.h>
#include <GLUT/glut.h>

int main(int argc, char **argv) {
  
  glutInit(&argc, argv);
  glutCreateWindow("GLUT");
  
//  glewInit();
  printf("OpenGL version supported by this platform (%s): \n", glGetString(GL_VERSION));
  return 1;
}

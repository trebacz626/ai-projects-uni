#include <iostream>
#include <string>
#include <time.h>

#include "program.h"


int main(){
  srand (time(NULL));
  Program* program = new Program();
  program->run();
  delete program;
}
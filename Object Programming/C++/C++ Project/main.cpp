#include <iostream>
#include <string>
#include <time.h>

#include "program.h"


int main(){
  srand (time(NULL));
  Program* program = new Program();
  program->run();
  std::cout<<"Program finished"<<std::endl;
  delete program;
}
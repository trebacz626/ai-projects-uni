#ifndef __PROGRAM_H__
#define __PROGRAM_H__

#include "cabinet.h"

class Program {
  Cabinet<Drug> cabinet;
  float pDisease;
  float pRecovery;
  void pandemic();

public:
  void run();
};
#endif // __PROGRAM_H__
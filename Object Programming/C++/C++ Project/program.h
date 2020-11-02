#include "cabinet.h"

class Program {
  Cabinet<Drug> cabinet;
  float pDisease;
  float pRecovery;
  void pandemic();

public:
  // void setPDisease(float pDisease) { this->pDisease = pDisease; };
  // void setPRecovery(float pRecovery) { this->pRecovery = pRecovery; };
  void run();
};
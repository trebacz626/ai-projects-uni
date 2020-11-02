#include "pilldrug.h"
#include <string>
std::string PillDrug::toString() {
  return DosedDrug::toString() +
         "Total number of pills: " + std::to_string(this->totalNumberOfPills) +
         "\n";
}

std::string PillDrug::getDoseUnit() { return "pills"; }

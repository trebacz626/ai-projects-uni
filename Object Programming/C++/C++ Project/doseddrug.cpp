#include "doseddrug.h"
#include <string>
std::string DosedDrug::toString() {
  return Drug::toString() + "My standard dose is: " + this->getStandardDose()+"\n";
}

std::string DosedDrug::getStandardDose() {
  return std::to_string(this->standardDose) + this->getDoseUnit();
}

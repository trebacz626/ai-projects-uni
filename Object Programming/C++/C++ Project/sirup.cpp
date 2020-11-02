#include "sirup.h"
#include <string>

std::string Sirup::toString() {
  return LiquidDrug::toString() +
         "Type of caugh: " + CaughTypeString[this->caughType] +
         "\n";
}

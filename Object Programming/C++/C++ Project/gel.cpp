#include "gel.h"
#include <string>

std::string Gel::toString() {
  return LiquidDrug::toString() +
         "Viscosity " + std::to_string(this->viscosity) +
         "\n";
}

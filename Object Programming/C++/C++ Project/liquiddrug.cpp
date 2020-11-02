#include "liquiddrug.h"
#include <string>

std::string LiquidDrug::toString() {
  return DosedDrug::toString() + "Total volume: " + std::to_string(this->totalVolume) + "\n";
}

std::string LiquidDrug::getDoseUnit() { return "ml";}

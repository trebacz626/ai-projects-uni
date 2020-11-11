#include "bandaid.h"
#include <string>

std::string BandAid::toString() {
  return Drug::toString() + this->getAdditionalInformation() +
         "Is cutted: " + ((this->isCutted) ? "Yes" : "No") + "\n";
}

std::string BandAid::getAdditionalInformation() { return "I am bandaid!!!!\n"; }

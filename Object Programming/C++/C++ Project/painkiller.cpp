#include "painkiller.h"
#include <string>

std::string PainKiller::toString() {
  return PillDrug::toString() +
         "Amount of ibuprofen: " + std::to_string(this->amountOfIbuprofen) +
         "\n";
}

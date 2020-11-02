#include <string>
#include "drug.h"

std::string Drug::toString() {
  return "My name is " + this->name + "an my price is " +
         std::to_string(this->price) + ".\n";
}

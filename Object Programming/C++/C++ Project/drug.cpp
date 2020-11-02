#include <string>
#include "drug.h"

std::string Drug::toString() {
  return "My name is " + this->name + " and my price is " +
         std::to_string(this->price) + ".\n";
}

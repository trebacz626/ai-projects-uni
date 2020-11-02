#include "cvitaminpill.h"
#include <string>

std::string CVitaminPill::toString() {
  return PillDrug::toString() + "Does Gozdzikowa Recommend: " +
         (this->doesGozdzikowaRecommend ? "yes" : "no") + "\n";
}

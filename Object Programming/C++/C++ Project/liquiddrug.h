#ifndef __PILLDRUG_H__
#define __PILLDRUG_H__

#include "doseddrug.h"
#include <string>

class LiquidDrug : public DosedDrug {
  float totalVolume;

public:
  LiquidDrug(std::string name, float price, float standardDose, float totalVolume)
      : DosedDrug(name, price, standardDose), totalVolume(totalVolume) {}
  virtual std::string toString();
  std::string getDoseUnit();
};
#endif // __PILLDRUG_H__
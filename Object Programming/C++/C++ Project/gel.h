#ifndef __CVITAMINPILL_H__
#define __CVITAMINPILL_H__


#include "liquiddrug.h"
#include <string>

class Gel : public LiquidDrug {
  float viscosity;

public:
  Gel(std::string name, float price, float standardDose, float totalVolume, float viscosity)
      : LiquidDrug(name, price, standardDose, totalVolume), viscosity(viscosity) {}
  virtual std::string toString();
  virtual std::string getAdditionalInformation(){return "";};
};
#endif // __CVITAMINPILL_H__
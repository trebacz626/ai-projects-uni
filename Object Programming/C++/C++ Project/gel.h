#ifndef __GEL_H__
#define __GEL_H__


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

#endif // __GEL_H__
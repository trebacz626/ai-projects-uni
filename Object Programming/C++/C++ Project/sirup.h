#ifndef __SIRUP_H__
#define __SIRUP_H__

#include "liquiddrug.h"
#include "caughtype.h"
#include <string>

class Sirup : public LiquidDrug {
  CaughType caughType;

public:
  Sirup(std::string name, float price, float standardDose, float totalVolume, CaughType caughType)
      : LiquidDrug(name, price, standardDose, totalVolume), caughType(caughType) {}
  virtual std::string toString();
  virtual std::string getAdditionalInformation(){return "";};
};
#endif // __SIRUP_H__
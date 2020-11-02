#ifndef __DOSEDDRUG_H__
#define __DOSEDDRUG_H__

#include "drug.h"
#include <string>

class DosedDrug : public Drug {
  float standardDose;

public:
  DosedDrug(std::string name, float price, float standardDose)
      : Drug(name, price), standardDose(standardDose) {}
  virtual std::string toString();
  std::string getStandardDose();
  virtual std::string getDoseUnit()=0;
};
#endif // __DOSEDDRUG_H__
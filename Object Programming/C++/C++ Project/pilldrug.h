#ifndef __PILLDRUG_H__
#define __PILLDRUG_H__

#include "doseddrug.h"
#include <string>

class PillDrug : public DosedDrug {
  int totalNumberOfPills;

public:
  PillDrug(std::string name, float price, float standardDose, int totalNumberOfPills)
      : DosedDrug(name, price, standardDose), totalNumberOfPills(totalNumberOfPills) {}
  virtual std::string toString();
  std::string getDoseUnit();
};
#endif // __PILLDRUG_H__
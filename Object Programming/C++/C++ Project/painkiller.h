#ifndef __CVITAMINPILL_H__
#define __CVITAMINPILL_H__


#include "pilldrug.h"
#include <string>

class PainKiller : public PillDrug {
  float amountOfIbuprofen;

public:
  PainKiller(std::string name, float price, float standardDose, int totalNumberOfPills, float amountOfIbuprofen)
      : PillDrug(name, price, standardDose, totalNumberOfPills), amountOfIbuprofen(amountOfIbuprofen) {}
  virtual std::string toString();
  virtual std::string getAdditionalInformation(){return "";};
};
#endif // __CVITAMINPILL_H__
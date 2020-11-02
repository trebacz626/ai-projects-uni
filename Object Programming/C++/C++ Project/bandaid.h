#ifndef __BANDAID_H__
#define __BANDAID_H__

#include "drug.h"
#include <string>

class BandAid : public Drug {
  bool isCutted;

public:
  BandAid(std::string name, float price, bool isCutted)
      : Drug(name, price), isCutted(isCutted) {}
  virtual std::string toString();
  std::string getAdditionalInformation();
};
#endif // __BANDAID_H__
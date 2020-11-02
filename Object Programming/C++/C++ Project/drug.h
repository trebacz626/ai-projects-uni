#ifndef __DRUG_H__
#define __DRUG_H__
#include <string>

class Drug {
  std::string name;
  float price;
public:
    Drug(std::string name, float price): name(name),price(price){}
    virtual std::string toString();
    virtual std::string getAdditionalInformation()=0;//Dummy method. Project requirement was for this class to be abstract.
};
#endif // __DRUG_H__
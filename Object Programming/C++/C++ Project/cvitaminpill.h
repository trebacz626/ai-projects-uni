#ifndef __CVITAMINPILL_H__
#define __CVITAMINPILL_H__


#include "pilldrug.h"
#include <string>

class CVitaminPill : public PillDrug {
  bool doesGozdzikowaRecommend;

public:
  CVitaminPill(std::string name, float price, float standardDose, int totalNumberOfPills, bool doesGozdzikowaRecommend)
      : PillDrug(name, price, standardDose, totalNumberOfPills), doesGozdzikowaRecommend(doesGozdzikowaRecommend) {}
  virtual std::string toString();
  virtual std::string getAdditionalInformation(){return "";};
};
#endif // __CVITAMINPILL_H__
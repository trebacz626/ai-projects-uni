#include <iostream>
#include <string>
using namespace std;

class Drug {
  string name;
  float price;
public:
    Drug(string name, float price): name(name),price(price){}
    virtual string toString(){} 
};

class PrescriptedDrug{
  int maximumAmount;
};

class RefundedDrug{
  float refundPercentage;
};

class DosedDrug{
  float standardDose;
};

class LiquidDrug{
  float volume;
};

class PillDrug{
  int numberOfPills;
};



int main(){
  return 0;
}
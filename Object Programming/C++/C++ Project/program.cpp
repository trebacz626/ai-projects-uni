#include <iostream>
#include <string>

#include "bandaid.h"
#include "cvitaminpill.h"
#include "gel.h"
#include "painkiller.h"
#include "program.h"
#include "sirup.h"
#include "utils.cpp"

void Program::run() {
  int initialNumberOfItems;
  std::cin >> initialNumberOfItems;
  std::cin >> this->pDisease;
  std::cin >> this->pRecovery;
  // this->pDisease = 0.9;
  // this->pRecovery = 0.2;
  const std::string randomNames[] = {"A", "B", "C", "D", "E", "F", "G",
                                     "H", "I", "J", "K", "L", "M", "N",
                                     "O", "P", "Q", "R", "S"};
  for (int i = 0; i < initialNumberOfItems; i++) {
    Drug *drug;
    std::string name = randomNames[rand() % 19];
    float price = randomFloat(1, 100);
    int drugType = rand() % 5;
    switch (drugType) {
    case 0:
      drug = new Sirup(name, price, randomFloat(1, 10), randomFloat(100, 1000),
                       rand() % 2 == 1 ? Dry : Wet);
      break;
    case 1:
      drug = new Gel(name, price, randomFloat(1, 10), randomFloat(50, 500),
                     randomFloat(0, 1));
      break;
    case 2:
      drug = new PainKiller(name, price, randomFloat(1, 10), rand() % 100 + 5,
                            randomFloat(0, 100));
      break;
    case 3:
      drug = new CVitaminPill(name, price, randomFloat(1, 10), rand() % 100 + 5,
                              rand() % 2 == 1);
      break;
    case 4:
      drug = new BandAid(name, price, rand() % 2 == 1);
      break;
    }
    cabinet+=drug;
  }
  while (cabinet.getNumberOfItems() > 0) {
    std::cout << "==============================================" << std::endl;
    std::cout << cabinet.printAllItems() << std::endl;
    std::cout << "==============================================" << std::endl;
    this->pandemic();
  }
}

void Program::pandemic() {
  float r = static_cast<float>(rand()) / static_cast<float>(RAND_MAX);
  if (r <= this->pDisease) {
    Drug *drug = cabinet-=rand() % cabinet.getNumberOfItems();
    // std::cout<<drug->toString();
    float r2 = static_cast<float>(rand()) / static_cast<float>(RAND_MAX);
    if (r2 <= this->pRecovery) {
      cabinet+=drug;
    } else {
      delete drug;
    }
  }
}

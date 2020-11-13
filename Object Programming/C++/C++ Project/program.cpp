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
  std::cout << "What is the number of drugs?" << std::endl;
  std::cin >> initialNumberOfItems;
  std::cout << "What is pDisease?" << std::endl;
  std::cin >> this->pDisease;
  std::cout << "What is pRecovery?" << std::endl;
  std::cin >> this->pRecovery;
  const std::string randomNames[] = {"Appape", "Bitunoscorbiin", "Cetylin", "Derilur", "Enitum", "Feganum", "Gilotinum",
                                     "Haerbapolis", "Indekto", "Jelico", "Kolerino", "Lestittto", "Martwito", "Nowiitto",
                                     "Osper magus", "Piernikum", "Quritin", "Relodin", "Spacjyn"};
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
      drug = new PainKiller(name, price, rand() % 10 +1, rand() % 100 + 5,
                            randomFloat(0, 100));
      break;
    case 3:
      drug = new CVitaminPill(name, price, rand() % 10 +1, rand() % 100 + 5,
                              rand() % 2 == 1);
      break;
    case 4:
      drug = new BandAid(name, price, rand() % 2 == 1);
      break;
    }
    cabinet += drug;
  }
  while (cabinet.getNumberOfItems() > 0) {
    std::cout << "==============================================" << std::endl;
    std::cout << cabinet.printAllItems() << std::endl;
    std::cout << "==============================================" << std::endl;
    this->pandemic();
  }
}

void Program::pandemic() {

  for (int i = cabinet.getNumberOfItems()-1; i >= 0; i--) {
    float r = randomFloat(0, 1);
    if (r <= this->pDisease) {
      Drug *drug = cabinet.getFirstItem();
      cabinet -= drug;
      float r2 = randomFloat(0, 1);
      if (r2 <= this->pRecovery) {
        cabinet += drug;
      } else {
        delete drug;
      }
    }
  }
}

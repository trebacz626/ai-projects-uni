#include <iostream>
#include <string>

#include "program.h"
#include "sirup.h"

void Program::run() {
  int initialNumberOfItems;
  std::cin >> initialNumberOfItems;
  std::cin >> this->pDisease;
  std::cin >> this->pRecovery;

  for (int i = 0; i < initialNumberOfItems; i++) {
    Sirup *sirup = new Sirup("sirup", 12.5, i, 400, Dry);
    cabinet.addItem(sirup);
  }
  while (cabinet.getNumberOfItems() > 0) {
    this->pandemic();
    std::cout << cabinet.getNumberOfItems() << std::endl;
  }
}

void Program::pandemic() {
  float r = static_cast<float>(rand()) / static_cast<float>(RAND_MAX);
  if (r <= this->pDisease) {
    Drug *drug = cabinet.getAndRemoveItem(rand() % cabinet.getNumberOfItems());
    float r2 = static_cast<float>(rand()) / static_cast<float>(RAND_MAX);
    if (r2 <= this->pRecovery) {
      cabinet.addItem(drug);
    } else {
      delete drug;
    }
  }
}

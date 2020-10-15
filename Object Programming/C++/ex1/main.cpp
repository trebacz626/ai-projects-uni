#include <iostream>
#include <stdlib.h>
#include <string>
#include <time.h>
using namespace std;

class Human {
  string firstName;
  string lastName;

public:
  Human(const string firstName, const string lastName) {
    this->firstName = firstName;
    this->lastName = lastName;
  };
  virtual void drink() = 0;
  virtual void introduceYourself() {
    cout << "Hello I am: " << firstName << " " << lastName << endl;
  }
};

class Student : public Human {
  int studentID;

public:
  Student(string firstName, string lastName, int studentID)
      : Human(firstName, lastName) {
    this->studentID = studentID;
  };
  void drink() { cout << studentID << " drinks: gul gul gul gul" << endl; }
  void introduceYourself() {
    cout << "My ID is: " << studentID << " and I am happy" << endl;
  }
};

class Employee : public Human {
public:
  Employee(string firstName, string lastName) : Human(firstName, lastName) {}
  void drink() { cout << "guuuuuuuuuuuuul.... achhhh" << endl; }
};

const string names[] = {"John", "Jane", "William", "George", "Bill", "Paul"};
const string surnames[] = {"Smith", "Trump", "Clinton", "Kenedy", "Bush"};


int main() {
  int n;
  cout << "How many drinking people are here: " << endl;
  cin >> n;
  Human **population = new (nothrow) Human *[n];
  srand(time(NULL));

  for (int i = 0; i < n; i++) {
    if (rand() % 10 > 7) {
      population[i] = new (nothrow) Employee(names[rand() %6], surnames[rand()%5]);
    } else {
      population[i] = new (nothrow) Student(names[rand() %6], surnames[rand()%5], rand()%10000);
    }
  }

  for (int i = 0; i < n; i++) {
    population[i]->introduceYourself();
    population[i]->drink();
  }

  for (int i = 0; i < n; i++) {
    delete population[i];
  }
  delete[] population;
}
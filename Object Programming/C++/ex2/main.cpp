#include <cstdlib>
#include <iostream>
#include <string>

using namespace std;

int gcd(int a, int b) {
  int c;
  while (b != 0) {
    c = b;
    b = a % b;
    a = c;
  };
  return a;
}

int convertToNumber(string input) {
  size_t converted_chars =0;
  int number = stoi(input, &converted_chars);
  if (number < 0) {
    throw out_of_range("Number is smaller than 0!!");
  }
  if(converted_chars != input.length()) {
      throw invalid_argument("Invalid characters in input");
  }
  return number;
}

int main() {
cout<<"My name is GCD"<<endl;
  while (true) {
    string inA, inB;
    cout << "Podaj a" << endl;
    cin >> inA;
    if(cin.fail()){
        cout<<"Cin failed"<<endl;
        cin.clear();
        continue;
    }
    cout << "Podaj b" << endl;
    cin >> inB;
    if(cin.fail()){
        cout<<"Cin failed"<<endl;
        cin.clear();
        continue;
    }
    try {
      int a = convertToNumber(inA);
      int b = convertToNumber(inB);
      cout << "GCD: " << gcd(a, b) << endl;
    } catch (invalid_argument &e) {
      cout << "Invalid argument exception: " << e.what() << endl;
    } catch (out_of_range &e) {
        cout << "Out of range exception: " << e.what() << endl;
    } catch (...) {
      cout << "Unknown exception occurred" << endl;
    }
  };
}
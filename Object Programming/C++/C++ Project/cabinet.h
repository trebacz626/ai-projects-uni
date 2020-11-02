#ifndef __CABINET_H__
#define __CABINET_H__

#include <vector>
#include "drug.h"

template <class T>
class Cabinet {
  std::vector<T*> items;
public:
    ~Cabinet();
    std::string printAllItems();
    int getNumberOfItems();
    void operator+=(T* item);
    T* operator-=(int index);
};




#endif // __CABINET_H__
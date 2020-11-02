#include "cabinet.h"
#include <string>

template <class T> std::string Cabinet<T>::printAllItems() {
  std::string text = "";
  for (T *item : items) {
    text += item->toString()+"\n";
  }
  return text;
}

template <class T> int Cabinet<T>::getNumberOfItems() {
  return items.size();
}

template<class T>
T* Cabinet<T>::operator-=(int index) 
{
  Drug* drug = items[index];
  items.erase(items.begin()+index);
  return drug;
}

template<class T>
void Cabinet<T>::operator+=(T* item) 
{
  items.push_back(item);
}

template<class T>
Cabinet<T>::~Cabinet() 
{
  for (T *item : items) {
    delete item;
  }
}


template class Cabinet<Drug>;
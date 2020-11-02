#include "cabinet.h"
#include <string>

template <class T> std::string Cabinet<T>::printAllItems() {
  std::string text = "";
  for (T *item : items) {
    text += item->toString();
  }
  return text;
}

template <class T> int Cabinet<T>::getNumberOfItems() {
  return items.size();
}

template <class T> void Cabinet<T>::addItem(T *item) {
  items.push_back(item);
}

template <class T> T *Cabinet<T>::getAndRemoveItem(int index) {
  Drug* drug = items[index];
  items.erase(items.begin()+index);
  return drug;
}

template class Cabinet<Drug>;

template<class T>
Cabinet<T>::~Cabinet() 
{
  for (T *item : items) {
    delete item;
  }
}

#include "cabinet.h"
#include <algorithm>
#include <string>

template <class T> std::string Cabinet<T>::printAllItems() {
  std::string text = "";
  for (T *item : items) {
    text += item->toString() + "\n";
  }
  return text;
}

template <class T> int Cabinet<T>::getNumberOfItems() { return items.size(); }

template <class T> T *Cabinet<T>::getFirstItem() { return items[0]; }

template <class T> void Cabinet<T>::operator-=(T *item) {
  auto it = std::find(items.begin(), items.end(), item);
  items.erase(it);
}

template <class T> void Cabinet<T>::operator+=(T *item) {
  items.push_back(item);
}

template <class T> Cabinet<T>::~Cabinet() {
  for (T *item : items) {
    delete item;
  }
}

template class Cabinet<Drug>;
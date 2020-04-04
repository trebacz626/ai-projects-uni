#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "sectionstore.h"
#include "parameters.h"


int main(int argc, char **argv) {
    if (argc != 4){
        printf("Wrong number of parameters\n");
        return 1;
    }
    Parameters* params = getParameters(argc,argv);
    SectionStore* store = createSectionStore();
    Section* section = addSection(store,params->filename);
    KeyValue* keyValue = addKeyValuePair(section,params->firstKey,params->firstValue);
    printf("%d\n",store->numberOfElements);
    printf("%s\n",section->name);
    printf("%s\n",keyValue->key);
    printf("%s\n",keyValue->value);

    printf("%s\n ","storeoro");
    deleteSectionStore(store);
    deleteParameters(params);
    return 0;

}
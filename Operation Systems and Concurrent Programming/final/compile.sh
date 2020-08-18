gcc start.c -o start -lpthread -lrt
gcc producer.c -o producer -lpthread -lrt
gcc consumer.c -o consumer -lpthread -lrt
gcc unlink.c -o unlink -lpthread -lrt
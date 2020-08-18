./unlink & ./start &
for i in {1..5}
do
    ./producer $i &
done

for i in {1..5}
do
    ./consumer &
done
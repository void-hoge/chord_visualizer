./converter/build/converter < $1 > out
processing-java --sketch=`pwd`/chord_visualizer/ --run `pwd`/out

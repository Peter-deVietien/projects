#!/bin/zsh
cp ../omicron/cases-hosps-icu-deaths-South\ Africa.png .
cp ../omicron/cases-hosps-deaths-shifted-United\ States.png .
cp ../omicron/cases-deaths-zoomed-out-World.png .


for i in *[asd].png;
  do convert $i -gravity south -background black -splice 0x2000 $i[1,-5]-border.png
done

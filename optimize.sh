#!/bin/bash
optimize() {
  jpegoptim *.jpg --strip-all --all-progressive --max=90
  jpegoptim *.jpeg --strip-all --all-progressive --max=90
  jpegoptim *.JPG --strip-all --all-progressive --max=90
  optipng *.png
  
  for i in *
  do
    if test -d $i
    then
      cd $i
      echo $i
      optimize
      cd ..
    fi
  done
  echo
}
optimize

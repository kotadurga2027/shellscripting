#!/bin/bash

movies=("court" "hit3" "hit2" "hit")

echo "First movie : ${movies[0]}"
echo "second movie : $movies[2]}"
echo "first 3 movies : ${movies[@]:0:4}"
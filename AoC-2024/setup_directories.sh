#!/bin/bash

#//  setup_directories.sh
#//  AoC-2024
#//
#//  Created by Lukas Waschuk on 11/25/24.
#//

DATA_DIR="data"
PROBLEMS_DIR="problems"

mkdir -p "$DATA_DIR"

for i in {1..25}; do
  DAY_DIR="$DATA_DIR/day$i"
  mkdir -p "$DAY_DIR"

  touch "$DAY_DIR/d${i}.txt" "$DAY_DIR/d${i}_e1.txt" "$DAY_DIR/d${i}_e2.txt"
done

mkdir -p "$PROBLEMS_DIR"

for i in {1..25}; do
  touch "$PROBLEMS_DIR/Day_${i}.swift"
done

echo "Setup complete!"

#!/bin/bash
for i in *; do	
       echo "Dir: $i"	
	cd "$i/" && pwd && make build && cd ..
done



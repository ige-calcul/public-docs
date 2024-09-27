#!/bin/bash

mpirun -np 3 ./atmosphere.exe : -np 5 ./ocean.exe

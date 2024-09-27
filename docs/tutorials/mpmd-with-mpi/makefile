all: ocean.exe atmosphere.exe

%.exe: %.f90
	mpif90 $< -o $@

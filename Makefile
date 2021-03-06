# ============================================================================
# Name        : Makefile
# Author      : Raymond Rusk, Roy Walters
# Version     :
# Copyright   : Copyright (C) 2012 under GNU General Public License v2
# Description : Makefile for TQGridGen  (needs a lot of work yet)
# ============================================================================

.PHONY: all clean

# Change these lines if you are using different
# Fortran or C compilers and compiler options.
# gfortran and gcc(GNU) on linux
FC = gfortran
F_FLAGS = -Wall -Wtabs -fdefault-real-8 # -O2 -g
FDBG_FLAGS =  -fdefault-real-8 -Wall -fcheck=bounds -fbacktrace
CC = gcc
C_FLAGS = -Wall
CDBG_FLAGS = -Wall
LIBS = -lXm -lXt -lX11


TQGG:
	$(FC) $(F_FLAGS) -c \
		src/dataio/MainArrays.f90 \
		src/gridgen/*.f90 \
		src/plotsubs/*.f90 \
		src/PigInterface/*.f90 \
		src/gridedit/*.f src/gridedit/*.f90 \
		src/dataio/*.f src/dataio/*.f90 \
		src/netcdf/nullReadWriteCDF.f90 \
		src/XMotif/*.f90
	$(CC) $(C_FLAGS) -c src/XMotif/f90_c.h \
		src/XMotif/XmMain.h src/XMotif/XmMain.c \
		src/XMotif/XmDrawdbl.c src/XMotif/XmDialogs.c
	mkdir -p ./bin
	$(FC) *.o -o bin/TQGG $(LIBS)

TQGGdbg:
	$(FC) $(FDBG_FLAGS) -c \
		src/dataio/MainArrays.f90 \
		src/gridgen/*.f90 \
		src/plotsubs/*.f90 \
		src/PigInterface/*.f90 \
		src/gridedit/*.f src/gridedit/*.f90 \
		src/dataio/*.f src/dataio/*.f90 \
		src/netcdf/nullReadWriteCDF.f90 \
		src/XMotif/*.f90
	$(CC) $(CDBG_FLAGS) -c src/XMotif/f90_c.h \
		src/XMotif/XmMain.h src/XMotif/XmMain.c \
		src/XMotif/XmDrawdbl.c src/XMotif/XmDialogs.c
	mkdir -p ./bin
	$(FC) *.o -o bin/TQGGdbg $(LIBS)

TQGGnc:
	$(FC) $(F_FLAGS) -c -I/usr/local/include \
		src/dataio/MainArrays.f90 \
		src/gridgen/*.f90 \
		src/plotsubs/*.f90 \
		src/PigInterface/*.f90 \
		src/gridedit/*.f src/gridedit/*.f90 \
		src/dataio/*.f src/dataio/*.f90 \
		src/netcdf/UGrid_io_netCDF.f90 \
		src/netcdf/ReadWriteCDF.f90 \
		src/XMotif/*.f90
	$(CC) $(C_FLAGS) -c src/XMotif/f90_c.h \
		src/XMotif/XmMain.h src/XMotif/XmMain.c \
		src/XMotif/XmDrawdbl.c src/XMotif/XmDialogs.c
	mkdir -p ./bin
	$(FC) *.o -o bin/TQGGnc -lnetcdff -lnetcdf $(LIBS)

TQGGncdbg:
	$(FC) $(FDBG_FLAGS) -c -I/usr/local/include \
		src/dataio/MainArrays.f90 \
		src/gridgen/*.f90 \
		src/plotsubs/*.f90 \
		src/PigInterface/*.f90 \
		src/gridedit/*.f src/gridedit/*.f90 \
		src/dataio/*.f src/dataio/*.f90 \
		src/netcdf/UGrid_io_netCDF.f90 \
		src/netcdf/ReadWriteCDF.f90 \
		src/XMotif/*.f90
	$(CC) $(CDBG_FLAGS) -c src/XMotif/f90_c.h \
		src/XMotif/XmMain.h src/XMotif/XmMain.c \
		src/XMotif/XmDrawdbl.c src/XMotif/XmDialogs.c
	mkdir -p ./bin
	$(FC) *.o -o bin/TQGGncdbg -lnetcdff -lnetcdf $(LIBS)

clean:
	rm *.o *.mod

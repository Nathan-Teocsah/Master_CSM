PROGRAM=$1
NPROC=$2
OPTION=$3
if [ ! $PROGRAM ]; then
    echo please enter name of program
    exit
fi
if [ ! -f $PROGRAM.cpp ]; then
    echo $PROGRAM.cpp does not exist
    echo please enter valid name of program
    exit
fi
if [ ! $NPROC ]; then
    echo please enter number of processors after name of program
    exit
fi
if [[ ! -f $PROGRAM.exe || $PROGRAM.cpp -nt $PROGRAM.exe ]]; then
    mpic++ -o $PROGRAM.exe $PROGRAM.cpp
else
   echo $PROGRAM.exe exists, no compilation 
fi
if [[ -f $PROGRAM.exe && !( $PROGRAM.cpp -nt $PROGRAM.exe )]]; then
    mpirun -np $NPROC $PROGRAM.exe $OPTION
fi

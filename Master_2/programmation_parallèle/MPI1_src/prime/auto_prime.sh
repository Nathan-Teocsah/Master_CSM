rm -rf results_parallel.txt results_serial.txt 
PROGRAM_PARA=prime_parallel
PROGRAM_SERI=prime_serial

if [[ ! -f $PROGRAM_PARA.exe || $PROGRAM_PARA.cpp -nt $PROGRAM_PARA.exe ]]; then
    mpic++ -o $PROGRAM_PARA.exe $PROGRAM_PARA.cpp
fi

if [[ ! -f $PROGRAM_SERI.exe || $PROGRAM_SERI.cpp -nt $PROGRAM_SERI.exe ]]; then
    g++ -o $PROGRAM_SERI.exe $PROGRAM_SERI.cpp
fi

PAS=("20" "50" "100" "1000" "10000" "100000" "1000000" "10000000")
j=0
for num in "${PAS[@]}";do
    mpirun -np 4 $PROGRAM_PARA.exe $num
   $PROGRAM_SERI.exe $num
   echo ""
done
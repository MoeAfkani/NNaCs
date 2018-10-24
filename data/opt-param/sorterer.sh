#!/bin/bash

#*************************Last Modified*************************#
#################################################################
#*************************23 Jul 12:38 *************************#
#################################################################
echo "This is an output file for $0 excuted in $(date)" &> $0.dew
  
##########################Constants##############################
lineOftotEnergy=1
lineOfP=1
lineOfForce=1
#################################################################


  for ecutwfc in `LANG=en_US seq $2 $4 $3`
    do



    path=$(pwd)/$1/$ecutwfc
    shitness=$(cat $path/$ecutwfc.$1.scf.out | grep -c "NOT")
    if [ $shitness -eq 1 ]
    then
    # not conv
      echo "***  ****** $ecutwfc ***" | tee -a $0.dew
      echo shit | tee -a $0.dew
    else 
    # conv

      echo "***  ****** $ecutwfc ***" | tee -a $0.dew

      while tail -$lineOftotEnergy  $path/$ecutwfc.$1.scf.out | grep -cq "!    total energy"-eq 0 
      do
      	let "lineOftotEnergy+=1"
      done
      let "lineOftotEnergy+=200"   #20 line upper than 1st time that "Energy" has observed! 
      tail -$lineOftotEnergy $path/$ecutwfc.$1.scf.out | grep "!    total energy" | tee -a $0.dew
      eval "var$lineOftotEnergy=1";  # recovery to 1


    fi 
  done


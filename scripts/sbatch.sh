#!/bin/bash                                                                                         
                                                                                                    
new_str=$1                                                                                          
                                                                                                    
#new_dir=${new_str/tapisjob.sh/}                                                                    
# ccqstr=${new_str/tapisjob.sh/ccqjob.sh}                                                           
#outfile=${new_str/tapisjob.sh/tapis.out}                                                           
#errfile=${new_str/tapisjob.sh/tapis.err}                                                           
                                                                                                    
jobdir=$(pwd)                                                                                       
outfile="$jobdir/output/tapisjob.out"  
errfile="$jobdir/output/tapisjob.err"                                                               
if [[ "$1" =~ .*"tapisjob.sh".* ]]                                                                  
then                                                                                                
  #cp $1 $ccqstr                                                                                    
  #cd $new_dir                                                                                      
  sed '1 a #SBATCH -o $outfile' tapisjob.sh                                                         
  sed '1 a #SBATCH -e $errfile' tapisjob.sh                                                         
  output=$(ccqsub $new_str)                                                                         
  error=${output/ you can use this id to look up the job status using the ccqstat utility./}        
  err_arr=($error)                                                                                  
  echo "Submitted batch job ${err_arr[-1]}"                                                         
  #error1=${output/ignoring line with unknown SBATCH options #SBATCH --job-name img-classify-0.1/}  
  #error2=${error1/ignoring line with unknown SBATCH options #SBATCH --partition slurmCompute/}     
  #error3=${error2/ignoring line with unknown SBATCH options #SBATCH --time 10/}                    
  #slurmID1=${error3/The job has successfully been submitted to the scheduler slurm and is currently being processed. The job id is: /Submitted batch job }                                             
  #slurmID2=${slurmID1/ you can use this id to look up the job status using the ccqstat utility./}  
  #echo $slurmID2                                                                                   
else                                                                                                
  /opt/slurm/bin/sbatch $1                                                                          
fi                 

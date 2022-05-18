#!/bin/bash                                                                                         
                                                                                                    
new_str=$1                                                                                          
                                                                                                    
#new_dir=${new_str/tapisjob.sh/}                                                                    
# ccqstr=${new_str/tapisjob.sh/ccqjob.sh}                                                           
#outfile=${new_str/tapisjob.sh/tapis.out}                                                           
#errfile=${new_str/tapisjob.sh/tapis.err}                                                           
                                                                                                    
jobdir=$(pwd)                                                                                       
outfile="$jobdir/output/tapisjob.out"  

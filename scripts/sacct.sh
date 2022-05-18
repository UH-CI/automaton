#!/bin/bash                                                                                         
                                                                                                    
array=( $@ )                                                                                        
#qstr="squeue --noheader -O 'jobid,state,exit_code' -j34230056 2>/dev/null"                         
#sqar=($sqstr)                                                                                      
#jobstr=${sqar[-2]}                                                                                 
jobid=${array[-1]/-j/}                                                                              
#status="RUNNING"                                                                                   
                                                                                                    
ccqstat_output=`ccqstat -j $jobid`                                                                  
stringarray=($ccqstat_output)                                                                       
ccqstatus=${stringarray[-1]}                                                                        
                                                                                                    
status=$(echo $ccqstatus | tr '[:lower:]' '[:upper:]')                                              
case $status in                                                                                     
    PENDING|RUNNING|SUSPENDED|COMPLETING|COMPLETED) ;;                                              
    *)             status="PENDING";;                                                               
esac                                                                                                
                                                                                                    
echo "$jobid|$status|0:0|"                                                                          
echo "$jobid.batch|$status|0:0|"                                                                    
echo "$jobid.extern|$status|0:0|"     

#!/bin/bash
  
gcloud auth activate-service-account tapis-cc-service@tapis-cloudycluster.iam.gserviceaccount.com --key-file=secrets/tapis-cloudycluster-374e6462a472.json &&\
export GOOGLE_APPLICATION_CREDENTIALS=secrets/tapis-cloudycluster-374e6462a472.json

OUTPUT=($(python3 Create_Processing_Environment.py -et CloudyCluster -cf ConfigurationFiles/eric_sample.conf  -cc -ce |
	awk '
    	/The new DNS name/ {print $16}
    	/The new full Environment/ {print $7} 
	'))

DNS=${OUTPUT[0]}
ENV=${OUTPUT[1]}

echo $DNS
echo $ENV

ssh-keyscan login-$DNS >> ~/.ssh/known_hosts
sshpass -p "Password1" scp scripts/{sbatch.sh,squeue.sh,sacct.sh,.bashrc} testuser@login-$DNS:/mnt/orangefs/testuser/
#sshpass -p "Password1" ssh testuser@login-$DNS 'echo "Password1" | sudo -S mv /mnt/orangefs/testuser/.bashrc /etc/.bashrc'

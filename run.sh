#!/bin/bash

gcloud auth activate-service-account tapis-cc-service@tapis-cloudycluster.iam.gserviceaccount.com --key-file=secrets/tapis-cloudycluster-374e6462a472.json &&\
export GOOGLE_APPLICATION_CREDENTIALS=secrets/tapis-cloudycluster-374e6462a472.json

#python3 CreateEnvironmentTemplates.py -et CloudyCluster -cf ConfigurationFiles/eric_sample.conf -tn defaulttemplate
#python3 CreateEnvironmentTemplates.py -et CloudyCluster -lt
python3 Create_Processing_Environment.py -et CloudyCluster -cf ConfigurationFiles/eric_sample.conf  -cc -ce > out.txt
cat out.txt

awk '
    /The new DNS name/ {print $16}
    /The new full Environment/ {print $7} 
' out.txt > hellothisiseric.txt

# DELETE: python Create_Processing_Environment.py -et CloudyCluster -cf ConfigurationFiles/eric_sample.conf -dc -de -dn emeraldcoleyrail.cloudycluster.net -en lameric-6263
#python3 Create_Processing_Environment.py -et CloudyCluster -cf ConfigurationFiles/eric_sample.conf  -all


#python3 run.py

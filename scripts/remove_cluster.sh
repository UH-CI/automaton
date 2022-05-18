# $1 is the domain $2 is the environment
# python3 Create_Processing_Environment.py -et CloudyCluster -cf ConfigurationFiles/eric_sample.conf -dc -de -dn emeraldcoleyrail.cloudycluster.net -en lameric-6263
python3 Create_Processing_Environment.py -et CloudyCluster -cf ConfigurationFiles/eric_sample.conf -dc -de -dn $1 -en $2


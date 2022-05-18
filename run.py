from tapipy.tapis import Tapis
from tapipy.actors import get_context
import subprocess
# Create python Tapis client for user
t = Tapis(base_url= "https://tacc.tapis.io", username="lameric", password="L86psHuA*ytWHt")
# Call to Tokens API to get accest.get_tokens()
# *** Tapis v3: Call to Tokens API
t.get_tokens()

def init_system(hostname, envname, description = "Default description"):
    s2_system = {
        "id": envname,
        "description": description,
        "systemType": "LINUX",
        "host": hostname,
        "defaultAuthnMethod": "PASSWORD",
        "effectiveUserId": "testuser",
        "port": 22,
        "rootDir": "/",
        "canExec": True,
        "jobRuntimes": [ { "runtimeType": "SINGULARITY" } ],
        "jobWorkingDir": "/mnt/orangefs/testuser",
        "canRunBatch": True,
        "batchScheduler": "SLURM",
        "batchDefaultLogicalQueue": "slurmCompute",
        "batchLogicalQueues": [{
            "name": "slurmCompute",
            "hpcQueueName": "slurmCompute",
            "maxJobs": 50,
            "maxJobsPerUser": 10,
            "minNodeCount": 1,
            "maxNodeCount": 16,
            "minCoresPerNode": 1,
            "maxCoresPerNode": 68,
            "minMemoryMB": 1,
            "maxMemoryMB": 16384,
            "minMinutes": 1,
            "maxMinutes": 60
        }]
    }

    return s2_system

context = get_context()

# envname = "lameric_environment55"
# hostname = "login-pearldeerbowfin.cloudycluster.net"
# appname = "img-classify.lameric47"

if context['message'] == 'START':
    # Outside of this script, register the vm under my tapis account. Keep systemID and pass it in as part of message.
    # Pass in systemID context["systemID"], send output to system.
    output = f"{context['_abaco_execution_id']}.txt"
    with open(output, "w") as outfile:
        subprocess.run(["bash", "create_cluster"]), stdout=outfile)
                                                                                                    
    t.upload(source_file_path=output, system_id="tapis-cloud-vm", dest_file_path=output)
    # envname = context['envname']
    # hostname = context['hostname']
    # appname = context['appname']
    
    # parse output to get hostname and envname
    if context['decription']:
        description = context['description']
        s2_system = init_system(hostname = hostname, envname = envname, description = description)
    
    else: s2_system = init_system(hostname = hostname, envname = envname)

    # input_url = 'https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12231410/Labrador-Retriever-On-White-01.jpg'
    # input_url = context['url']
    # job = {
    #    "name": "test_job",
    #    "appId": appname, 
    #    "appVersion": "0.1",
    #    "execSystemID": envname,
    #    "parameterSet": {"appArgs": [{"name": "arg1", "arg": input_url}]        
    #    }
    #}

# IF context has some sort of flag or if there's no job specified, keep it up.


    jobname = context['job']
    jobname["execSystemID"] = envname
    t.systems.createSystem(**s2_system)
    # t.apps.createAppVersion(**app_def)
    t.systems.createUserCredential(systemId=envname,
                            userName='testuser',
                            password='Password1')
    job = t.jobs.submitJob(**jobname)
    print(job)


if context['message'] == 'TEARDOWN':
    # Pass in systemID context["systemID"], this system will be the cluster systemID, do a remove system call and also look at ID and HOST keys for envname and hostname.
    infofile = t.files.getContents(systemId="tapis-cloud-vm", path="automaton/automaton/infoFile").split(b"\n")
    dns = infofile[0].decode("utf-8")
    env = infofile[1].decode("utf-8")

    output = subprocess.run([
        "bash",
        "remove_cluster.sh",
        "dns",
        "env"
    ])
    


# pbs-workbench

Start a PBS job that runs idle to ssh into and work interactively. 

## Installation

Clone this repo into your home and run the install script. 

```bash
git clone https://github.com/eliocamp/pbs-workbench
bash pbs-workbench/install.sh
```

To uninstall, run `bash pbs-workbench/uninstall.sh`.

## Quick Start

0. **Create a profile** (first time only):

```bash
job profile
```

Follow the prompts to configure your job requirements (CPUs, memory, walltime, etc.)

1. **Start a job**:

```bash
job start
```

This will start the `default` profile. You can start a different one with `job start [profile]`.

2. **Monitor your job**:
 
The monitor starts automatically, showing job status and connection instructions. 
You can safely close the monitor with `Ctrl + C` and restart it with 

```bash
job monitor
```

3. **End your job**:

To end the job early use 

```bash
job end
```


## Connecting to the workbench

You can connect to the workbench using SSH using the commands shown in the monitor. 

Once the job starts, the monitor show something like this: 

```
==================================================
           PBS Workbench Monitor
==================================================

📍 Job ID: 148114816.gadi-pbs
💸 Usage: 256SU

🚀 Status: RUNNING
   Job is running on node: gadi-cpu-clx-0683.gadi.nci.org.au
   SSH command: 
     ssh -X gadi-cpu-clx-0683.gadi.nci.org.au
   SSH tunnel: 
     ssh -L 8080:127.0.0.1:8080 xxxxxx@gadi-cpu-clx-0683.gadi.nci.org.au
   Remote-ssh: 
     --remote ssh-remote+gadi-cpu-clx-0683.gadi.nci.org.au /home/xxx/xxxx/pbs-workbench
   Progress: 07:47:49 [                    ] 08:00:00 2%

==================================================
Updates every 10 seconds
```


### SSH

In a terminal **in your local machine**: 

Use the SSH command to ssh into the node: 

```bash
ssh -X gadi-cpu-clx-0683.gadi.nci.org.au
```

### VScode and similar IDEs

To use a IDE that suppeorts the Remote SSH extension, like VSCode or its forks, first you need to set up the proxy jump [as explained here](https://21centuryweather.github.io/21st-Century-Weather-Software-Wiki/gadi/vscode.html#configure-ssh-only-once). 

Then, use the remote-ssh command to use vscode or a similar editor that supports the Remote SSH extension. You need to add the command name before. 

For example, to use vscode, use 

```bash
code --remote ssh-remote+gadi-cpu-clx-0683.gadi.nci.org.au /home/xxx/xxxx/pbs-workbench
```

For Positron, use

```bash
positron --remote ssh-remote+gadi-cpu-clx-0683.gadi.nci.org.au /home/xxx/xxxx/pbs-workbench
```

This will open the editor, connect to the remote node, and open the current directory. 

### Jupyter notebook

To run a jupyter notebook first **in your local machine** run the SSH tunnel command:  


```bash
ssh -L 8080:127.0.0.1:8080 xxxxxx@gadi-cpu-clx-0683.gadi.nci.org.au
```

This will SSH into the node and now your terminal will be **in the remote**. 
Navigate to your project and start a jupyter notebook 

```bash
module load jupyterlab/3.4.3-py3.9
jupyter notebook --no-browser --port=8080
```

This will start the server up and end with this message

```
    To access the notebook, open this file in a browser:
        file:///home/xxxx/xxxx/.local/share/jupyter/runtime/nbserver-275862-open.html
    Or copy and paste one of these URLs:
        http://localhost:8889/?token=49ba65820b79e0cfcf769f311cob5f70ffac2396f251ba7a
     or http://127.0.0.1:8889/?token=49ba65820b79e0cfcf769f311cob5f70ffac2396f251ba7a
```

Open any of the two last links in a browser and done!

## More details 

### Job estimation (gadi specific)

You can use 

```bash
job su [profile]
```

to compute the resource usage of your profile. 
You can also pass any PBS script that you can submit with `qsub`. 

### Project File

PBS Workbench tracks your running job using the file `~/pbs-workbench/project.job`, which contains the job ID of the current job. 
Don't edit or delete that file. 

### Log Files

Job output is saved to `~/pbs-workbench/logs/` with files named:

- `{job_id}.gadi-pbs.OU` (standard output)
- `{job_id}.gadi-pbs.ER` (standard error)


## Common problems

Since the job node doesn't have internet acccess, it is possible that vscode can't install all the proper Remote SSH server. The solution is to first connect to the login node with `--remote ssh-remote+gadi.nci.org.au`. Once it goes in and installs everything, you should be able to connect to the job node. 

## Limitations

Currently, only one job can be run at a time. 


# pbs-workbench

Start a PBS job that runs idle to ssh into and work interactively. 

## Installation

Clone this repo into your home and run the install script. 

```bash
git clone https://github.com/eliocamp/pbs-workbench
bash pbs-workbench/install.sh
```

To uninstall, run `uninstall.sh`.

##  Usage

First, create a profile with `job profile`. This will walk you through a few config options. You can keep all the defaults if you want. 

Then, to start a job with the `default` profile, use

```sh
job start
```

If you want to start a different profile, use 

```sh
job start <profile> 
```

With the name of the profile.

This will start a job and open up the monitor, which looks like this

```
==================================================
           PBS Workbench Monitor
==================================================

📍 Job ID: 148114350.gadi-pbs

⏳ Status: QUEUED - Waiting for job to run
   Job is waiting for available resources...

==================================================
Updates every 10 seconds
```

Once the job starts, the monitor will change to something like this: 

```
==================================================
           PBS Workbench Monitor
==================================================

📍 Job ID: 148114816.gadi-pbs

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

You can close the monitor anytime you want and open it up again with 

```sh
job monitor
```

To stop the job, use 

```sh
job end
```

### SSH

In a terminal **in your local machine**: 

Use the SSH command to ssh into the node: 

```sh
ssh -X gadi-cpu-clx-0683.gadi.nci.org.au
```

### VScode and similar IDEs

To use a IDE that suppeorts the Remote SSH extension, like VSCode or its forks, first you need to set up the proxy jump [as explained here](https://21centuryweather.github.io/21st-Century-Weather-Software-Wiki/gadi/vscode.html#configure-ssh-only-once). 

Then, use the remote-ssh command to use vscode or a similar editor that supports the Remote SSH extension. You need to add the command name before. 

For example, to use vscode, use 

```sh
code --remote ssh-remote+gadi-cpu-clx-0683.gadi.nci.org.au /home/xxx/xxxx/pbs-workbench
```

For Positron, use

```sh
positron --remote ssh-remote+gadi-cpu-clx-0683.gadi.nci.org.au /home/xxx/xxxx/pbs-workbench
```

This will open the editor, connect to the remote node, and open the current directory. 

### Jupyter notebook

To run a jupyter notebook first **in your local machine** run the SSH tunnel command:  


```sh
ssh -L 8080:127.0.0.1:8080 xxxxxx@gadi-cpu-clx-0683.gadi.nci.org.au
```

This will SSH into the node. Now in the node, navigate to your project and start a jupyter notebook 

```sh
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

#### Common problems

Since the job node doesn't have internet acccess, it is possible that vscode can't install all the proper Remote SSH server. The solution is to first connect to the login node with `--remote ssh-remote+gadi.nci.org.au`. Once it goes in and installs everything, you should be able to connect to the job node. 

## Limitations

Currently, only one job can be run at a time. 


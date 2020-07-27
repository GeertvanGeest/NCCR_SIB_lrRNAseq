# NCCR SIB Summer School workshop: lrRNAseq

## Pre-course preparations

### Be able to work comfortably on a remote server

* SSH and scripting for windows users: [MobaXterm](https://mobaxterm.mobatek.net/ "get MobaXterm") and [Notepad++](https://notepad-plus-plus.org/downloads/)
* SSH and scripting for mac os/linux users: [Atom](https://atom.io/) with packages like: `platform-ide-terminal` and `remote-edit-ni`
* Transferring files (both windows and unix-based systems): [FileZilla](https://filezilla-project.org/)
* Or any other preferred way to login to a remote, transfer files and work with scripts.

### Other software to install on your PC

* [Integrative Genomics Viewer (IGV)](http://software.broadinstitute.org/software/igv/)

## First login

### Login to AWS EC2 remote server
You will receive an e-mail shortly before the workshop with a key, username and IP address to login on a cloud server.
Login like this:
```
ssh -i path/to/key/key_[USERNAME].pem [USERNAME]@[AWS_IP]
```

### Initiate conda

Once you have logged in, initiate conda:

```
/opt/miniconda3/bin/conda init
```
This modifies your `.bashrc`. So logout and login again, and you can use conda.

### Use conda

Read more on the use of conda [here](https://conda.io/projects/conda/en/latest/user-guide/getting-started.html).

The conda base environment can not be modified, so make your own:

```
conda create --name my_env
```

Activate it:

```
conda activate my_env
```

And install whatever software you need:

```
conda install -c bioconda samtools=1.9
```

### Setup your favourite editor to work remotely

To directly initiate and modify scripts on the remote server you can use plugins:
* Notepadd++: NppFTP
* Atom: remote-edit-ni

With the following details:
* protocol: sftp
* username: your username
* hostname: server IP
* port: 22
* authentication/logon type: path to private key file

## Working on the cloud server

### Some warnings

The cloud server is a temporary instance for this workshop only. Altough the computational resources should be more than enough, **it's a basic Ubuntu server, and there are no hard limits on memory or CPU usage.**
Take therefore into account that great power comes with great responsibility. Overloading it can result in a reboot, cancelling all running calculations.

### Detaching a job

On this server, there is no job scheduler, so everything is run directly from the command line. That means that if a process is running, the command line will be busy, and the job will be killed upon logout. To circumvent this, there are several methods to 'detach' the screen or prevent a 'hangup signal' of a job runnig in the background that will terminate your running job.
The software `screen` or `tmux` can be used to detach your screen, and all messages to stderr or stdout (if not redirected) will be printed to the (detached) console. Use these if you're comfortable with those.

Another, more basic, program to prevent the 'hangup signal' is `nohup`. Use it like so:

```
nohup [YOUR COMMAND] &
```

So, for running e.g. `samtools index` this would be:

```
nohup samtools index alignment.bam &
```

Anything written to stdout or stderr will be written to the file `nohup.out` in your current working directory. 

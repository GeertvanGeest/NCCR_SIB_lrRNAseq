# NCCR SIB Summer School workshop: lrRNAseq


## Be able to work comfortably on a remote server

* For windows users: [MobaXterm](https://mobaxterm.mobatek.net/ "get MobaXterm") and [Notepad++](https://notepad-plus-plus.org/downloads/)
* For mac os/linux users: [Atom](https://atom.io/) with packages like: `platform-ide-terminal` and `remote-edit-ni`
* Or any other preferred way to login on a remote and work with scripts.

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

Use your username, server IP and ssh key in their respective settings.

## Working on the cloud server

The cloud server is a temporary instance for this workshop only. **It's a basic Ubuntu server, and there are no hard limits on memory or CPU usage.** 
Take therefore into account that great power comes with great responsibility. Overloading it can result in a reboot, cancelling all running calculations.

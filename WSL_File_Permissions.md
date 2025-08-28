# File Permissions when Working with WSL

## Links Explaining WSL/Windows Permission Structure
[Learn Microsoft: File Permissions for WSL](https://learn.microsoft.com/en-us/windows/wsl/file-permissions)  
[Chmod/Chown WSL Improvements](https://devblogs.microsoft.com/commandline/chmod-chown-wsl-improvements/)  
[Fix Windows Subsystem for Linux (WSL) File Permissions](https://www.turek.dev/posts/fix-wsl-file-permissions/)  
[GitHub: MicrosoftDocs/WSL - File Permissions for WSL](https://github.com/MicrosoftDocs/WSL/blob/main/WSL/file-permissions.md)

## Unmounting the /mnt/c directory and then Mounting with Metadata Available

```bash
# Checking for processes using the mount point

fuser -cu

# If there are processes shown or getting filesystem busy messages when unmounting use this command
# to kill  the running processes.

fuser -kc /mnt/c

# Unmounting and remounting the filesystem with metadata enables  for WSL.

sudo umount /mnt/c 
sudo mount -t drvfs C: /mnt/c -o metadata,uid=1000,gid=1000,umask=22,fmask=111
```

## Setting up WSL to Mount Filesystems with Metadata Enabled Permanently  

```bash
# Edit the /etc/wsl.conf file and add the following statements.

[automount]
enabled = true
options ="metadata,umask=22,fmask=11"
```

## Ensure umask is Set When Logging into System

```bash
# Add the following statements to /etc/profile

if [[ "$(umask)" = "0000" ]]; then
  umask 0022
fi
```









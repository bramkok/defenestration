# Create vmdk file for physiscal disk

function Virtualize-Disk($user, $vmDirName, $vmdkFileName, $driveNumber) {
  write $user
  write $vmDirName
  write $vmdkFileName
  write $driveNumber

  if (!($user)) {
    $user = $USER
  }
  if (!($vmDirName)) {

    write "with paren." ($vmDirName)
    write "sans paren." $vmDirName

    sleep 2
    exit
  }

  $filename = "C:\Users\$user\VirtualBox VMs\$vmDirName\$vmdkFileName.vmdk"
  echo $filename
  VBoxManage internalcommands createrawvmdk -filename $filename -rawdisk \\.\PhysicalDrive$driveNumber
}

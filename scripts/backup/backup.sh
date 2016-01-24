cat hosts | awk '{print $1}' > /tmp/hosttmp
cat hosts | awk '{print $2}' > /tmp/filetmp
readarray hostlist < /tmp/hosttmp
readarray filelist < /tmp/filetmp
total=${#hostlist[*]}
for (( i=0; i<=$(( $total -1 )); i++ )) 
  do
     hostname=$(ssh ${hostlist[$i]} "hostname")
     echo $hostname 
     rhost="${hostlist[$i]}:${filelist[$i]}"
     echo $rhost
     dest="$1$hostname"
     echo $dest
     rsync -e "ssh -o StrictHostKeyChecking=no" -H -raAx --delete --progress "$rhost" "$dest"
  done
rm /tmp/hosttmp
rm /tmp/filetmp

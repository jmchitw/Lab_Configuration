#!/bin/bash

#vmware-vdiskmanager -r Golden.vmdk -t 3 ../Test-Clone/Test-Clone.vmdk

json_file="$(dirname "$0")/lab_vms.json"
clones=$(jq -c '.lab_vms[]' $json_file)

Clone_VMs() {
	for clone in $clones
	do
		(
			mkdir -p $tgt_dir
			vmware-vdiskmanager -r ${src_dir}/${src_vm}.vmdk -t $dsk_type ${tgt_dir}/${tgt_vm}.vmdk  
			if [ $? -eq 0 ]
			then
				echo "${tgt_vm}'s disks were successfully cloned." 
			else
				echo "There was a problem cloning $tgt_vm}'s disk"
			fi
		) &
	done
	wait
}

Copy_vmx_File() {
for clone in $clones 
do
	src_vm=$(echo $clone | jq -r '.source_vm')
	src_dir=$(echo $clone | jq -r '.source_dir')
	tgt_vm=$(echo $clone | jq -r '.target_vm')
	tgt_dir=$(echo $clone | jq -r '.target_dir')

	echo "Copying ${src_dir}/${src_vm}.vmx to ${tgt_dir}/${tgt_vm}.vmx."
	cp ${src_dir}/${src_vm}.vmx ${tgt_dir}/${tgt_vm}.vmx
	echo "Modifying ${tgt_dir}/${tgt_vm}.vmx to contain $tgt_vm references."
	sed -i.$(date +'%Y%m%d') -e "s/${src_vm}/${tgt_vm}/g" ${tgt_dir}/${tgt_vm}.vmx
	sed -i -e '/.*\.subnqnUUID/d' ${tgt_dir}/${tgt_vm}.vmx
	echo -e "\n"
done
}

#Clone_VMs
Copy_vmx_File

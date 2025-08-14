#!/bin/bash

#vmware-vdiskmanager -r Golden.vmdk -t 3 ../Test-Clone/Test-Clone.vmdk

json_file="$(dirname "$0")/lab_vms.json"
clones=$(jq -c '.lab_vms[]' $json_file)
declare -A job_pids
declare -A exit_codes

Clone_VMs() {
	count=0
	for clone in $clones
	do
		src_vm=$(echo $clone | jq -r '.source_vm')
		src_dir=$(echo $clone | jq -r '.source_dir')
		tgt_vm=$(echo $clone | jq -r '.target_vm')
		tgt_dir=$(echo $clone | jq -r '.target_dir')
		dsk_type=$(echo $clone | jq -r '.disk_type')

		mkdir -p $tgt_dir || echo "Failed to create $tgt_dir"
		#(sleep 15; exit $(($count % 2))) &
		#count=`expr $count + 1`
		vmware-vdiskmanager -r ${src_dir}/${src_vm}.vmdk -t $dsk_type ${tgt_dir}/${tgt_vm}.vmdk > /vm/RHEL-9-4/Lab_Configuration/${tgt_vm}_clone.log 2>&1 &
		job_pids["$tgt_vm"]=$!
		echo "Cloning $src_vm to $tgt_vm with process id ${job_pids["$tgt_vm"]}"
	done

	for key in ${!job_pids[@]}
	do
		wait ${job_pids["$key"]}
		exit_codes["$key"]=$?
		#echo ${!job_pids[@]}
		if [ ${exit_codes["$key"]} -ne 0 ]
		then 
			echo "Failed to clone $key with an exit code of ${exit_codes["$key"]}"
		else
			echo "$key was successfully cloned"
		fi
	done	
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

Clone_VMs
Copy_vmx_File

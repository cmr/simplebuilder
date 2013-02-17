#!/bin/bash

success=0
fail=0

function on_the_way_out() {
	echo "Exiting..."
	echo "Success: $success"
	echo "Fail:    $fail"
	exit 0
}

trap on_the_way_out SIGINT

while read -r line; do
	pushd "/var/abs/$line" > /dev/null
	makepkg -i --noconfirm
	if [ $? -eq 0 ]; then
		success=$(($success + 1))
		echo "$line" >> successes
	else
		fail=$(($fail+1))
		echo "$line" >> failures
	fi
	popd > /dev/null
done

on_the_way_out

#!/bin/bash

success=0
fail=0

function on_the_way_out() {
	echo "Exiting..."
	echo "Success: $success"
	echo "Fail:    $fail"
	exit 0
}

cwd=$(pwd)

trap on_the_way_out SIGINT

while read -r line; do
	if [ ! -d "/var/abs/$line" ]; then
		echo "$line" >> $cwd/nonexistent
		continue
	fi

	pushd "/var/abs/$line" > /dev/null
	makepkg -i --noconfirm
	if [ $? -eq 0 ]; then # XXX: $? of makepkg
		success=$(($success + 1))
		echo "$line" >> $cwd/successes
	else
		fail=$(($fail+1))
		echo "$line" >> $cwd/failures
	fi
	popd > /dev/null
done

on_the_way_out

#!/bin/sh

old_assignment=assignment2

if [ $# != 1 ]; then
	echo "$0 <assignment name>"
	exit 1
fi

new_assignment=$1

mkdir $new_assignment
cp -r $old_assignment/.vscode $new_assignment
cp $old_assignment/assignment.* $old_assignment/main.adb $new_assignment


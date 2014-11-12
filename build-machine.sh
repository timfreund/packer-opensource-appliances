#!/usr/bin/env bash

name=$1

cmd="packer build"

for vf in common ubuntu ubuntu14.04;
do
    cmd="${cmd} -var-file=../../common/variables-${vf}.json"
done

cmd="${cmd} -only qemu machine.json"

cd machines/${name}
$cmd

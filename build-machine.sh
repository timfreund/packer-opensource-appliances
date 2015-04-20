#!/usr/bin/env bash

MACHINENAME=unknown
MACHINEDIR=`dirname ${0}`/machines
USETEMPLATEJSON=0
BUILDER=all

usage()
{
cat<<EOF
usage : $0 options

Build a machine with packer using default variable values

OPTIONS:
  -h      Show this message
  -m      The machine name
  -b      The builder (all builders is the default)

EOF
}

while getopts "b:m:h" OPTION
do
    case $OPTION in
        h)
            usage
            exit 0
            ;;
        m)
            MACHINENAME=${OPTARG}
            DESTDIR=${MACHINEDIR}/${MACHINENAME}
            ;;
        b)
            BUILDER=${OPTARG}
            ;;
        ?)
            usage
            exit 1
            ;;
    esac
done

if [[ ${MACHINENAME} == "unknown" ]]
then
    echo "A machine name is required"
    usage
    exit 2
fi

set -x
cmd="packer build"

for vf in common ubuntu ubuntu14.04;
do
    cmd="${cmd} -var-file=../../common/variables-${vf}.json"
done

for vf in common/private/*json;
do
    cmd="${cmd} -var-file=../../${vf}"
done

if [[ ${BUILDER} != "all" ]]
then
    cmd="${cmd} -only ${BUILDER}"
fi
cmd="${cmd} machine.json"

cd ${DESTDIR}
if [ -e output ]
then
    rm -rf output
fi

if [ ! -e machine.json ]
then
    USETEMPLATEJSON=1
    echo "Use the default machine.json for this machine's template"
    template_name=`cat meta.json  | grep template | sed -e 's/.*": "//' -e 's/"//'`
    cp ../../templates/${template_name}/machine.json .
    machine_name=`basename ${PWD}`
    sed -e "s/MACHINENAME/${machine_name}/" -i machine.json
fi

if [ -e Puppetfile ]
then
    r10k -v DEBUG puppetfile install
fi
pwd
$cmd

if [ $USETEMPLATEJSON==1 ]
then
    rm machine.json
fi

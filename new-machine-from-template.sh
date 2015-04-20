#!/usr/bin/env bash

MACHINENAME=unknown
MACHINEDIR=`dirname ${0}`/machines
TEMPLATE=unknown

usage()
{
cat <<EOF
usage : $0 options

Create a new machine definition from a template

OPTIONS:
  -h      Show this message
  -m      The machine name
  -t      The template directory

The template directory will be copied to ${MACHINEDIR}/MACHINENAME
and the string MACHINENAME will be replaced with the value of MACHINENAME
in all files.

EOF
}

while getopts "t:m:h" OPTION
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
        t)
            TEMPLATE=${OPTARG}
            ;;
        ?)
            usage
            exit 1
            ;;
    esac
done

if [[ ${MACHINENAME} == "unknown" || ${TEMPLATE} == "unknown" ]]
then
    echo "Values for machine name and template directory are required"
    usage
    exit 2
fi

if [ -e ${DESTDIR} ]
then
    echo "${DESTDIR} already exists"
    exit 3
fi

if [ ! -d ${TEMPLATE} ]
then
    echo "${TEMPLATE} does not exist"
    exit 4
fi

cp -r ${TEMPLATE} ${DESTDIR}
find ${DESTDIR} -type f -exec sed -e "s/MACHINENAME/${MACHINENAME}/" -i {} \;
rm ${DESTDIR}/machine.json


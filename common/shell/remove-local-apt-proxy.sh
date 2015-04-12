#!/usr/bin/env bash

if [ -f /etc/apt/apt.conf ]
then
    sed -e 's/Acquire::http::Proxy/# Acquire::http::Proxy/' -i /etc/apt/apt.conf
fi


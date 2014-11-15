#!/usr/bin/env bash

sed -e 's/Acquire::http::Proxy/# Acquire::http::Proxy/' -i /etc/apt/apt.conf

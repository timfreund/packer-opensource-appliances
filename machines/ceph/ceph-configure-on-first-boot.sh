#!/usr/bin/env bash

puppet apply --verbose --debug --modulepath /home/packer/modules /home/packer/site.pp

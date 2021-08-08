#!/bin/bash

baseurl=localhost/RFC9000_Chinese_Translation/
port="9300"
hugo server -D -b ${baseurl} -p ${port}

#!/bin/bash

function expect()
{
    file=$1
    regex=$2
    code=$3

    grep -q -E "${regex}" "${file}"
    if [ $? -ne 0 ]
    then
        echo TEST FAILED: ERROR CODE $code
        exit 1
    fi
}

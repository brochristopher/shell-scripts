#!/bin/bash

encode_string() {
        echo -n "${1}" | base64
}

encode_file() {
        cat ${1} | base64
}

decode_string() {
        echo -n "${1}" | base64 -d
}

decode_file() {
        cat ${1} | base64 -d
}


# Check to make sure an argument was passed
if [[ $# -eq 0 || $# -eq 1 ]]; then
        echo "Usage: ${0} -flag <argument>"
        echo "To encrypt a string: ${0} -s \"Hello world\""
        echo "To encrypt the contents of a file:  ${0} -f /path/to/a/file"
        echo "To decrypt a string or file, simply use -ds or -df flags instead."
        exit 150
fi

while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
                -s|--string)
                        encode_string "${2}"
                        ;;
                -f|--file)
                        encode_file "${2}"
                        ;;
                -ds|--decode-string)
                        decode_string "${2}"
                        ;;
                -df|--decode-file)
                        decode_file "${2}"
                        ;;
        esac

        shift
done

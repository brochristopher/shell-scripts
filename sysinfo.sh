#!/bin/bash

print_message() {
        echo "Fetching $1 information..."
}

get_memory() {
        print_message "memory"
        free -h
        echo -e "\n"
}

get_cpu() {
        print_message "cpu"
        top -n 1 | awk 'NR==3'
        echo -e "\n"
}

get_disk() {
        print_message "disk"
        df -h
        echo -e "\n"
}

if [[ $# -eq 0 ]]; then
        echo "You have not provided an option, providing CPU, memory, and disk info..."
        echo -e "\n"
        get_memory
        get_cpu
        get_disk
fi

while [[ $# -gt 0 ]]; do
        key="$1"

        case $key in
                -m|--memory)
                        get_memory
                        ;;
                -c|--cpu)
                        get_cpu
                        ;;
                -d|--disk)
                        get_disk
                        ;;
                *)
                        echo "Unknown option: $1"
                        ;;
        esac

        shift
done

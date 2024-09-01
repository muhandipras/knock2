#!/bin/sh

show_help() {
    echo "Usage: sh $0 [-h] [-w WORDLIST_FILE] [-d DELAY_MS]"
    echo ""
    echo "positional arguments:"
    echo "  host                  Hostname or IP address of the host."
    echo "  wordlist              Port Wordlist (3 lines combination)"
    echo ""
    echo "optional arguments:"
    echo "  -h, --help            Show this help message and exit"
    echo "  -d DELAY, --delay DELAY"
    echo "                        Delay between each knock. Default is 200 ms."
    exit 0
}

# Default values
DELAY_MS=200

# Parse optional arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -h|--help)
            show_help
            ;;
        -d|--delay)
            DELAY_MS=$2
            shift 2
            ;;
        -w|--wordlist)
            WORDLIST_FILE=$2
            shift 2
            ;;
        *)
            if [ -z "$IP" ]; then
                IP=$1
            elif [ -z "$WORDLIST_FILE" ]; then
                WORDLIST_FILE=$1
            else
                echo "Unknown argument: $1"
                show_help
            fi
            shift
            ;;
    esac
done

# Validate required arguments
if [ -z "$IP" ] || [ -z "$WORDLIST_FILE" ]; then
    echo "Error: Host and Wordlist are required."
    show_help
fi

if [ ! -f $WORDLIST_FILE ]; then
    echo "Wordlist file not found: $WORDLIST_FILE"
    exit 1
fi

PORTS=()
while IFS= read -r line; do
    PORTS+=("$line")
done < "$WORDLIST_FILE"

if [ ${#PORTS[@]} -lt 3 ]; then
    echo "Wordlist must contain at least 3 ports"
    exit 1
fi

for ((i = 0; i < ${#PORTS[@]}; i+=3)); do
    if [ $((i+3)) -le ${#PORTS[@]} ]; then
        echo "Executing knock for ports: ${PORTS[$i]}, ${PORTS[$i+1]}, ${PORTS[$i+2]}"
        knock -v $IP ${PORTS[$i]} ${PORTS[$i+1]} ${PORTS[$i+2]}
        sleep $(bc <<< "scale=3; $DELAY_MS/1000")
    else
        echo "Not enough ports left for a complete set (3 ports) at index $i"
        break
    fi
done

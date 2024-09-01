# Knock2

Description
------------
Knock2 is a tool that conducts port knocking bruteforce attack and can act as a simple port knocking client.

Requirements
-------------
* Knockd

Installing Dependencies
-------------
`sudo apt-get install knockd`

Usage
-------------
```
usage: sh knock2.sh [-h] [-w] [-d]

positional arguments:
  host                  Hostname or IP address of the host.
  wordlist              Port Wordlist (3 lines combination)

optional arguments:
  -h, --help            show this help message and exit
  -d DELAY, --delay DELAY
                        Delay between each knock. Default is 200 ms.
```

Examples
-------------
* Simple port knocking example: 
`sh knock2.sh 127.0.0.1 -w wordlist.txt`
```
******************************************************
* Knock2 v1.0                                        *
* Coded by andy182                                   *
* https://github.com/muhandipras                     *
******************************************************

[+] hitting tcp 127.0.0.1:7000
[+] hitting tcp 127.0.0.1:8000
[+] hitting tcp 127.0.0.1:9000 
```

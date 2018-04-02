#! /bin/bash

############################################
function cmd(){
  screen -r $1 -p$2 -X stuff "$3"
}

function enter(){
  screen -r $1 -p$2 -X eval "stuff \015"
}

function _command(){
  sleep 0.1
  cmd $1 $2 "$3"
  sleep 0.1
  enter $1 $2
}
############################################


screen -dmS cuckoo

num=6

for i in {1..$num}
do
  _command cuckoo 0 "screen"
done

for i in {0..$num}
do
  _command cuckoo $i "source /home/cuckoo/Desktop/venv/bin/activate"
done

_command cuckoo 0 '. /home/cuckoo/Desktop/network.sh'
_command cuckoo 0 'cuckoo -d'
_command cuckoo 1 'cuckoo api'
_command cuckoo 2 'cuckoo api -p 8091'
_command cuckoo 3 'cuckoo process p1'
_command cuckoo 4 'cuckoo process p2'
_command cuckoo 5 'cuckoo web'
_command cuckoo 6 'cd /home/cuckoo/Desktop/'

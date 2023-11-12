#! /bin/bash
#
# oneshot setup for pypush sms registration
# written on Debian 12.2 using python-3.11.2

DIR=$HOME
PYPUSH=$DIR/pypush

# ref: https://www.cyberciti.biz/tips/linux-unix-pause-command.html
function pause() {
    read -p "$*"
}

#ref: https://stackoverflow.com/questions/2853803/how-to-echo-shell-commands-as-they-are-executed
function verbose() {
    echo "\$ $@" ; "$@" ;
}

echo "pypush will be downloaded to, and run from, $DIR"

# update apt repositories
verbose sudo apt update

# install git and python dependencies, if not already present
verbose sudo apt install git python3-full python3-pip

# download pypush
cd $DIR
verbose git clone https://github.com/beeper/pypush

# checkout the sms-registration branch
cd $PYPUSH
verbose git checkout -b sms-registration
verbose git reset --hard remotes/origin/sms-registration

# setup python-venv
verbose python3 -m venv $PYPUSH

# install python dependencies
verbose $PYPUSH/bin/python3 $PYPUSH/bin/pip3 install -r $PYPUSH/requirements.txt

pause "Press [Enter], or any key, to resume the script once the SMS Registration Helper app is setup and standing by"

# obtain device IP address from user
read -p "Phone IP Address from SMS Registration Helper:" ip_addr1
echo $ip_addr1

verbose $PYPUSH/bin/python3 demo.py --phone $ip_addr1

verbose $PYPUSH/bin/python3 $PYPUSH/demo.py --daemon

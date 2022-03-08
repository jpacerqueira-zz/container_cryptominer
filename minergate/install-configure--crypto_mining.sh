#\bin\bash
##  
#####https://www.tomshardware.com/uk/how-to/mine-cryptocurrency-raspberry-pi
##  
#sudo apt-get update && sudo apt-get upgrade -y
#sudo apt install git automake autoconf libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev 
##  
#####
rm -rf  cpuminer-multi
git clone https://github.com/carolinedunn/cpuminer-multi.git
##  
cd cpuminer-multi
##
sudo ./autogen.sh
sudo ./configure
sudo ./build.sh
##  

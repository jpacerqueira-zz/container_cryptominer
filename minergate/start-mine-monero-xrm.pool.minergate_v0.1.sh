#!/usr/bin/env bash
##
#
cd $HOME/cpuminer-multi
TRDDD=$(date +"%Y-%m-%d")
#
if [[ $CRYPTO_EMAIL == "" ]]; then
   CRYPTO_EMAIL=joao@fuelbigdata.com
fi
#
./cpuminer -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45700 -u $CRYPTO_EMAIL  > $HOME/mining-monero-$TRDDD-v0.1.log & 
#
sleep 5
tail -f $HOME/mining-monero-$TRDDD-v0.1.log
#

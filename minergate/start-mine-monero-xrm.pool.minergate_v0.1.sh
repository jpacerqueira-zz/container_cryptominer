#\bin\bash
cd $HOME/cpuminer-multi
TRDDD=$(date +"%Y-%m-%d")
#
./cpuminer -a cryptonight -o stratum+tcp://xmr.pool.minergate.com:45700 -u joao@fuelbigdata.com  > $HOME/mining-monero-$TRDDD-v0.1.log & 
#
sleep 5
tail -f $HOME/mining-monero-$TRDDD-v0.1.log
#

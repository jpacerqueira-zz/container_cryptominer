#
##
## Downgraded to 18.04 LTS Bionic from Focal Ubuntu
## Upgraded to 20.04 LTS Bionic from Focal Ubuntu
##
FROM ubuntu:18.04
#FROM ubuntu:22.04
#FROM ubunto:bionic
#FROM ubuntu:20.04
##
#
RUN apt-get update -y && apt-get install -y apt-utils \
    sudo \
    sed
RUN apt-get upgrade -y
RUN \
    groupadd -g 999 miner && useradd -u 999 -g miner -G sudo -m -s /bin/bash miner && \
    sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
    sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
    echo "miner ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \
    echo "Customized the sudoers file for passwordless access to the miner user!" && \
    echo "miner user:";  su - miner -c id
RUN export DEBIAN_FRONTEND=noninteractive ; \
    apt-get update -y && apt-get install -y curl \
    tzdata \
    net-tools \
    iptables \
    iptables-persistent \
    wget \
    zip \
    unzip \
    tar \
    bzip2 \ 
    python-qt4 \
    python-pyside \
    python-pip \
    python3-pip \
    python3-pyqt5 \
    vim \
    software-properties-common \
    cron \ 
    git automake autoconf libcurl4-openssl-dev libjansson-dev libssl-dev libgmp-dev # cryptominer required libs   
#
RUN ln -fs /usr/share/zoneinfo/GMT+1 /etc/localtime #Expose notebook cronjobs
RUN (echo "* * * * * root echo "Hello world" >> /var/log/cron.log 2>1&" > /etc/cron.d/hello-cron ; chmod 0644 /etc/cron.d/hello-cron )# Apply cron job
RUN crontab /etc/cron.d/hello-cron # Create the log file to be able to run tail
RUN touch /var/log/cron.log # Run the command on container startup
CMD cron && tail -f /var/log/cron.log #Expose notebook cronjobs
ADD minergate/*.sh /home/miner/
RUN chmod 777 /home/miner/*.sh
#
RUN chmod 777 /home/miner/*.sh
RUN chown miner:miner -R /home/miner
EXPOSE 9003/tcp
RUN export DEBIAN_FRONTEND=interactive
USER miner
CMD export HOME=/home/miner # Anaconda python and R package installer
#
RUN  sleep 1 ; export HOME=/home/miner ; cd $HOME ; \
     sudo bash -x $HOME/install-configure--crypto_mining.sh  ; \
     sudo chown miner:miner -R $HOME ; \
     sleep 2 ; \
     sudo rm -rf /tmp/* ; \
     fix-permissions $HOME ; \
     mkdir -p $HOME/crontab ; \
     ! (crontab -l | grep -q "start-mine-monero-xrm.pool.minergate_v0.1.sh") && (crontab -l; echo "46 5  * * * bash -x /home/miner/start-mine-monero-xrm.pool.minergate_v0.1.sh 2>1&") | crontab - ; \
     sleep 1
#
RUN  cd cpuminer-multi && bash -x build.sh
#
CMD sleep 5 ; \
    export HOME=/home/miner ; cd $HOME ; \
    bash -x $HOME/start-mine-monero-xrm.pool.minergate_v0.1.sh ; \
    sudo service cron reload ; \
    sleep infinity
#

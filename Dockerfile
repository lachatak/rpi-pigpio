FROM resin/rpi-raspbian:jessie
MAINTAINER Krisztian Lachata <krisztian.lachata@gmail.com>

RUN apt-get update && apt-get upgrade
RUN apt-get install build-essential daemontools git -y

WORKDIR /opt
RUN git config --global http.sslVerify false
RUN git clone https://github.com/joan2937/pigpio
WORKDIR /opt/pigpio
RUN make
RUN make install
RUN ln -s /usr/local/lib/libpigpio.so /usr/lib/libpigpio.so
RUN mkdir -p  /etc/svscan/pigpiod
RUN echo "#!/bin/bash\n/opt/pigpio/pigpiod" > /etc/svscan/pigpiod/run
RUN chmod +x /etc/svscan/pigpiod/run

EXPOSE 8888

CMD ["/usr/bin/svscan", "/etc/svscan/"]

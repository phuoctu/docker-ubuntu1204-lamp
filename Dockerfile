FROM ubuntu:12.04
MAINTAINER phuoctu <tran_phuoctu@co-mit.com.vn>

RUN apt-get -y update
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install supervisor \
													apache2 \
													mysql-server \
													php5 \
													libapache2-mod-php5 \
													php5-mysql \
													php5-mcrypt
								
#ssh
RUN DEBIAN_FRONTEND=noninteractive apt-get -y install openssh-server
RUN mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

EXPOSE 22 80
ADD ./supervisord.conf /etc/supervisor/conf.d/supervisord.conf
CMD ["/usr/bin/supervisord"]

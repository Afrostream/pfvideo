# pfvideo
Ce projet necessite l'installation de docker sur votre machine afin de proceder aux etapes d'installation
Pour les utilisateurs de MacOSX: https://docs.docker.com/engine/installation/mac/

Docker-compose project to spawn a complete video platform up and ready.
This compose include:
- rabbitmq configured
- mysql 5.5 (files will go on ./data/mysql for persistency)
- pfencoder (files will be take from /space/videos/sources corresponding to ./data/videos_sources and put in /space/videos/encoded corresponding to ./data/videos_encoded)
- pfscheduler

# Install
Run init.sh (his will take all git repositories automatically and run docker-compose build)
Run docker-compose up (down for stopping or Ctrl-C)

You will need to install docker before (available on Linux, MacOSX and Windows)

# PFscheduler
The scheduler is running on port :4000
If you want to know how to use the API calls, please read the README.md file of pfscheduler

# PFencoder
The encoder is running but there is no port listening, all commands ares received from the rabbitmq process

# RabbitMQ
RabbitMQ is available and the port 15673 is available to connect via http for managing the queues
login/password rabbitmq/rabbitmq

# MySQL
Mysql process is running on port 3307 (provide -P 3307 on the mysql command line and don't use localhost but your local private ip to access if you have another mysql server running on your host)
login/password root/mysql

# SOON
- Add nginx + USP

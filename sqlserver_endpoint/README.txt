First update everything labeled XXXXX in real.sh

You'll need copies of https_cert.crt ldap_cert.cer tomcat_https.keystore tomcat.keystore in the working directory. We still don't know if we really actually need https_cert.crt

Build with `sudo docker build -t mezuri/sqlserver_endpoint .`

Save it to a file with `sudo docker save mezuri/sqlserver_endpoint -o out.tar`

Upload out.tar to the server and load it with `cat out.tar | sudo docker load`

Upload real.sh to the server and run it to start the server

then configure docker service

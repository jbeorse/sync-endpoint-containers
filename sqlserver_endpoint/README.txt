First update everything labeled XXXXX in real.sh

You'll need copies of https_cert.crt ldap_cert.cer tomcat_https.keystore tomcat.keystore in the working directory. We still don't know if we really actually need https_cert.crt

tomcat_https.keystore should have the cert and also the intermediate cert in it, add them using the instructions here: https://www.godaddy.com/help/tomcat-generate-csrs-and-install-certificates-5239

Build with `sudo docker build -t mezuri/sqlserver_endpoint .`

Save it to a file with `sudo docker save mezuri/sqlserver_endpoint -o out.tar`

Upload out.tar to the server and load it with `cat out.tar | sudo docker load`

Upload real.sh to the server and run it to start the server

Then configure docker service, just change "docker run -d" to "docker service create" in real.sh and run it again. This will install a service that will automatically restart when it fails or when the server is restarted. To see all the registered services do `docker service list` and you can delete an old one with `docker service rm <id>`

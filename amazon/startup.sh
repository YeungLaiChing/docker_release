docker run -d -v /Users/Ching/docker_release/amazon/apps:/apps --name test -P test 
sleep 2
docker ps -a
docker port test 22
docker port test 80
docker exec -t -i test /bin/bash

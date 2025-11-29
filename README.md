Przebudowa
sudo docker-compose build --no-cache
sudo docker-compose up -d


docker restart docker-www-1
docker restart docker-www-1


docker exec -it docker-www-1 apachectl -k graceful

logi
docker-compose logs -f


sudo docker-compose down && sudo docker-compose build --no-cache && sudo docker-compose up -d

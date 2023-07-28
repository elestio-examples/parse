#set env vars
set -o allexport; source .env; set +o allexport;

#wait until the server is ready
echo "Waiting for software to be ready ..."
sleep 30s;

mkdir -p /opt/app-backups/;
echo "docker exec -i mongo sh -c 'mongodump --port 27017 --archive' > /opt/app-backups/last.dump" > /opt/app/save.sh
chmod +x /opt/app/save.sh;

echo "docker exec -i mongo sh -c 'mongorestore --port 27017 --archive' < /opt/app-backups/last.dump" > /opt/app/restore.sh
chmod +x /opt/app/restore.sh;

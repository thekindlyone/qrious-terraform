docker run --name=mynginx1 -d -p 80:80 \
        --health-cmd='curl --fail http://127.0.0.1 || exit 1' \
        --health-interval=1m \
        --health-timeout=3s \
        nginx
python3 -m venv ~/docker_tail/env
cd ~/docker_tail
source env/bin/activate
nohup python3 docker_tail.py >> docker_stats.log&
sleep 1

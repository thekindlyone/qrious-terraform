import subprocess
import json
from datetime import datetime
import time

healthcheck_command = ["docker", "inspect", "mynginx1", "--format='{{.State.Health.Status}}'"]
stats_command = ["docker", "stats", "mynginx1", "--no-stream", "--format='{{json .}}'"]

def run_command(command):
    return subprocess.check_output(command).decode().strip().strip("'")


def get_status():
    stats = json.loads(run_command(stats_command))
    health_status = run_command(healthcheck_command)
    curr  = datetime.now()
    stats['time'] = curr.strftime("%d/%m/%Y %H:%M:%S")
    stats['timestamp'] = curr.timestamp()
    stats['health'] = health_status
    return stats

def main():
    while True:
        status = get_status()
        print(status,flush=True)
        time.sleep(10)


if __name__ == '__main__':
    main()
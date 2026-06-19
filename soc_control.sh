#!/bin/bash
# Master SOC Infrastructure Control Gateway
# Individual Contribution by: [Your Name]

echo "=============================================="
echo "    SENTRIX-MINI SOC MANAGEMENT SYSTEM       "
echo "=============================================="

case "$1" in
    stage-images)
        echo "[+] Pre-caching Day 2 & Day 3 container environments..."
        # This tells Docker to look at your blueprint and pull everything down
        docker compose -f day2-3-precache.yml pull
        echo "[+] Infrastructure successfully cached offline!"
        ;;
    check-health)
        echo "[+] Analyzing running SOC component states..."
        # This lists all running containers, their uptime, and their network ports
        docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
        ;;
    *)
        echo "Usage: $0 {stage-images|check-health}"
        exit 1
        ;;
esac
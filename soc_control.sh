#!/bin/bash
# ==================================================
# SENTRIX MINI-SOC CONTROL CENTER
# Contribution by: Vaishnavi
# ==================================================

COMPOSE_FILE="docker-compose.yml"

echo "=============================================="
echo "      SENTRIX MINI-SOC CONTROL CENTER"
echo "=============================================="

case "$1" in

    stage-images)
        echo "[+] Pre-caching Day 2 & Day 3 container environments..."
        docker compose -f "$COMPOSE_FILE" pull
        echo "[+] Infrastructure successfully cached offline!"
        ;;

    start)
        echo "[+] Starting Mini-SOC infrastructure..."
        docker compose -f "$COMPOSE_FILE" up -d
        ;;

    stop)
        echo "[+] Stopping Mini-SOC infrastructure..."
        docker compose -f "$COMPOSE_FILE" down
        ;;

    check-health)
        echo "[+] Analyzing running SOC component states..."
        docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
        ;;

    status)
        echo "[+] SOC Service Status"
        docker ps -a --format "table {{.Names}}\t{{.Status}}"
        ;;

    monitor)
        echo "[+] Monitoring container resource usage..."
        docker stats --no-stream
        ;;

    cleanup)
        echo "[+] Removing stopped containers..."
        docker container prune -f

        echo "[+] Removing unused networks..."
        docker network prune -f

        echo "[+] Cleanup complete."
        ;;

    *)
        echo ""
        echo "Usage: $0 {stage-images|start|stop|check-health|status|monitor|cleanup}"
        echo ""
        echo "Commands:"
        echo "  stage-images   Pre-cache required Docker images"
        echo "  start          Start Mini-SOC infrastructure"
        echo "  stop           Stop Mini-SOC infrastructure"
        echo "  check-health   Show running containers and ports"
        echo "  status         Show status of all containers"
        echo "  monitor        Display container resource usage"
        echo "  cleanup        Remove stopped containers and unused networks"
        echo ""
        exit 1
        ;;
esac
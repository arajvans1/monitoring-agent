#!/bin/bash

# Test Commands for Monitoring Agent
# Usage: ./test_commands.sh [command_number]
# Or run individual commands by copying and pasting

echo "=== Monitoring Agent Test Commands ==="
echo "Make sure your monitoring agent is running on localhost:8080"
echo "Usage: ./test_commands.sh [1-20] or copy individual commands"
echo ""

# HANA/SQL Backend Commands
echo "=== HANA/SQL Backend Commands ==="

echo "1. HANA Memory Usage:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "hana_memory_usage", "params": {}}'"'"
echo ""

echo "2. HANA Active Sessions:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "hana_active_sessions", "params": {}}'"'"
echo ""

echo "3. HANA Top Tables by Memory:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "hana_top_tables_by_memory", "params": {}}'"'"
echo ""

# SOAP Backend Commands
echo "=== SOAP Backend Commands ==="

echo "4. Get SAP Instance List:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "get_instance_list", "params": {}}'"'"
echo ""

echo "5. Get Process List:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "get_process_list", "params": {}}'"'"
echo ""

# REST Backend Commands
echo "=== REST Backend Commands ==="

echo "6. Check HTTP Health Status:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "check_http_status", "params": {"host": "google.com", "port": "80"}}'"'"
echo ""

echo "7. Get GitHub User Info:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "github_user", "params": {"username": "arajvans1"}}'"'"
echo ""

echo "8. Get Random Quote:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "random_quote", "params": {}}'"'"
echo ""

echo "9. Test API with Post ID:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "test_api", "params": {"no": "5"}}'"'"
echo ""

# Shell Backend Commands - Basic
echo "=== Shell Backend Commands - Basic ==="

echo "10. Check Disk Usage:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "disk_usage", "params": {}}'"'"
echo ""

echo "11. Fetch File Information:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "fetch_file_info", "params": {}}'"'"
echo ""

# Shell Backend Commands - OS Monitoring
echo "=== Shell Backend Commands - OS Monitoring ==="

echo "12. System Uptime:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "system_uptime", "params": {}}'"'"
echo ""

echo "13. Memory Information:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "memory_info", "params": {}}'"'"
echo ""

echo "14. CPU Usage Information:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "cpu_info", "params": {}}'"'"
echo ""

echo "15. Network Connections:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "network_connections", "params": {}}'"'"
echo ""

echo "16. Running Processes (Top 15):"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "running_processes", "params": {"lines": "15"}}'"'"
echo ""

echo "17. Check Specific Port Usage (8080):"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "check_port", "params": {"port": "8080"}}'"'"
echo ""

echo "18. System Load Average:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "system_load", "params": {}}'"'"
echo ""

echo "19. Last User Logins:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "last_logins", "params": {"count": "10"}}'"'"
echo ""

echo "20. Kernel Version:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "kernel_version", "params": {}}'"'"
echo ""

# Bonus Commands
echo "=== Bonus Commands ==="

echo "21. Check Service Status (SSH):"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "check_service", "params": {"service": "ssh"}}'"'"
echo ""

echo "22. Find Large Files:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "find_large_files", "params": {"path": "/tmp", "size": "1M", "count": "3"}}'"'"
echo ""

echo "23. Check Environment Variables:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "environment_variables", "params": {"var": "HOME"}}'"'"
echo ""

# Error Testing
echo "=== Error Testing ==="

echo "24. Test Invalid Command:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "invalid_command", "params": {}}'"'"
echo ""

echo "25. Test Missing Required Parameter:"
echo 'curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '"'"'{"name": "github_user", "params": {}}'"'"
echo ""

echo "26. Test Wrong HTTP Method:"
echo 'curl -X GET http://localhost:8080/execute'
echo ""

# Interactive execution function
if [ "$1" != "" ]; then
    case $1 in
        1) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "hana_memory_usage", "params": {}}' ;;
        2) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "hana_active_sessions", "params": {}}' ;;
        3) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "hana_top_tables_by_memory", "params": {}}' ;;
        4) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "get_instance_list", "params": {}}' ;;
        5) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "get_process_list", "params": {}}' ;;
        6) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "check_http_status", "params": {"host": "google.com", "port": "80"}}' ;;
        7) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "github_user", "params": {"username": "arajvans1"}}' ;;
        8) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "random_quote", "params": {}}' ;;
        9) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "test_api", "params": {"no": "5"}}' ;;
        10) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "disk_usage", "params": {}}' ;;
        11) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "fetch_file_info", "params": {}}' ;;
        12) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "system_uptime", "params": {}}' ;;
        13) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "memory_info", "params": {}}' ;;
        14) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "cpu_info", "params": {}}' ;;
        15) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "network_connections", "params": {}}' ;;
        16) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "running_processes", "params": {"lines": "15"}}' ;;
        17) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "check_port", "params": {"port": "8080"}}' ;;
        18) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "system_load", "params": {}}' ;;
        19) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "last_logins", "params": {"count": "10"}}' ;;
        20) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "kernel_version", "params": {}}' ;;
        21) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "check_service", "params": {"service": "ssh"}}' ;;
        22) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "find_large_files", "params": {"path": "/tmp", "size": "1M", "count": "3"}}' ;;
        23) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "environment_variables", "params": {"var": "HOME"}}' ;;
        24) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "invalid_command", "params": {}}' ;;
        25) curl -X POST http://localhost:8080/execute -H "Content-Type: application/json" -d '{"name": "github_user", "params": {}}' ;;
        26) curl -X GET http://localhost:8080/execute ;;
        *) echo "Invalid command number. Use 1-26" ;;
    esac
fi

echo ""
echo "=== Usage Examples ==="
echo "1. Run specific command: ./test_commands.sh 12"
echo "2. Copy and paste individual commands from above"
echo "3. Start monitoring agent first: go run ."
echo ""

#!/bin/bash

# TDD Full Cycle Execution Script
# Usage: ./tdd-cycle-full_english.sh <test_case_name>

# Record start time
START_TIME=$(date +%s)

if [ $# -ne 1 ]; then
    echo "Usage: $0 <test_case_name>"
    exit 1
fi

TEST_CASE_NAME=$1

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Common settings for Claude command
ALLOWED_TOOLS="Write,Edit,Bash(npm:*),Bash(node:*)"
DISALLOWED_TOOLS="Bash(git *)"
VERIFY_ALLOWED_TOOLS="Write,Edit,Bash(npm:*),Bash(node:*),Bash(git status),Bash(git diff)"
VERIFY_DISALLOWED_TOOLS="Bash(git add),Bash(git commit),Bash(git push)"

# TDD cycle execution function
run_tdd_cycle() {
    local test_case=$1

    echo "🔴 RED Phase Started..."
    if ! claude -p "/tdd-red $test_case Implement missing tests" --allowedTools "$ALLOWED_TOOLS" --disallowedTools "$DISALLOWED_TOOLS"; then
        echo -e "${RED}❌ RED Phase Failed${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ RED Phase Completed${NC}"

    echo "🟢 GREEN Phase Started..."
    if ! claude -p "/tdd-green $test_case" --allowedTools "$ALLOWED_TOOLS" --disallowedTools "$DISALLOWED_TOOLS"; then
        echo -e "${RED}❌ GREEN Phase Failed${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ GREEN Phase Completed${NC}"

    echo "🔵 REFACTOR Phase Started..."
    if ! claude -p "/tdd-refactor $test_case" --allowedTools "$ALLOWED_TOOLS" --disallowedTools "$DISALLOWED_TOOLS"; then
        echo -e "${RED}❌ REFACTOR Phase Failed${NC}"
        exit 1
    fi
    echo -e "${GREEN}✅ REFACTOR Phase Completed${NC}"

    echo "🔍 VERIFY COMPLETE Phase Started..."
    local verify_result
    verify_result=$(claude -p "/tdd-verify-complete $test_case" --allowedTools "$VERIFY_ALLOWED_TOOLS" --disallowedTools "$VERIFY_DISALLOWED_TOOLS" 2>&1)
    local verify_exit_code=$?

    if [ $verify_exit_code -ne 0 ]; then
        echo -e "${RED}❌ VERIFY COMPLETE Phase Failed${NC}"
        exit 1
    fi

    echo -e "${GREEN}✅ VERIFY COMPLETE Phase Completed${NC}"

    # Judge the result
    if echo "$verify_result" | grep -E "(Meets quality standards|Implementation complete|Verification complete)" > /dev/null; then
        echo -e "${GREEN}🎉 TDD Cycle Completed: The TDD cycle for $test_case has completed successfully${NC}"
        return 0
    elif echo "$verify_result" | grep -E "(Not implemented|Does not meet quality standards|Additional implementation required)" > /dev/null; then
        echo -e "${YELLOW}🔄 Continuing TDD Cycle: Items not meeting quality standards were found. Returning to RED phase...${NC}"
        return 1
    else
        echo -e "${YELLOW}⚠️  Judgment result is unclear${NC}"
        echo "--- Output from VERIFY COMPLETE phase ---"
        echo "$verify_result"
        echo "--- End of output ---"
        echo ""
        echo -e "${BLUE}Please select from the following:${NC}"
        echo "1) Treat as complete (end TDD cycle)"
        echo "2) Continue from RED phase"
        echo "3) Exit script"
        echo ""

        while true; do
            read -p "Select (1/2/3): " choice
            case $choice in
                1)
                    echo -e "${GREEN}🎉 TDD Cycle Completed: Marked as complete by user.${NC}"
                    return 0
                    ;;
                2)
                    echo -e "${YELLOW}🔄 Continuing TDD Cycle: Returning to RED phase by user's choice.${NC}"
                    return 1
                    ;;
                3)
                    echo -e "${BLUE}👋 Exiting script.${NC}"
                    exit 0
                    ;;
                *)
                    echo "Invalid selection. Please enter 1, 2, or 3."
                    ;;
            esac
        done
    fi
}

# Function to display completion time
show_completion_time() {
    local exit_code=$1
    local end_time=$(date +%s)
    local duration=$((end_time - START_TIME))
    local hours=$((duration / 3600))
    local minutes=$(((duration % 3600) / 60))
    local seconds=$((duration % 60))

    printf "⏱️  Execution Time: "
    if [ $hours -gt 0 ]; then
        printf "%d hours %d minutes %d seconds\n" $hours $minutes $seconds
    elif [ $minutes -gt 0 ]; then
        printf "%d minutes %d seconds\n" $minutes $seconds
    else
        printf "%d seconds\n" $seconds
    fi

    printf "🕐 End Time: %s\n" "$(date +'%Y-%m-%d %H:%M:%S')"

    if [ $exit_code -eq 0 ]; then
        echo -e "${GREEN}✅ Normal exit${NC}"
    else
        echo -e "${RED}❌ Error exit${NC}"
    fi
}

# trap setting (display time even on error exit)
trap 'show_completion_time $?' EXIT

# Main loop
echo "Starting TDD Full Cycle Execution: $TEST_CASE_NAME"
max_cycles=5
cycle_count=0

while [ $cycle_count -lt $max_cycles ]; do
    cycle_count=$((cycle_count + 1))
    echo -e "${BLUE}=== Cycle $cycle_count Started ===${NC}"

    if run_tdd_cycle "$TEST_CASE_NAME"; then
        echo -e "${GREEN}🎉 Overall Complete: TDD cycle completed successfully${NC}"
        exit 0
    fi

    echo -e "${YELLOW}Cycle $cycle_count complete, proceeding to the next cycle...${NC}"
    echo ""
done

echo -e "${RED}❌ Reached maximum number of cycles ($max_cycles). Please check manually.${NC}"
exit 1

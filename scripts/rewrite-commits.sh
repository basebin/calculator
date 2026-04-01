#!/bin/bash
# Script to rewrite commit messages to conventional commit format (lowercase, no "add")
# Usage: ./rewrite-commits.sh

set -e

echo "Rewriting commit messages to conventional format..."
echo ""

git filter-branch -f --msg-filter '
commit_msg=$(cat)

# Remove "add " from anywhere in message
commit_msg=$(echo "$commit_msg" | sed "s/ add / /g")

# Fix messages starting with "add " - remove "add" and keep the rest
commit_msg=$(echo "$commit_msg" | sed "s/^add /")

# Ensure lowercase type prefix
commit_msg=$(echo "$commit_msg" | sed "s/^Fix:/fix:/")
commit_msg=$(echo "$commit_msg" | sed "s/^Feat:/feat:/")
commit_msg=$(echo "$commit_msg" | sed "s/^Docs:/docs:/")
commit_msg=$(echo "$commit_msg" | sed "s/^Chore:/chore:/")
commit_msg=$(echo "$commit_msg" | sed "s/^Ci:/ci:/")
commit_msg=$(echo "$commit_msg" | sed "s/^Refactor:/refactor:/")
commit_msg=$(echo "$commit_msg" | sed "s/^Build:/build:/")

echo "$commit_msg"
' HEAD~20..HEAD

echo "Done. Check git log to verify changes."
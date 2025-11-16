#!/bin/bash

# 1. Check for exactly two arguments
if [ "$#" -ne 2 ]; then
    echo "You need to provide two arguments for this script to work."
    echo "Usage: make-go-dir <root directory name> <identifier name>"
    exit 1
fi

ROOT_DIR=$1
IDENTIFIER=$2

#2. Prompt user to continue
echo "I am about to create a directory structure named '$ROOT_DIR'."
read -p "Do you want me to continue? [Yes/no] " ANSWER

if [[ $ANSWER =~ ^[Yy]es$ ]]
then

#3. Create directory structure
    echo "Create directory structure..."

    mkdir -p "$ROOT_DIR/bin"
    mkdir -p "$ROOT_DIR/cmd/api"
    mkdir -p "$ROOT_DIR/internals"
    mkdir -p "$ROOT_DIR/migrations"
    mkdir -p "$ROOT_DIR/remote"

    # 4. Creating file: go.mod, makefile, main.go
    touch "$ROOT_DIR/go.mod"
    touch "$ROOT_DIR/makefile"
    touch "$ROOT_DIR/cmd/api/main.go"

    #main.go
    cat <<EOT >> "$ROOT_DIR/cmd/api/main.go"
// File: cmd/api/main.go

package main

import "fmt"

func main() {
    fmt.Println("Hello world!")
}
EOT

    #go.mod
    echo "module $IDENTIFIER/$ROOT_DIR" > "$ROOT_DIR/go.mod"

    #5. Final Message to user
    echo ""
    echo "I have created a *main.go* file for you to test the directory structure."
    echo "Type *go run ./cmd/api* at the root directory of your project to test your project."
    echo "Thank you."

else
    echo "Abort."
    exit 1
fi

exit 0
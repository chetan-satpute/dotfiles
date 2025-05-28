package main

import (
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
)

func main() {
	// Use the current working directory as dotfilesDir
	dotfilesDir, err := os.Getwd()
	if err != nil {
		fmt.Println("❌ Failed to get current working directory:", err)
		os.Exit(1)
	}

	packagesDir := filepath.Join(dotfilesDir, "packages")
	targetDir := os.Getenv("HOME")

	// Get subdirectories in packagesDir
	entries, err := os.ReadDir(packagesDir)
	if err != nil {
		fmt.Printf("❌ Failed to read directory %s: %v\n", packagesDir, err)
		os.Exit(1)
	}

	// Loop through all directories
	for _, entry := range entries {
		if entry.IsDir() {
			pkg := entry.Name()
			fmt.Printf("📦 Stowing %s...\n", pkg)

			cmd := exec.Command("stow", "--target="+targetDir, "--dir="+packagesDir, pkg)
			cmd.Stdout = os.Stdout
			cmd.Stderr = os.Stderr

			if err := cmd.Run(); err != nil {
				fmt.Printf("❌ Failed to stow %s: %v\n", pkg, err)
			}
		}
	}

	fmt.Println("✅ All packages stowed to", targetDir)
}


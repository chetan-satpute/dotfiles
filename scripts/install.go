package main

import (
	"bytes"
	"fmt"
	"os"
	"os/exec"
	"path/filepath"
	"strings"
)

func main() {
	dotfilesDir, err := GetGitRoot()
	if err != nil {
		fmt.Println("❌ Failed to get dotfiles directory:", err)
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

func GetGitRoot() (string, error) {
	cmd := exec.Command("git", "rev-parse", "--show-toplevel")

	var out bytes.Buffer
	cmd.Stdout = &out
	cmd.Stderr = os.Stderr

	if err := cmd.Run(); err != nil {
		return "", fmt.Errorf("failed to get git root directory: %w", err)
	}

	return strings.TrimSpace(out.String()), nil
}

package backend

import (
	"os/exec"
	"runtime"
	"strings"
)

type ShellBackend struct{}

func NewShellBackend() *ShellBackend {
	return &ShellBackend{}
}


func (s *ShellBackend) Execute(command string) (any, error) {
	if strings.TrimSpace(command) == "" {
			return "", nil
	}

	// Determine the shell and command flag based on the OS
	var shell string
	var flag string
	
	if runtime.GOOS == "windows" {
			shell = "cmd"
			flag = "/C"
	} else {
			// Unix-like systems 
			shell = "/bin/sh"
			flag = "-c"
	}

	// Execute the command through the shell to handle pipes, redirection, etc.
	cmd := exec.Command(shell, flag, command)
	output, err := cmd.CombinedOutput()
	
	return string(output), err
}

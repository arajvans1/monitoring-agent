package backend

import (
	"os/exec"
	"strings"
)

type ShellBackend struct{}

func NewShellBackend() *ShellBackend {
	return &ShellBackend{}
}


func (s *ShellBackend) Execute(command string) (any, error) {
	args := strings.Fields(command)
	if len(args) == 0 {
		return nil, nil
	}
	cmd := exec.Command(args[0], args[1:]...)
	output, err := cmd.CombinedOutput()
	return string(output), err
}

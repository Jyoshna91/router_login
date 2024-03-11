package main

import (
	"fmt"
	"os/exec"
	"testing"
)

func TestConnectToRouter16(t *testing.T) {
	// Command to list available containers
	psCommand := "sudo docker ps"

	// Execute the command to list available containers
	psOutput, err := exec.Command("sh", "-c", psCommand).Output()
	if err != nil {
		fmt.Println("Error executing docker ps command:", err)
		return
	}

	// Print the output of the docker ps command
	fmt.Println("Available containers:")
	fmt.Println(string(psOutput))

	// Command to log in to bash shell of the container
	loginCommand := "sudo docker exec clab-frrlab-router1 /bin/bash"

	// Execute the command to log in to the bash shell of the container
	loginOutput, err := exec.Command("sh", "-c", loginCommand).CombinedOutput()
	if err != nil {
		fmt.Println("Error logging in to the container:", err)
		return
	}

	// Print the output of the login command
	//fmt.Println("Login output:")
	fmt.Println(string(loginOutput))

	// Command to log in to vtysh
	vtyshCommand := "vtysh"

	// Execute the command to log in to vtysh within the container's environment
	vtyshOutput, err := exec.Command("sh", "-c", loginCommand+" -c '"+vtyshCommand+"'").CombinedOutput()
	if err != nil {
		fmt.Println("Error logging in to vtysh:", err)
		return
	}

	// Print the output of the vtysh command
	fmt.Println("vtysh output:")
	fmt.Println(string(vtyshOutput))

	// Command to show running configuration
	showConfigCommand := "show running-config"

	// Execute the command to show running configuration within the container's environment
	showConfigOutput, err := exec.Command("sh", "-c", loginCommand+" -c '"+vtyshCommand+" -c \""+showConfigCommand+"\"'").CombinedOutput()
	if err != nil {
		fmt.Println("Error showing running configuration:", err)
		return
	}

	// Print the output of the show running-config command
	fmt.Println("Running configuration:")
	fmt.Println(string(showConfigOutput))
}

# kujira-vscode-devcontainer

VS Code Dev Container containing all required components for development on Kujira

# How To Use

 Add a `.devcontainer` folder to your repository with a `devcontainer.json` file as per the below example:
 ```
 {
	"name": "Kujira",
	"image": "ghcr.io/kujira-vscode-devcontainer:latest",
	"runArgs": [
		"--cap-add=SYS_PTRACE",
		"--security-opt",
		"seccomp=unconfined"
	],
	"hostRequirements": {
		"cpus": 4
	},
	// Configure tool-specific properties.
	"customizations": {
		// Configure properties specific to VS Code.
		"vscode": {
			// Set *default* container specific settings.json values on container create.
			"settings": {
				"workbench.colorTheme": "Default Dark+",
				"git.autorefresh": true,
				"git.enableSmartCommit": true,
				"lldb.executable": "/usr/bin/lldb",
				// VS Code don't watch files under ./target
				"files.watcherExclude": {
					"**/target/**": true
				},
				"rust-analyzer.checkOnSave.command": "clippy",
				"editor.formatOnSave": true,
			},
			// Add the IDs of extensions you want installed when the container is created.
			"extensions": [
				"vadimcn.vscode-lldb",
				"mutantdino.resourcemonitor",
				"rust-lang.rust-analyzer",
				"tamasfe.even-better-toml",
				"serayuzgur.crates",
				"GitHub.copilot",
				"BDSoftware.format-on-auto-save",
				"GitHub.codespaces"
			]
		},
	},
	// Use 'forwardPorts' to make a list of ports inside the container available locally.
	// "forwardPorts": [],
	// Use 'postCreateCommand' to run commands after the container is created.
	// "postCreateCommand": "npm install",
	// Comment out to connect as root instead. More info: https://aka.ms/vscode-remote/containers/non-root.
	"remoteUser": "root",
	"features": {
		"ghcr.io/devcontainers/features/github-cli:1": {},
		"ghcr.io/devcontainers/features/docker-in-docker:1": {},
		"ghcr.io/devcontainers/features/git:1": {},
		"ghcr.io/devcontainers/features/go:1": {},
		"ghcr.io/devcontainers/features/node:1": {}
	}
}
 ```

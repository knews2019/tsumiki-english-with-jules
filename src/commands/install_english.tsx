import * as path from "node:path";
import { fileURLToPath } from "node:url";
import fs from "fs-extra";
import { Box, Newline, render, Text } from "ink";
import React, { useEffect, useState } from "react";

type InstallStatus =
  | "starting"
  | "checking"
  | "copying"
  | "completed"
  | "error";

const InstallComponent: React.FC = () => {
  const [status, setStatus] = useState<InstallStatus>("starting");
  const [copiedFiles, setCopiedFiles] = useState<string[]>([]);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const performInstall = async (): Promise<void> => {
      try {
        setStatus("checking");

        // Get the current directory
        const currentDir = process.cwd();
        const commandsTargetDir = path.join(currentDir, ".claude", "commands");
        const agentsTargetDir = path.join(currentDir, ".claude", "agents");

        // Get the tsumiki commands and agents directories
        const __filename = fileURLToPath(import.meta.url);
        const __dirname = path.dirname(__filename);
        // After build, refer to dist/commands and dist/agents (because cli.js is in dist/)
        const tsumikiCommandsDir = path.join(__dirname, "commands");
        const tsumikiAgentsDir = path.join(__dirname, "agents");

        // Create .claude/commands and .claude/agents directories if they don't exist
        await fs.ensureDir(commandsTargetDir);
        await fs.ensureDir(agentsTargetDir);

        setStatus("copying");

        // Get all .md and .sh files in the commands directory
        const commandFiles = await fs.readdir(tsumikiCommandsDir);
        const targetCommandFiles = commandFiles.filter(
          (file) => file.endsWith(".md") || file.endsWith(".sh"),
        );

        // Get all .md files in the agents directory
        let targetAgentFiles: string[] = [];
        try {
          const agentFiles = await fs.readdir(tsumikiAgentsDir);
          targetAgentFiles = agentFiles.filter((file) => file.endsWith(".md"));
        } catch {
          // Skip if the agents directory does not exist
        }

        const copiedFilesList: string[] = [];

        // Copy commands files
        for (const file of targetCommandFiles) {
          const sourcePath = path.join(tsumikiCommandsDir, file);
          const targetPath = path.join(commandsTargetDir, file);

          await fs.copy(sourcePath, targetPath);
          copiedFilesList.push(`commands/${file}`);
        }

        // Copy agents files
        for (const file of targetAgentFiles) {
          const sourcePath = path.join(tsumikiAgentsDir, file);
          const targetPath = path.join(agentsTargetDir, file);

          await fs.copy(sourcePath, targetPath);
          copiedFilesList.push(`agents/${file}`);
        }

        setCopiedFiles(copiedFilesList);
        setStatus("completed");

        // Exit after 2 seconds
        setTimeout(() => {
          process.exit(0);
        }, 2000);
      } catch (err) {
        const errorMessage =
          err instanceof Error ? err.message : "Unknown error occurred";
        setError(errorMessage);
        setStatus("error");

        setTimeout(() => {
          process.exit(1);
        }, 3000);
      }
    };

    performInstall();
  }, []);

  if (status === "starting") {
    return (
      <Box>
        <Text color="cyan">🚀 Starting Tsumiki installation...</Text>
      </Box>
    );
  }

  if (status === "checking") {
    return (
      <Box>
        <Text color="yellow">📋 Checking environment...</Text>
      </Box>
    );
  }

  if (status === "copying") {
    return (
      <Box>
        <Text color="blue">📝 Copying command templates...</Text>
      </Box>
    );
  }

  if (status === "error") {
    return (
      <Box flexDirection="column">
        <Text color="red">❌ An error occurred:</Text>
        <Text color="red">{error}</Text>
      </Box>
    );
  }

  if (status === "completed") {
    return (
      <Box flexDirection="column">
        <Text color="green">✅ Installation complete!</Text>
        <Newline />
        <Text>Copied files ({copiedFiles.length}):</Text>
        {copiedFiles.map((file) => (
          <Text key={file} color="gray">
            {" "}
            • {file}
          </Text>
        ))}
        <Newline />
        <Text color="cyan">
          You can use the commands in Claude Code like this:
        </Text>
        <Text color="white"> /tdd-requirements</Text>
        <Text color="white"> /kairo-design</Text>
        <Text color="white"> @agent-symbol-searcher</Text>
        <Text color="white"> ...</Text>
      </Box>
    );
  }

  return null;
};

export const installCommand = (): void => {
  render(React.createElement(InstallComponent));
};

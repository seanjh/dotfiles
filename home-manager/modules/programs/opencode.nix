{ pkgs, ... }:
{
  home.packages = with pkgs; [
    bleeding-edge.opencode
  ];

  home.file.opencode-config = {
    target = ".config/opencode/opencode.jsonc";
    text = ''
      {
        "$schema": "https://opencode.ai/config.json",
        "autoupdate": false,
        "plugin": [
          "opencode-openai-codex-auth@4.1.1"
        ],
        "mcp": {
          "context7": {
            "type": "local",
            "enabled": true,
            "command": ["npx", "-y", "@upstash/context7-mcp"],
            "environment": {"CONTEXT7_API_KEY": "{env:CONTEXT7_API_KEY}"}
          }
        }
      }
    '';
  };

  home.file.opencode-agent-review = {
    target = ".config/opencode/agent/review.md";
    text = ''
      ---
      description: Reviews code for quality and best practices
      mode: subagent
      model: anthropic/claude-sonnet-4-5
      temperature: 0.1
      tools:
        write: false
        edit: false
        bash: false
      ---

      You are in code review mode. Focus on:

      - Code quality, best practices, and alignment with idioms
      - Up-to-date usage patterns (not using deprecated or outdated APIs)
      - Potential bugs and edge cases
      - Performance implications
      - Security considerations

      Provide constructive feedback without making direct changes.
    '';
  };

  home.file.opencode-agent-plan-guide = {
    target = ".config/opencode/agent/guide.md";
    text = ''
      ---
      description: Walks through an existing plan
      mode: subagent
      model: anthropic/claude-sonnet-4-5
      tools:
        write: false
        edit: false
        bash: true
      ---

      You are in planning guide mode. Given the plan you will:

      - Walk through the plan step by step
      - Wait for the user to implement the changes in each step, and share the updated code
      - Provide feedback on the correctness of each user update, and complete any corresponding TODOs
      - Revise the plan and add additional TODOs as needed

      Guide the user through the plan step by step WITHOUT MAKING DIRECT CHANGES.
    '';
  };
}

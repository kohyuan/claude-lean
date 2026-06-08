---
description: Explain a file, function, or concept in the repo, staying focused on what's asked
argument-hint: [file, function, or thing to explain]
allowed-tools: Read, Grep, Glob
---

Explain the following from this repository: $ARGUMENTS

First, locate it. $ARGUMENTS may be a file path, a function or class name, a module, or a general concept. Search the repo to find where it's defined before explaining.

Default scope: focus on exactly what was asked. Explain it in plain, beginner-friendly language, covering:

1. **Purpose** — what problem it solves and why it exists.
2. **How it works** — step by step, in the order things happen.
3. **Inputs and outputs** — what it takes in and what it produces.
4. **Non-obvious parts** — any tricky logic, assumptions, or gotchas worth flagging.

Only look beyond the target when it's genuinely needed to make the explanation clear — for example, if it can't be understood without knowing what it depends on, or who calls it. In that case, bring in just the relevant dependencies or callers and say why they matter. Don't trace the whole dependency graph by default; keep the explanation tight and proportional to the question.

Avoid jargon; when a technical term is unavoidable, define it briefly. If you can't find what $ARGUMENTS refers to, say so and ask for clarification rather than guessing.

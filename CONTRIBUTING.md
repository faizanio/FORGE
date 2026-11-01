# Contributing to Forge

Thank you for your interest in contributing to **Forge**! Forge is an open-source reliability runtime and skill built to give AI coding agents strict engineering discipline.

---

## How to Contribute

1. **Bug Reports & Feature Ideas**:
   - Check existing issues to see if your topic is already under discussion.
   - If not, open a new issue describing the problem, reproduction steps, or the suggested enhancement.

2. **Extending Language Support**:
   - We currently focus on first-class support for **TypeScript** and **Python**.
   - If adding patterns or expanding validator discovery in `scripts/forge_verify.py`, ensure tests and fallback command chains are non-breaking.

3. **Submitting Changes**:
   - Fork the repository and create a descriptive feature branch:
     ```bash
     git checkout -b feature/my-new-rule
     ```
   - Follow the established formatting conventions across markdown documentation and python scripts.
   - Run verification checks locally:
     ```bash
     python3 -m py_compile skills/forge/scripts/*.py
     bash -n skills/forge/scripts/*.sh install.sh scripts/*.sh
     bash scripts/build-native-bundle.sh
     ```
   - Commit your changes with clear, concise messages.
   - Open a Pull Request targeting the `main` branch.

---

## Guidelines

- **Zero Tolerance for Hallucinated Completions**: Any new rules or checks added must produce deterministically verifiable output.
- **Maintain Progressive Disclosure**: Keep `SKILL.md` concise. Deep documentation belongs in `references/` or `resources/`.

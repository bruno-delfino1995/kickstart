# Kickstart Repository Guide

This repository uses [pyinfra](https://pyinfra.com/) to automate system configuration. It is a Python-based project that manages dotfiles, packages, and system settings.

## 🛠 Build, Lint, and Test

This project uses `uv` for dependency management.

- **Install Dependencies:**
  ```bash
  uv sync
  ```

- **Lint & Format:**
  The project uses `ruff` for linting and formatting.
  ```bash
  uv run ruff check .
  uv run ruff format .
  ```

- **Run/Deploy:**
  The main entry point is `deploy.py` using `inventory.py`.
  **Note:** You must have a `host_data/local.py` file configured (see `host_data/example.py`).
  
  To perform a dry-run (safe for testing changes):
  ```bash
  uv run pyinfra inventory.py deploy.py --dry
  ```

  To apply changes:
  ```bash
  uv run pyinfra inventory.py deploy.py
  ```

- **Testing:**
  There are currently no unit tests. Verification is done via `ruff` checks and `pyinfra` dry-runs to ensure configuration validity.

## 📝 Code Style & Conventions

### Python Guidelines
- **Version:** Python 3.12+
- **Formatting:** Strictly follow `ruff` defaults.
- **Type Hinting:** Use standard Python type hints (`typing` module) for function arguments and return values, especially in utility functions (see `inventory.py`).
- **Imports:** Group imports: Standard library first, then third-party (`pyinfra`, etc.), then local modules.

### Pyinfra Patterns
- **Entry Points:** `deploy.py` orchestrates the run, iterating over modules.
- **Roles vs Modules:**
  - `roles/`: Contains generic logic (`install.py`, `config.py`) that applies content from `modules/`.
  - `modules/`: Contains tool-specific configuration (e.g., `git`, `editor`).
- **Module Structure:**
  - Code: `modules/<name>/<os>.py` (e.g., `archlinux.py`) or `common.py`.
  - Config Files: 
    - `modules/<name>/<scope>/user/` -> Linked to User Home.
    - `modules/<name>/<scope>/system/` -> Copied to Root (`/`).
    - Scope is usually `common` or an OS name like `archlinux`.

### Creating New Modules
1. Create a directory `modules/<new_module>/`.
2. Add installation scripts (e.g., `archlinux.py` for Pacman packages) using `pyinfra.operations`.
3. Add configuration files in `common/user` (dotfiles) or `common/system` (etc files) if needed.
4. `roles/install.py` will automatically look for `common.py` and `<kind>.py` (OS-specific).
5. `roles/config.py` will automatically link/copy files from standard directory structures.

### Error Handling
- Use `try/except` blocks where dynamic imports or file operations might fail (e.g., loading host data).
- Fail fast if required directories (like a module path) are missing (see `deploy.py`).

### Naming
- **Variables:** `snake_case`.
- **Functions:** `snake_case`.
- **Files:** `snake_case.py`.
- **Host Data:** `host_data/<hostname>.py`.

## 🤖 Agent Instructions
- **Safety:** Always use `--dry` when running `pyinfra` commands unless explicitly instructed to apply changes.
- **Context:** Read `deploy.py` and `roles/config.py` to understand how files are mapped before creating new module structures.
- **Dependencies:** Do not introduce new pip dependencies without adding them to `pyproject.toml` via `uv add`.

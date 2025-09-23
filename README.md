### Installation

## Using Nix Flake
```
nix develop
uv run --with jupyter jupyter lab
```

## Using uv
```
uv sync
uv run ipython kernel install --user --env VIRTUAL_ENV $(pwd)/.venv --name=abalone
uv run --with jupyter jupyter lab
```

## Using pip
```
pip install .
pip install jupyterlab
jupyter lab
```


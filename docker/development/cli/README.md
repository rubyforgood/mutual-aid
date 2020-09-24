# Docker development CLI

A CLI app to interact with the local Dockerized development environment

**EXPERIMENTAL** - here be dragons. This is - at best - a sketch of how a dedicated CLI tool for interacting with the local locker development environment _might_ work. It is NOT complete, nor should it be considered a good idea.

## Usage

The `cli` binary produced by a`release` build is symlinked into the mutial-aid project root's `bin` directory and can be executed from the project root. For example, to see what this CLI can do, run the following:

```
cd <project-root>
bin/dev --help
```

## Development

### Prerequisites

- Rust, version described in the `<project-root>/docker/development/cli/.tool-versions` - if you use [asdf-vm](https://asdf-vm.com/#/) run `asdf install` from within the `<project-root>/docker/development/cli` directory.

### Updating the CLI

If you've made changes to the `cli` application and want to test them out, one can:

1. `cd <project-root>/docker/development/cli`
1. `cargo build --release`
1. `cd <project-root>`
1. `bin/dev <command>`

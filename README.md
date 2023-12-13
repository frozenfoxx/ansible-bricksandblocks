# ansible-bricksandblocks

[![Syntax](https://github.com/frozenfoxx/ansible-bricksandblocks/actions/workflows/syntax.yml/badge.svg)](https://github.com/frozenfoxx/ansible-bricksandblocks/actions/workflows/syntax.yml)

Ansible playbooks for BricksAndBlocks.

# Requirements

## Ansible Configuration

- `ANSIBLE_CONFIG` set to `[repo root]/ansible.cfg`

## Python

- `ansible`
- `netaddr`

# Configuration

* Add submodule for taskfiles and run setup task

```
git submodule add https://github.com/frozenfoxx/taskfiles.git .taskfiles
task setup
```

* Make a copy of `env.dist` called `.env`
* Fill in appropriate values for `.env`

# Usage

## Playbooks

To invoke a playbook, simply use the appropriate `task` command:

```
task ansible:playbook -- playbooks/[playbook name].yml
```

# Contribution

Pull requests welcome.

# ansible-bricksandblocks

[![Syntax](https://github.com/frozenfoxx/ansible-bricksandblocks/actions/workflows/syntax.yml/badge.svg)](https://github.com/frozenfoxx/ansible-bricksandblocks/actions/workflows/syntax.yml)

Ansible playbooks for BricksAndBlocks.

# Requirements

* [Ansible](https://ansible.com)
* [Ansible Galaxy](https://galaxy.ansible.com)
* [git](http://git-scm.com)
* [rclone](https://rclone.org)
* [Task](https://taskfile.dev)

# Configuration

* Make a copy of `env.dist` called `.env`
* Fill in appropriate values for `.env`
* Run update and setup tasks

```shell
task update
task setup
```

## Inventory in a Bucket

* If your `inventory` is set up in a remote bucket, you can clone it over the existing installation with:

```shell
task setup:rclone
```

# Usage

## Playbooks

To invoke a playbook, simply use the appropriate `task` command:

```
task ansible:playbook -- playbooks/[playbook name].yml
```

# Contribution

Pull requests welcome.

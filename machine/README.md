# Machine Setup

> Machine setup powered by [Ansible](https://www.ansible.com/)

## Usage

You're supposed to run this playbook after a [clean install](./Installation.md) of [Arch Linux](https://www.archlinux.org/) with some dependencies installed. If there's a missing base dependency you'll be properly instructed on how to install it.

You can clone this repository, check the default configuration at `group_vars/all.yml` and select only the ones you want in `host_vars/localhost.yml`. After you configure the variables to your preferences, all that's left is to run `./machine install`, which will install everything that I use on a daily basis.

## LICENSE

MIT © Bruno Delfino

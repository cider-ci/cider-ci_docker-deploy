
Ansible Git Checkout Role
=========================

The [Ansible git module](http://docs.ansible.com/git_module.html) can be
fragile in some cases. This role wraps and amends it to the end of being more
resilient. For example with respect to changes of the origin and handling of
submodules.


## Usage

    - role: git-checkout
      git_checkout_target_path: '/var/local/cider-ci'
      git_checkout_repo: "{{cider_ci_repo}}"
      git_checkout_version: "{{ lookup('pipe','cd  ./../. && git log -n 1 --format=%H') }}"


## Caveat

There are scenarios which are very hard to recover from. This role will fall
back to a fresh clone if it hits such a case. It will then also **wipe out the
existing clone including all unmanaged or changed files**!

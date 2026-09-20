# OnboardOps – RHEL 10 Provisioning Kit

## 1. Project Overview

OnboardOps is a RHEL 10 system administration project that demonstrates
user provisioning, group management, password policies, sudo access,
shared directory permissions, and persistent umask configuration.

The project is implemented on a RHEL 10 virtual machine.

---

## 2. Objectives

The project demonstrates:

- Creation and management of the `devteam` group
- Creation of three user accounts: `dev1`, `dev2`, and `dev3`
- Supplementary group membership
- Password aging and first-login password change
- Least-privilege sudo configuration
- SGID and sticky-bit directory permissions
- Group-writable files with restricted access to others
- Persistent umask configuration
- Verification using Linux administration commands

---

## 3. Users and Group

The project uses the following accounts:

| User | Primary Purpose | Supplementary Group |
|------|-----------------|---------------------|
| dev1 | Development user with sudo access | devteam |
| dev2 | Development user | devteam |
| dev3 | Development user | devteam |

The `devteam` group is used for controlled access to shared project
resources.

---

## 4. Password Policy

Each project user is configured with:

- Maximum password age: 60 days
- Password expiry warning: 7 days
- Password change required at first login

The configuration is verified using:

```bash
chage -l dev1
chage -l dev2
chage -l dev3

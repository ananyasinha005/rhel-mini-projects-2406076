#!/bin/bash

# OnboardOps Provisioning Script
# RHEL 10

set -e

echo "=== OnboardOps Provisioning Started ==="

# 1. Create devteam group if it does not exist
if ! getent group devteam >/dev/null; then
    groupadd devteam
fi

# 2. Create users and configure them
for user in dev1 dev2 dev3
do
    if ! id "$user" >/dev/null 2>&1; then
        useradd -m -s /bin/bash "$user"
    fi

    usermod -aG devteam "$user"

    # Password expires after 60 days
    # Warning begins 7 days before expiry
    # Force password change at first login
    chage -M 60 -W 7 -d 0 "$user"
done

# 3. Give full sudo access only to dev1
echo "dev1 ALL=(ALL) ALL" > /etc/sudoers.d/dev1
chmod 0440 /etc/sudoers.d/dev1

# Validate sudo configuration
visudo -c

# 4. Create shared project directory
mkdir -p /shared/project
chown root:devteam /shared/project

# SGID + Sticky bit + group access
chmod 3770 /shared/project

# 5. Configure persistent umask for devteam users
cat > /etc/profile.d/devteam-umask.sh <<'EOF'
if id -nG "$USER" 2>/dev/null | grep -qw devteam; then
    umask 0007
fi
EOF

chmod 644 /etc/profile.d/devteam-umask.sh

echo
echo "=== OnboardOps Provisioning Completed ==="
echo "Users: dev1, dev2, dev3"
echo "Group: devteam"
echo "Sudo user: dev1"
echo "Shared directory: /shared/project"
echo "Persistent umask: 0007"

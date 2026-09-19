#!/bin/bash

OUT="verification.txt"

{
echo "========================================"
echo "       ONBOARDOPS VERIFICATION"
echo "========================================"
echo

echo "1. USER AND GROUP VERIFICATION"
echo "----------------------------------------"
id dev1
id dev2
id dev3
echo

echo "2. SHARED DIRECTORY PERMISSIONS"
echo "----------------------------------------"
ls -ld /shared/project
echo

echo "3. SUDO VERIFICATION"
echo "----------------------------------------"
echo "dev1:"
sudo -l -U dev1
echo
echo "dev2:"
sudo -l -U dev2
echo
echo "dev3:"
sudo -l -U dev3
echo

echo "4. PASSWORD POLICY VERIFICATION"
echo "----------------------------------------"
echo "dev1:"
chage -l dev1
echo
echo "dev2:"
chage -l dev2
echo
echo "dev3:"
chage -l dev3
echo

echo "5. UMASK VERIFICATION"
echo "----------------------------------------"
echo "dev1:"
su - dev1 -c 'umask'
echo "dev2:"
su - dev2 -c 'umask'
echo "dev3:"
su - dev3 -c 'umask'
echo

echo "6. GROUP INHERITANCE AND FILE PERMISSIONS"
echo "----------------------------------------"
ls -la /shared/project
echo

echo "7. SELINUX STATUS"
echo "----------------------------------------"
getenforce
echo

echo "8. FIREWALL STATUS"
echo "----------------------------------------"
systemctl is-active firewalld
echo

echo "========================================"
echo "       VERIFICATION COMPLETE"
echo "========================================"

} > "$OUT"

echo "Verification saved to $OUT"

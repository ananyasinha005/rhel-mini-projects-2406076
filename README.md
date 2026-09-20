# DiskDetective — RHEL Storage Audit

## Objective
Perform a storage audit on RHEL, identify large and stale files, test hard and symbolic links, demonstrate Linux redirection and pipelines, and create a cold archive on a second disk.

## Storage Audit
The following commands were used:
- `lsblk` — identify available disks and partitions
- `df -h` — check filesystem usage
- `du` — identify directories using storage
- `find -size +100M` — identify files larger than 100 MB
- `find -mtime +180` — identify files older than 180 days
- `find -user dev1` — identify files owned by dev1

## Test Data
Controlled test files were created under `/data`:
- `final_cut_v3.mp4` — 150 MB
- `raw_footage_2024.mov` — 200 MB
- `old_project_backup.mov` — 300 days old
- `abandoned_edit.mp4` — 250 days old
- `recent_work.mp4` — 10 days old
- `dev1_project.mov` — owned by dev1

## Hard Link and Symbolic Link Test
A hard link and symbolic link were created for `testfile.txt`.

The hard link continued to work after the original file was deleted because it referenced the same inode.

The symbolic link failed after the original file was deleted because it referenced the original pathname.

## Redirection and Pipelines
The project demonstrated:
- `>` for output redirection
- `>>` for appending
- `|` for pipelines
- `tee` for writing and displaying output
- `sort` for sorting results
- `head` for limiting output
- `wc -l` for counting lines
- `2>/dev/null` for discarding error output

## Cold Archive
A second 2 GB disk `/dev/nvme0n2` was added to the RHEL VM.

It was formatted with ext4 and mounted at:

`/mnt/coldarchive`

Stale files older than 180 days were copied to the cold archive.

The mount was verified using `df -h` and `mount | grep coldarchive`.

## Safety
No system files were deleted during the audit. The stale-file search was used to identify candidates for archival, not automatic deletion.

SELinux and firewalld were not disabled.

## Deliverables
- `storage_audit.txt`
- `commands.txt`
- `README.md`
- `file_list.txt`

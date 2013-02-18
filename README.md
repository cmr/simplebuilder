simplebuilder
=============

A super simple shell script for building packages from the ABS.
Written because pacbuilder didn't do quite what I wanted it to.

Feed it packages (in the form of repo/name, corresponding to
`/var/abs/repo/name`) in stdin. I sometimes use it as follows:

```sh
yaourt -Q | awk '!/(aur|local)\// {print $1}' | bash simplebuilder.sh
```

Feel free to open an issue, send an email, or query `cmr` in freenode.

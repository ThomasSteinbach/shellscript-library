This script scans the computer for all Git repositories and allows the execution of `git status` and `git pull` on all of them.

Usage
-----

1. Call `./gm scan` to update the repositories database (as well whenever you have created / deleted repositories)
2. Call `./gm status` to get the status of all repositories from the database.
3. Call `./gm pull` to pull all changes from the remote locations of all repositories from the database.

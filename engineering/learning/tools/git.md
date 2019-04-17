For Paid Courses please speak with Mentors / Team leads as we may have copies available.

## Git:

- [http://rogerdudler.github.io/git-guide/](http://rogerdudler.github.io/git-guide/) - A simple guide to Git. It might not cover everything but this will get you 90% of the way there and it's super easy to read.
- [15 Minute Interactive Intro to Git from Github](https://try.github.io)
- [More in-depth look at Git](https://git-scm.com/book/en/v2)


# Basic Git Commands

This document intended to present the most straightforward but necessary Git commands, building your toolbelt with the necessary commands to start flying in your project.

Everyday helpful commands:

* [git-clone](#git-clone)
* [git-fetch](#git-fetch)
* [git-branch](#git-branch)
* [git-checkout](#git-checkout)
* [git-add](#git-add)
* [git-stash](#git-stash)
* [git-commit](#git-commit)
* [git-merge](#git-merge)
* [git-rebase](#git-rebase)
* [git-reset](#git-reset)
* [git-push](#git-push)
* [git-cherry-pick](#git-cherry-pick)


### git clone

This command is usually the initial step that everyone should take to start building something locally if the repository is already created available in the source control tool (GitHub, TFS, GitLab).
With this command, you’re saying to the remote location that you want to have a copy of that repository in your local machine, so it’s necessary to send

`git clone <remote> <url of your repo> <directory name>`

After the command runs successfully, you can open the directory and see all files cloned to your local machine.

The `-branch` argument lets you specify a specific a branch to clone instead of the branch the remote HEAD is pointing to, usually the master branch.

`git clone -branch <branch_name> <url of your repo>`


### git fetch

Fetch branches and/or tags from one or more other repositories, along with the objects necessary to complete their histories

`git fetch <remote>`

When no remote is specified, by default the `origin` remote will be used, unless there’s an upstream branch configured for the current branch.
Fetch only the specified branch from the specified remote.

`git fetch <remote> <branch>`

Fetch all branches from all remotes

`git fetch --all`


### git branch

Git is a version control system that uses the concept of branches, meaning that you can work locally and have remote codes in different versions and merge them when necessary.
With git branch, you can see, create or delete branches, local or remote ones.
To see all the branches you have locally, you can use:

`git branch`

Alternatively, to see all of them, even those in the remote repository, you can use:

`git branch --all`

Another approach that can be useful is to delete a branch.

`git branch <branch-name> -d`

If you’d like to delete it remotely too, add -r argument.


### git checkout

With git checkout, you can navigate on branches, create branches or even restore working tree files.
Said that you’re in the main branch and want to create the development branch, you can do it using:

`git checkout -b <branch-name>`

That way you’ll create a new branch, based in the branch you were, creating a branch based on it (master, in the past example), or you can specify which branch you want to branch off.

`git checkout -b <new-branch-name> <branch-from>`

Then, after the branch is already created, if you’d like to move from one branch to another, you can use:

`git checkout <branch-name>`

Alternatively, if you modified a file, but you don’t want those modifications anymore, you can use

`git checkout -- <file-name>`

 In summation, git checkout, when used on branches, alters the target of the HEAD ref. It can be used to create branches, switch branches, and checkout remote branches.


### git add

After you change some of the files you cloned and fetched, the git file versioning will understand this and add then a modified/added/deleted status, you can check that using:

`git status`

A list of these files will show up, and you can manually add them to your stage area, open the possibility to commit them:

`git add <filename>`

Alternatively, add all of them at once, using this command:

`git add --all`

stages new files and modifications, without deletions:

`git add .`

stages modifications and deletions, without new files:

`git add -u`


### git stash

Use `git stash` when you want to record the current state of the working directory and the index, but want to go back to a clean working directory. The command saves your local modifications away and reverts the working directory to match the `HEAD` commit.

`git stash`

The modifications stashed away by this command can be listed with

`git stash list`

inspected with

`git stash show`

and restored (potentially on top of a different commit) with

`git stash apply`

Old stashes are found in the reflog of this reference and can be named using the usual reflog syntax (e.g. `stash@{0}` is the most recently created stash, `stash@{1}`is the one before it). Stashes may also be referenced by specifying just the stash index (e.g., the integer `n` is equivalent to `stash@{n}`).

In case you want to remove a single stashed state from the stash lis, the latest one. i.e. `stash@{0}`, otherwise must be a valid stash log reference of the form stash@{}.

`git stash drop stash@{5}`

Finally, you may not want to clear all your stash tree, this command will remove all the stashed states. Note that those states will then be subject to pruning, and may be impossible to recover.

`git stash clear`


### git commit

The `git commit` command captures a snapshot of the project's currently staged changes.

A shortcut command that immediately creates a commit with a passed commit message.

`git commit -m "commit message"`

If multiple `-m` options are given, their values are concatenated as separate paragraphs.

`git commit -m "paragraph 1" -m "paragraph 2"`

Passing this option `--amend` will modify the last commit. Instead of creating a new commit, staged changes will be added to the previous commit.

`git commit  --amend`

So, in case you want to rename your last commit message, you can set the `-m` flag

`git commit --amend -m "This is a better commit message" -m "This is a better commit description"`


### git merge

Is the command you’ll need to join two or more development histories together. As we saw in the checkout command, you can have many branches and navigate through them. We tend to use one main branch that receives the code you did in one of your branches (feature, bug, hotfix), and after the job is done, you’ll need to merge this code back to the principal branch, so all the team stays with the latest code. Said that git merge would be necessary many times.
Imagine you were working in a side branch:

```
      A---B---C  topic
     /
    D---E---F---G    main
```

With git merge, you join your code with the main branch, like this:

```
        A---B---C    topic
       /         \
      D---E---F---G---H  main
```

If your current branch is main, to merge topic you need to do:

`git merge topic`

If any conflict is found, then your merge will be completed automatically. Otherwise, you will need to resolve the conflicts. The first step is to abort the merge so you can solve them.

`git merge --abort`

After that, you’ll need to fix the files and then run manually:

`git merge --continue`


### git rebase

Rebasing is the process of moving or combining a sequence of commits to a new base commit. Since Merge is always a forward moving change record, alternatively, rebase has powerful history rewriting features.

Assume the following history exists and the current branch is "topic":

```
          A---B---C topic
         /
    D---E---F---G master
```

From this point, the result of either of the following commands:

`git rebase master topic`

would be:

```
                  A'--B'--C' topic
                 /
    D---E---F---G master
```

Running git rebase with the `-i` flag begins an interactive rebasing session. Instead of blindly moving all of the commits to the new base, interactive rebasing gives you the opportunity to alter individual commits in the process. This lets you clean up history by removing, splitting, and altering an existing series of commits.

`git rebase --interactive master`

In case of conflict, git rebase will stop at the first problematic commit and leave conflict markers in the tree.
After resolving the conflict manually and updating the index with the desired resolution, you can continue the rebasing process with

`git rebase --continue`

OR, you can undo the git rebase with

`git rebase --abort`

### git reset

The `git reset` command is a complex and versatile tool for undoing changes. At a surface level, git reset is similar in behavior to git checkout. Where git checkout solely operates on the HEAD ref pointer, git reset will move the HEAD ref pointer and the current branch ref pointer.

When passed `--hard` The Commit History ref pointers are updated to the specified commit, this means any pending work that was hanging out in the Staging Index and Working Directory will be lost.

`git reset --hard`

You can also use this command to undo a commit, E.g. because you'd like to restructure it extensively - or even discard it altogether! Always keep in mind, however, that using the reset command undoes all commits that came after the one you returned to. `BE CAREFUL =)`:

`git reset --hard 0ad5a7a6`

 the flag `--mixed` is the default mode and the same effect as executing git reset.  The ref pointers are updated, and the Staging Index is reset to the state of the specified commit. Any changes that have been undone from the Staging Index are moved to the Working Directory.

 `git reset --mixed`

 When the `--soft` argument is passed, the ref pointers are updated and the reset stops there. The Staging Index and the Working Directory are left untouched.  A soft reset will only reset the Commit History. By default, git reset is invoked with HEAD as the target commit. Since our Commit History was already sitting on HEAD and we implicitly reset to HEAD nothing really happened.

  `git reset --soft`

 If you want to undo your last commit, but you want your changes in the staging area (before commit just like after git add) then do the following command.

 `git reset --soft HEAD^1`

 Now your committed files come into the staging area. Suppose if you want to upstage the files, because you need to edit some wrong content, then do the following command

 `git reset HEAD`


### git push

Push command usually is when you did some work and want to send it back to the remote server, instead of leaving it only locally. Can be used when you have a good portion of your job and don’t want to leave this code only in your machine and when you finished a task/feature and is about to close it.
So to push your branch, I’ll need to run:

`git push <name of your remote, normally origin> remote <your-branch-name>`

With that, all the code that you committed will be pushed to the remote server.

The `-all` flag will push all of your local branches to the specified remote.

`git push <remote> --all`

The `--force` flag makes the remote repository’s branch match your local one, deleting any upstream changes that may have occurred since you last pulled. Do not use the `--force` flag unless you’re absolutely sure you know what you’re doing.

`git push <remote> <remote_branch_name> --force`


### git cherry pick

Apply the changes introduced by some existing commits, recording a new commit for each. cherry-pick behaves just like merge.

`git cherry-pick <commit-ID>`

If git can’t apply the changes (e.g. you get merge conflicts), git leaves you to resolve the conflicts manually and make the commit yourself, resolve them by:

`git cherry-pick --continue`

If you want to bail of this step out altogether, just type:

`git cherry-pick --abort`

In some cases picking one single commit is not enough. You need, let’s say three consecutive commits. cherry-pick is not the right tool for this. rebase is.


# Everyday helpful tips
### GIT useful commands

Use `--global` to set the configuration for all projects. If git config is used without `--global` and run inside a project directory, the settings are set for the specific project.

`git config --global user.name "John Doe"`
`git config --global user.email "john@example.com"`

See your settings:

`git config --list`

Get help for a specific git command:

`git help clone`

View remote URLs:

`git remote -v`

Change origin url:

`git remote set-url origin http//github.com/repo.git`

Add remote:

`git remote add remote-name https://github.com/user/repo.git`

See differences between local changes and master:

`git diff origin/master`

See differences between two commits:

`git diff COMMIT1_ID COMMIT2_ID`

See the files that changed between two commits

`git diff --name-only COMMIT1_ID COMMIT2_ID`

See the files changed in a specific commit

`git show --pretty="format:" --name-only COMMIT_ID`

See recent commit history

`git log`

See commit history for the last two commits

`git log -2`

See commit history for the last two commits, with diff

`git log -p -2`

See commit history printed in single lines

`git log --pretty=oneline`

Revert one commit, push it

`git revert dd61ab21`
`git push origin master`

Undo the last commit, preserving local changes

`git reset --soft HEAD~1`

Undo the last commit, without preserving local changes

`git reset --hard HEAD~1`


### GIT Branching flow

 The idea is to give a clear, highly-focused purpose to each branch.

- `master` : We consider `origin/master` to be the main branch where the source code of HEAD always reflects a production-ready state.

- `develop` : We consider `origin/develop` to be the main branch where the source code of HEAD always reflects a state with the latest delivered development changes for the next release.

- `feature/branch-name` : The core idea behind the Feature Branch Workflow is that all feature development should take place in a dedicated branch instead of the master or development branches.

- `hotfix/branch-name` : Hotfix branches are very much like release branches in that they are also meant to prepare for a new production release. They arise from the necessity to act immediately upon an undesired state of a live production version. When a critical bug in a production version must be resolved immediately, a hotfix branch may be branched off from the corresponding tag on the master branch that marks the production version.

- `fix/branch-name` - for non production bugfixes

- `update/branch-name` - for updates that are not hotfixes, fixes or features
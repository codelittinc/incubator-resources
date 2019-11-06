# Some kind of Plan for Good Pull Requests

You're not the first person to create a pull request, and you won't be the last.
Let's make sure we're all creating pull requests easy to review, understand and more important, spot issues (after all this is one of the reasons why we do code reviews)

# Just get to the point

Rule of thumb:

1. Create a feature atomic pull request. One pull request should address one specific goal and not crazy long implementations.
2. A big implementation is made of a set of N small implementations
3. A pull request should not have more than 15 files

Example of how to Break down of a big feature into small prs

```
We want to create a user CRUD. It has controllers, models, and views.
``` 

To properly implement any feature, one of the best approaches is to build it from the ground up, from the most basic structures to the most complex ones. The most basic ones tend to be closer to being independent, while the most complex usually depends on the former.

1. We implement the definition and storage (model class, model tests, and migrations)
2. We implement the controllers (controller class, controller tests, services, and services tests)
3. We implement the views (presenter, presenter tests, views with HTML/CSS/js)

## What to do when we have breaking changes?

In some scenarios, we can't merge partial changes to the master branch because it may cause the application to break. An example is when we're refactoring a big feature. Thankfully we have a simple way to keep small PRs and still not break anything.

To do that, we will be creating an intermediary branch. The goal is to create a branch from the default branch and leave it clean. You will then create the PRs with your changes pointing to this clean branch instead of master. When all your PRs to this branch are merged, you can just create a PR from this branch to master. Example:

1. create a base branch from the repository's default branch (usually develop or master), let's call it `refactor/my-cool-refactor`
2. Work normally and make sure to create a branch with less than 15 files changed. It is okay if you have breaking changes, let's call it `refactor/replacing-this-with-that`
3. Now you create a PR from `refactor/replacing-this-with-that` to `refactor/my-cool-refactor`
4. You can then create all the PRs for this big change pointing to `refactor/my-cool-refactor`
5. After all the PRs to `refactor/my-cool-refactor` are done, you create a PR from `refactor/my-cool-refactor` to the default branch (usually develop or master)
6. done!

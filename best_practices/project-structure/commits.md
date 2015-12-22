# Some kind of Plan for Good Commit Messages

You're not the first person to use Git, and you won't be the last.
Let's make sure you're not notable for making poorly-formed, unexplainable
commits that not even you can understand!

Some wisdom from:

[Lullabot](https://www.lullabot.com/articles/git-best-practices-workflow-guidelines)  
[tbaggery](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)  <- Tim Pope, so pay attention!
[Seth Robertson](https://sethrobertson.github.io/GitBestPractices/)  
[Open Stack](https://wiki.openstack.org/wiki/GitCommitMessages)  
[Chris Beams](http://chris.beams.io/posts/git-commit/)  
[Thoughtbot](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message) 

If you read the above links, you'll notice that there are a number of similarities. Let's try to distill
their contents into a generic scaffolding that any of our projects may use.

Starting with Tim Pope's standard:

      Capitalized, short (50 chars or less) summary

      More detailed explanatory text, if necessary.  Wrap it to about 72
      characters or so.  In some contexts, the first line is treated as the
      subject of an email and the rest of the text as the body.  The blank
      line separating the summary from the body is critical (unless you omit
      the body entirely); tools like rebase can get confused if you run the
      two together.

      Write your commit message in the imperative: "Fix bug" and not "Fixed bug"
      or "Fixes bug."  This convention matches up with commit messages generated
      by commands like git merge and git revert.

      Further paragraphs come after blank lines.

      - Bullet points are okay, too

      - Typically a hyphen or asterisk is used for the bullet, followed by a
        single space, with blank lines in between, but conventions vary here

      - Use a hanging indent

That's a nice way to make commits, but it doesn't explain stuff _outside_ of actually
making a single commit. How often? What change needs a commit?

From Lullabot, above:

- Small, logical commits

Avoid monolithic commits, making them as small, modular and orthogonal as possible.

- Always review code before committing it

Particularly, using `git patch` functionality. (See article)

- Never rebase shared commits

For obvious reasons, people might get mad at you.

- Never delete unmerged remote branches

See above. But, look at that section in the webpage for a cool command.

One can view Seth Robertson's article for many of the same ideas (and much more!).

## Something, something, --force

Assimilating information from these, here is a prototypal Codelitt commit message standard:

Tim Pope's commit messages + Seth Robertson's workflow + Lullabot's commit review and orthogonality.

It sounds easy, but it's also probably pretty easy to mess up. Here's the plan:  

### Individual commits

1. Create your first line. It may not exceed 50 characters. It must be capitalized.
Make it in the present tense. Do not use the '-m' command, as you will not be able to 
produce additional lines of input.

2. Two newline characters later, Insert a link to any relevant Trello card that this commit came from.

3. Another two newline characters later, begin an explanatory paragraph which does not exceed
72 characters of width. It's okay to wrap to more lines. This paragraph should answer:  
  - Why is this change necessary?
  - How does it address the issue?
  - What side effects does this change have?

4. Add more paragraphs as is necessary.

5. Use a hyphen for bullet points that you might use. Separate bullets by two newline characters.

6. As with the above example, use a hanging indent.

### Lots of commits

1. Try to keep your commits separated with regards to their intent. Although
the Lullabot article dealt with Drupal, it is a good idea to modularize everything
as best you can. This means not bundling different modules together in commits.

2. Commit early, and commit often. Adding on to this, commit logically - you don't need a commit
after every line.

3. Be careful not to impede others' work, and be particularly cautious with `rebase` and `merge`.

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


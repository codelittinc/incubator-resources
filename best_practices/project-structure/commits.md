# Some kind of Plan for Good Commit Messages

You're not the first person to use Git, and you won't be the last.
Let's make sure you're not notable for making poorly-formed, unexplainable
commits that not even you can understand!

# Resources
Some wisdom from:

[AngularJS](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md#commit-message-format)
[Lullabot](https://www.lullabot.com/articles/git-best-practices-workflow-guidelines)  
[tbaggery](http://tbaggery.com/2008/04/19/a-note-about-git-commit-messages.html)  <- Tim Pope, so pay attention!  
[Seth Robertson](https://sethrobertson.github.io/GitBestPractices/)  
[Open Stack](https://wiki.openstack.org/wiki/GitCommitMessages)  
[Chris Beams](http://chris.beams.io/posts/git-commit/)  
[Thoughtbot](https://robots.thoughtbot.com/5-useful-tips-for-a-better-commit-message) 

If you read the above links, you'll notice that there are a number of similarities. Let's try to distill
their contents into a generic scaffolding that any of our projects may use.


# A Solid Starting Point

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

In addition, we will be modifying our subject lines to follow the Angular example above:  
`<type>(<scope>): <subject>`

[Here](https://github.com/angular/angular.js/blob/master/CONTRIBUTING.md#type) is a list of possible types, scopes and subjects.

# More than Once
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

1. Create your first line. It may not exceed 50 characters. It must be capitalized after the type, scope and subject.  
Make it in the present tense. Do not use the '-m' command, as you will not be able to produce additional lines of input.

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

# Examples

Here are some examples to help you understand what this workflow is like.
---

# Example 1 (Singular)
Let's say "Joe" is working on a project in laser communications software.
He found a way to increase throughput by improving an algorithm in the recombobulator module.
Nice! So, he goes over to `git`, and makes sure things are as they should be..

      Improve recombobulator module algorithm speed

      http://www.trello.com/xxxxxxxx

      The recombobulator's recombobulation algorithm is not functioning
      as fast as it can. By tuning the bupropion frequency to drop every
      other recombobuling, we can get twice the number of laser beams to
      move through the stasis chamber.

      We need as much throughput as possible, as we're already in the red
      as far as new recombobulators go. This will allow us to be far more
      efficient in our usage of recombobulators.

      There are a number of side effects that this change may have. For
      instance:
      
      - Antitheoretical energy sphere occurrences will increase.

      - Beta and gamma ray energy will decrease.

      - Lasers lasers lasers lasers lasers.

Why, Joe, you make excellent `git` commit messages! How nice of you.

# Example 2 (Intertwined Components)

Now, let's say Joe's co-worker, "Laura", also needs to make a commit (or two!).  

She's discovered that the core Higgs-Boson Generator software has a fatal bug  
that might cause a crash in the system at some point! So, she quickly devises  
a solution. However, she doesn't quite know how to structure her `git` commits.  
The problem is, the change that she needs to make in the Higgs-Boson Generator
also requires software in the Recombobulator and Neuman-force Pullifier to be 
modified! Oh, what is she to do?  

But, don't worry! We have our trusty principles of `orthogonality`, `early and
often commits`, and `not getting in the way`! (Laura is already good at individual
commits!)  
  
What she decides to do is separate each commit into code that affects one module
at a time:  

      fix(higgsCore) Slow Higgs-Boson Generator Impulse

      http://www.trello.com/yyyyyyyyy

      We thought the Higgs-Boson Generator would be able to sustain a full
      impulse load of energy, but our simulated test suite shows that this
      will eventually fail to be the case. However, the problem can be 
      solved for 10^29 years by reducing the impulse input to 3/4ths of
      our original projected load metric.

      There are side effects that will require modification of other vital
      modules:

      - The Recombobulator will need a modification to the phase shift 
      algorithm, since its resistance will increase quadratically with
      our reduction of Higgs-Boson impulse.

      - The Neuman-force Pullifier's output will be too low after this
      change, which means it will need to listen for gaps in space time
      to extract more energy from.

---

      fix(phaseRec) Improve phase shift algorithm

      http://www.trello.com/zzzzzzzzz

      Because the Higgs-Boson Generator's impulse load had to decrease,
      we need to alter the phase shift algorithm of the recombobulator
      to account for increased resistance. This will prevent an overload.

      There are no projected side effects of this operation.


---

      feat(neumanCore) Extract energy from space

      http://www.trello.com/aaaaaaaaa

      We are no longer receiving enough energy from the Higgs-Boson
      Generator, so we need to create a module that listens for gaps
      in the space time continuum, and extracts energy that might be
      present. We will then sustain normal levels for majority of
      operating periods.

      Side effects of this operation might include:

      - Aliens

      - Other dimensions

      - Interdimensional Aliens

Whew! You did good work, there, Laura!

That's all, for now. If you have any questions or comments about this document, be sure to drop us a message, raise an issue, or make a pull request!

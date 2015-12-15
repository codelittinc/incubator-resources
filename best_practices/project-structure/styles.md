# Plan to Prevent Insanity

At this point, you've probably been through this scenario:

- "Oh, I'll just add some styles here, and we'll define the project later."

- "Okay, this is getting a little difficult to navigate."

- "I don't know what's happening, but everything's exploding."

- "There's no possibility of meeting the deadline with all these spaghetti styles!"

You already know that there is a better way, so why are you continuing to be a creature of habit?

# It's all been done before

CSS has been around for a very long time. 

Assuming we never directly write it (CSS), and instead use an intelligent 
preprocessor such as SASS, LESS, or PostCSS (among countless others), 
we can learn from people who have already suffered for us (thanks!).

[The Sass Way][sassway] recommends a project structure like this:

    stylesheets/
    |
    |-- modules/              # Common modules
    |   |-- _all.scss         # Include to get all modules
    |   |-- _utility.scss     # Module name
    |   |-- _colors.scss      # Etc...
    |   ...
    |
    |-- partials/             # Partials
    |   |-- _base.sass        # imports for all mixins + global project variables
    |   |-- _buttons.scss     # buttons
    |   |-- _figures.scss     # figures
    |   |-- _grids.scss       # grids
    |   |-- _typography.scss  # typography
    |   |-- _reset.scss       # reset
    |   ...
    |
    |-- vendor/               # CSS or Sass from other projects
    |   |-- _colorpicker.scss
    |   |-- _jquery.ui.core.scss
    |   ...
    |
    `-- main.scss            # primary Sass file

The article itself is inspired by [SMACSS][smacss], and [Evernote][evernote]
has also derived inspiration from the influential material.

Here are some more resources to inspire your very own project structure:

[Airbnb][airbnb]'s internal guide
[rscss][rscss] (Reasonable System for CSS Stylesheet Structure)
[Github's Own CSS][githubcss]
[Codepen (Chris Coyier from CSSTricks)][codepen]

[This awesome Awesome list][awesomecss]

[sassway]: http://thesassway.com/beginner/how-to-structure-a-sass-project
[evernote]: https://github.com/evernote/sass-build-structure
[smacss]: https://smacss.com/book/
[airbnb]: https://github.com/airbnb/css
[rscss]: https://github.com/rstacruz/rscss
[githubcss]: http://markdotto.com/2014/07/23/githubs-css/
[codepen]: http://codepen.io/chriscoyier/post/codepens-css
[awesomecss]: https://github.com/sotayamashita/awesome-css

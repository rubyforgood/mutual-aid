(This is modified from our beloved [Ruby for Good](https://www.rubyforgood.org) guide.)

# We ♥ contributors!
By participating in this project, you agree to abide by the Ruby for Good [code of conduct](https://github.com/rubyforgood/code-of-conduct).

**First:** if you're unsure or afraid of *anything*, just ask or submit the issue or pull request anyways. You won't be yelled at for giving your best effort. The worst that can happen is that you'll be politely asked to change something. We appreciate any sort of contributions, and don't want a wall of rules to get in the way of that.

## Find issues to work on
We are using two GitHub 'Projects' for planning, providing two different perspectives on the same issues:

* [Roadmap](https://github.com/rubyforgood/mutual-aid/projects/4), a Kanban style board focussed on prioritization and workflow.
* [Story map](https://github.com/rubyforgood/mutual-aid/projects/2), a higher level overview and a good reference point of user flows (though it was last updated spring 2020 so is a bit out of date).

Feel free to browse issues and contact us (via Slack or issue comments) if anything is unclear.

## Claim an issue
Once you've identified something you'd like to work on, its best to comment on the issue and let maintainers know you're looking into it. That way, they can relay any context that might not be obvious or documented.

In any case, go ahead and 'Assign' yourself to the issue (if someone's already assigned, that is likely still fine, just reach out to them to start collaborating).

Once you start working on the issue in earnest, please move it into the 'In progress' column on the [Roadmap].

## Setup your development environment
See [SETUP.md](SETUP.md)

## Put together a Pull Request

Here are the basic steps to submit a pull request. Make sure that you're working on an [https://github.com/rubyforgood/mutual-aid/projects/4]–if the relevant issue doesn't exist, open it!

1. Fork the repo (if you've already been added as a contributor via Ruby for Good, you can skip this step).

1. Run the test suite (`bin/rake`). We only merge pull requests with a passing test suite, and it's great to know that you have a clean slate.

1. Add your code and tests as needed. If you are adding functionality or fixing a bug, you probably should add a test or many (if you're not sure how, comment and we might able to help)! See [TESTING.md](TESTING.md) for some testing tips relevant to this codebase.

1. Check the files that you added or changed with Rubocop, a ruby code linter: `bundle exec rubocop path/file1 path/file2`. You can add the `-a` option to fix some offenses automatically. Fix the others by hand until Rubocop reports no more offenses.

1. Run the test suite again (`bin/rake`)  to be sure everythng still works.

1. If you think mutual-aid groups using our app need to know about the changes you made, add an entry to the [CHANGELOG.md](CHANGELOG.md). Reviewing what's already in there will give you a sense of what types of changes need to be documented.

1. Push to your fork (or directly to rubyforgood/mutual-aid) and submit a pull request. Include the issue number (ex. `Resolves #1`) in the PR description.

1. For any changes, please create a feature branch and open a PR for it when you feel it's ready to merge. Even if there's no real disagreement about a PR, at least one other person on the team needs to look over a PR before merging. The purpose of this review requirement is to ensure shared knowledge of the app and its changes and to take advantage of the benefits of working together changes without any single person being a bottleneck to making progress.

At this point you're waiting on us–we'll try to respond to your PR quickly. We may suggest some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Use Rails idioms and helpers
* Include tests that fail without your code, and pass with it
* Update the documentation, the surrounding one, examples elsewhere, guides, whatever is affected by your contribution

## Lastly...
Bask in the glory that is you! ✨🙏🏾

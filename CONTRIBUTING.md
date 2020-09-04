## Contributing

(This is copied from our beloved [Ruby for Good]: https://www.rubyforgood.org)

We ♥ contributors! By participating in this project, you agree to abide by the Ruby for Good [code of conduct].

**First:** if you're unsure or afraid of *anything*, just ask or submit the issue or pull request anyways. You won't be yelled at for giving your best effort. The worst that can happen is that you'll be politely asked to change something. We appreciate any sort of contributions, and don't want a wall of rules to get in the way of that.

[code of conduct]: https://github.com/rubyforgood/code-of-conduct

We have two projects - [Roadmap](https://github.com/rubyforgood/mutual-aid/projects) and [Story map](https://github.com/rubyforgood/mutual-aid/projects/2). These cover the same list of github issues, but the [Roadmap](https://github.com/rubyforgood/mutual-aid/projects) focuses on prioritization of issues, whereas the [Story map](https://github.com/rubyforgood/mutual-aid/projects/2) is a higher level overview and a good reference point of user flows (tho it was last updated in spring 2020).

Here are the basic steps to submit a pull request. Make sure that you're working on an [https://github.com/rubyforgood/mutual-aid/projects/4]–if the relevant issue doesn't exist, open it!

1. Claim an issue on [our roadmap/issue tracker][https://github.com/rubyforgood/mutual-aid/projects/4] by assigning it to yourself (core team member) or commenting on it that you'd like to help and we can assign you. If the issue doesn't exist yet, open it.

2. Fork the repo. (If you've already been added as a contributor via Ruby for Good, you can skip this step.)

3. Run the test suite (`bin/rake`). We only take pull requests with a passing test suite, and it's great to know that you have a clean slate.

4. Add your code and tests as needed. If you are adding functionality or fixing a bug, you probably should add a test (if you're not sure how, comment and we might able to help)!

5. Check the files that you added or changed with Rubocop, a ruby code linter: `bundle exec rubocop path/file1 path/file2`. You can add the `-a` option to fix some offenses automatically. Fix the others by hand until Rubocop reports no more offenses.

6. Run the test suite again (`bin/rake`)  to be sure all tests pass.

7. Push to your fork (or directly to rubyforgood/mutual-aid) and submit a pull request. Include the issue number (ex. `Resolves #1`) in the PR description.

8. For any changes, please create a feature branch and open a PR for it when you feel it's ready to merge. Even if there's no real disagreement about a PR, at least one other person on the team needs to look over a PR before merging. The purpose of this review requirement is to ensure shared knowledge of the app and its changes and to take advantage of the benefits of working together changes without any single person being a bottleneck to making progress.

At this point you're waiting on us–we'll try to respond to your PR quickly. We may suggest some changes or improvements or alternatives.

Some things that will increase the chance that your pull request is accepted:

* Use Rails idioms and helpers
* Include tests that fail without your code, and pass with it
* Update the documentation, the surrounding one, examples elsewhere, guides, whatever is affected by your contribution

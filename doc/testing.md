## Running specs
Running `bin/test` will run our complete test suite including front-end, back-end and system specs.

To run each of these individully:

* Front end: `yarn test` or `yarn test -w` (to watch for changes and rerun)
* Back end: `bin/rspec` or `rerun bin/rspec spec/some/dir/or_spec.rb` (to watch for changes and rerun)
* System specs: `bin/rspec spec/system`. Can be run in-browser or with headless chrome. See `spec/rails_helper.rb`.

## Request specs
When writing rspec tests within the spec/request directory, you can use `Warden::Test:Helpers`
which give you access to the `login_as(user, :scope => :user)` method, as well as the `logout` method.
You use `FactoryBot.create(:user)` before the `login_as` method and pass it in as the required resource variable.

## Test app on heroku
We have a heroku install for testing!
[http://mutual-aid-demo.herokuapp.com/](http://mutual-aid-demo.herokuapp.com/)

* username: `testuser@example.com`
* password: `test with zest`

To deploy a WIP branch (not `main`):
```
git push <test-app-git-remote> <your-branch>:main
```

See [this guide](https://devcenter.heroku.com/articles/git) for how to set up heroku git remotes.


<sub>↩ Back to [README](/README.md)</sub>

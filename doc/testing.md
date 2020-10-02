## Running specs
Running `bin/test` will run ruby tests (rspec) and then the js tests (mocha) if all the rspec tests pass

To run front end tests and back end tests individually:

* Vue.js front end tests: `yarn test` or `yarn test -w` (mocha and chai are included in the `package.json` )
* Rails front end and back end tests: `bin/rspec` (rspec is included in the Gemfile)

Note that we currently rely on seeding in some of our backend specs, so before running `rspec`, first seed the test database:
```
bin/rake db:seed RAILS_ENV=test
```

## Request specs
When writing rspec tests within the spec/request directory, you can use `Warden::Test:Helpers`
which give you access to the `login_as(user, :scope => :user)` method, as well as the `logout` method.
You use `FactoryBot.create(:user)` before the `login_as` method and pass it in as the required resource variable.

BE SURE to include the line `after { Warden.test_reset! }` after the `before do` block with the `login_as` method within it. This prevents unexpected state data of the user from hanging around and causing errors.

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

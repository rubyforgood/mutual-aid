## Stack
* [Postgresql](https://www.postgresql.org/) database (or likely any RDBMS).
* [Rails](https://rubyonrails.org/) backend.
* Hybrid of mostly server-rendered static pages sprinkled with some [Vue](https://vuejs.org/) instances.
* [Devise](https://github.com/heartcombo/devise) and [Pundit](https://github.com/varvet/pundit) authentication and authorization
* [Blueprinter](https://github.com/procore/blueprinter) json serialization.
* [Bulma](https://bulma.io) css framework, with [Buefy](https://buefy.org) to integrate with Vue.
* [Webpacker](https://github.com/rails/webpacker) managing all assets, including stylesheets, images, etc.
* [Bundler](https://bundler.io/) and [Yarn (1.2)](https://yarnpkg.com/) package management.
* [RSpec](https://rspec.info/) unit, request and system specs.
* [Rubocop](https://github.com/rubocop/rubocop) linting based on our own [customizations](https://github.com/rubyforgood/mutual-aid/pull/935) on top of [StandardRB](https://github.com/testdouble/standard).
* [CircleCI](https://app.circleci.com/pipelines/github/rubyforgood/mutual-aid) for continuous automated linting and testing.
* Optional [Docker](https://www.docker.com/) based local [development](https://github.com/rubyforgood/mutual-aid/tree/main/bin/dev).

## Patterns on top of rails
We generally use rails norms and idioms, on top of which we've introduced a few supplemental patterns. These are not used in every possible case, but selectively where the code benefits from the additional abstractions, and when we've had time to refactor towards them.
* [Interactors](https://semaphoreci.com/community/tutorials/how-to-reduce-controller-bloat-with-interactors-in-ruby) using [ActiveInteraction](https://github.com/AaronLasseigne/active_interaction) to hold more complicated backend logic that doesn't belong in a model and would bloat a controller.
* [Presenters](https://github.com/rubyforgood/mutual-aid/pull/928#pullrequestreview-632650774) when the model and/or view contain too much logic.
* Nested resource composition and hydration using a [simplified Form](https://github.com/rubyforgood/mutual-aid/commit/6741565ffc265689f859e77932747f53e4c03051#diff-b29d1eb8e34d510b96985edf0d9211a2ad4f39df24e74adcbdc66c769db68547). This is a little bit like the FormObject pattern but with fewer responsibilities. Of the various uses [listed here](https://selleo.com/blog/essential-rubyonrails-patterns-form-objects), our implementation only addresses _Form Object as virtual resource_ and _Form Object as composed resource_. Note that we're repurposing the aforementioned ActiveInteraction gem in our forms, mostly because it provides some convenient coercions.

## Other architectural notes
* All our pages are server-rendered, but some include Vue instances. Some of these 'apps' take over small sections of the page (such as the NavBar) while others take over most of the page. The entry point into all Vue instances can be found in [this directory](https://github.com/rubyforgood/mutual-aid/tree/main/app/javascript/vue_instances), and here's [one example](https://github.com/rubyforgood/mutual-aid/blob/main/app/views/asks/new.html.erb#L24) of how an instance is included on an ERB template.
* Our [Contributions](http://mutual-aid-demo.herokuapp.com/contributions) page supports some complex filtering, the design of which is [described here](doc/structure-of-contribution-filters.md).


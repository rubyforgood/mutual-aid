# Structure for Filtering Contributions

Date: 2021-03-04

## Status

Proposed. Currently reflected in the code. Due to be revised soon

## Context

Our concept of sorting and filtering contributions has some non-obvious complexity. We also regularly get requests to make adjustments to filtering. I expect these change and feature requests will continue in ways that will be hard for us to anticipate in advance.

Additionally, we want to keep the Vue.js components nice and disjoint from the the Rails implementations. This allows people with Vue.js expertise to not have to learn Rails to help out and vice versa.

## Design

The `Browse.vue` page on the Javascript side and the `ContributionsController` on the Rails side are central objects that should have almost no responsibilites themselves outside of stitching the rest of the contribution filtering features together. Each side is responsible for formating the data it emits in ways easy for the other side to process: the JS code sends query parameters that are the same as what a Rails form would generate, and the Rails code responds only with JSON.

### JavaScript structure

The `Browse` page on the Vue side expects
* an initial list of `Contributions` to display
* a list of `FilterTypes` — the types of things we can use to filter the `Contributions`
* an optional list of initialFilters, which defaults to every option in the `Filtertypes`

The `Browse` page then delegates out to other components or objects the responsibilities for:
* displaying the types of filters and their various options in a useful way
* passing any user changes to the filters back to a Rails endpoint to receive an updated list of Contributions

### Rails structure

The `ContributionsController` relies on
* a list of classes that act as types of filters
* a `BrowseFilter` class that knows how to turn items selected from the types of filters and use them to query and filter items from the `Contributions` class
* a `ContributionBlueprint` class that:
    * turns the filtered list of contributions into the format the `Browse` page accepts
    * accepts some options that allow us to conditionally change what shows up (we expect this to help with user authorization features or system configuration features)

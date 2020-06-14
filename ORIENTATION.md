# Our history
We saw mutual aid groups for communities we are connected to -- and those across the US/world -- creating/sharing publicly-accessible spreadsheets of people asking for support that included lots of personally-identifying information including ways in which they’re vulnerable, identities, contact info, etc.

Also saw some of the more tech-savvy groups trying to use lots of tabs within spreadsheets to organize the firehose and complexity of data.

Initial groups: Antrim County & Grand Traverse Co. Michigan mutual aid groups. Also connecting to groups in Ithaca NY, Durham NC, and Washington DC, and beyond.

Antrim County & Grand Traverse, along with some other area groups are interested in a shared, multitenancy platform.

Initial workflow / UI concerns were started and shared with the groups on April 1, 2020 (wish this were all a joke). The demo, using Bootstrap, went over well. Next steps have included removing that demo code and flushing it out in VUE.js. 

We started off using a [Miro board](https://miro.com/app/board/o9J_kuKI5h8=/) for planning. (Contact us for access.). At this point we're trying to get better about using the Projects feature on Github, along w Github issues so contributors can see everything within the repo.

Our team community norm: timing is difficult for everyone given the current uncertainties of our world, so we should communicate clearly that any of us might, at any time, have to back out from things we were hoping to accomplish. As a community, we prefer open and early communication about such things, and we want to make sure nobody feels pressured because circumstances have changed in a way they did not anticipate.


# Priorities
## People

* The groups we’re working with are "people first," and believe strongly in not referring to users as "offerers" or "askers," but instead the idea of seeing the whole person and their membership in the community as priority.

## Holistic approach
* Existing platforms (e.g. marketplaces and even mutual aid specific ones) seem to focus on the listings feature exclusively, whereas we want to offer integration with mutual aid group operations (administration, pod mapping, resource sharing, fewer logins, central point of access granted/denied, etc)

## Features
* Most critical: creating, and/or viewing and filtering (and then a claiming mechanism) existing offers and asks
    * Nice to have would be an SMS text option (maybe with a chatbot?) for ppl without internet to still make requests
    * Option for multiple languages
* Site should ideally be whitelabelable so the mutual aid group is forefront, rather than a "user" themselves of a branded platform/product
* Tags
    * Categorization, which should match listing and community_resource categorization
    * Examples include: transportation, errands, money, housing, translation, etc
* Listings
    * Listings vs UserProfiles: there's some nuance here between "I'm willing to offer transportation," and, "I can give rides on April 12 from 2-4pm." And an additional level of complexity for recurring asks and/or offers.
    * Need a mechanism for publish_at, unpublish_at, claimed, etc
    * Need tools to aid with matching (either via dispatchers or peer-to-peer) so asks and offers don't become "ships passing in the night"
* Profiles
    * Can include what a person is offering (and maybe show ask categories to dispatchers and/or trusted volunteers who've received training)
    * Some feature for feedback, vouching, and accountability
    * People can make clear their boundaries wrt what they can offer and limits
    * Option to participate without a profile (maybe everyone gets a "profile" even if it's not visible -- or visible only to admins?)
    * Option to participate without a password/login (maybe use basic contact ID (email, phone number)?) (maybe everyone gets a "User" ?)
* Asks
    * Should be simple, humane, dignified
    * Option to request a dispatcher or some sort of facilitation
* Community resources list
    * Resources clearinghouse — with a review/approval mechanism
    * Examples include local diaper banks, food pantries, etc
* Pod/neighborhood
    * Pods are people in neighborhoods (or smaller geographically-based organizations) and possibly also their neighborhood distribution spots, like maybe a house that’s the drop-off/pickup spot and the neighborhood it serves
* Roles
    * Roles include things like: dispatcher, core team, community outreach, volunteer, etc
    * People can have many roles
    * Roles come with a set of permissions (?)
* Permissions features
    * Allow different permissions to pages, content, etc
* Inventory CRUD
* CommunicationLog CRUD
* News CRUD (trusted resources, daily digest)
* Announcement CRUD and/or DecisionLog CRUD
* Meetings & Attendance CRUD (?)
* Training/curriculum support
    * Simple CRUD w embedded YouTube and some written content and sequence
* Instance admin settings/options
    * Landing pages per mutual aid group sharing an instance to let people know this is about the aid organization
    * Tools for facilitators and organizations
    * Option to select peer-to-peer vs fully dispatched vs some combination
    * Import/export of listings, volunteers
* Bug reporting

# Current status
* Basic CRUD for Community resources
* Basic CRUD for offer and ask (one of those so far)
* Switch to Bulma CSS
* Landing page
    * A way for someone to see what’s available and jump into the workflow they care about the most
* Some tools to help people pick geographic scope stuff still pending
* Orientation page exists
    * Mostly with placeholders
    * Options might be: browse, ask, offer, research, share
* Pundit gem investigation
* Some VUE component placeholders created
* CI
* Initial README, CONTRIBUTING, code-of-conduct, LICENSE

# What’s next
* Outreach, dev team building, partnership with other groups
    * Code for America, Code for DC, Ruby for Good, Title Track, AHA
        * Concern: we don’t want to build the team into a mythical man month problem
    * Further research other platforms: sharetribe, freelygiving, mutualaidworld
* Waiting on more feedback from groups
    * Videos from dispatchers discussing their current workflow and timesinks
    * Workflow diagrams
* Planning:
    * The big request: help with automating match-making. One group is using a Slackbot!
    * Obfuscation of contact info -- perhaps CL model of email routing. 
    * Facilitated listings so that the people don't have direct contact as an optional thing they can have a facilitator handle instead
    * How to keep this all super lightweight so as to run fast on old chromebooks (No heavy photos.)
    * Options for anonymous users
    * Options for users where address and phone number are not required (but maybe a location that’s convenient and/or an intersection vs address)
    * Some request for messaging, which is potentially dangerous
    * Multiple language support
    * Document different pathways for implementation of peer-to-peer vs fully(or hybridly)-moderated submissions
* Import and export options
* A way for stakeholders to create issues and bug reports for their tech team to address and/or share with source code maintainers
* Some mapping features?
    * Tags and geographical flagging (neighborhoods) should be things that organizers can administrate
* ADA/accessibility review
* CI

* Roadmap for continuous deployment
    * Create a roadmap for work on above feature ideas
    * Pick a roadmap tool that gives us visibility
    * It’s important to have a tool that houses the tasks
    * And have visibility
    * And eventually tools to sort and organize the tasks

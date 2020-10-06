Changelog
=========
This codebase isn't able to strictly adhere to the [Semantic Versioning Specification](https://semver.org/) because it doesn't currenty declare a public API.

However, to support upgrade paths for mutual aid groups who've deployed the app, we will use common SemVer practices to communicate the impact of changes in each release.

We're still in the [initial development phase](https://www.jering.tech/articles/semantic-versioning-in-practice#initial-development-phase), so we are versioning releases with these modified rules:
* Major version (0.x.y) -> will remain at 0 until we're ready to release v1.
* Minor version (0.X.y) -> will be incremented to indicate a **breaking** change, something that will require some action on your part in order to upgrade.
* Patch version (0.x.Y) -> incremented whenever we release backward compatible changes, including new features, bugfixes etc.

This changelog also serves to acknowledge the incredible people who've contributed brilliance, effort and being. Their handles are listed under the first release they each  touched. 💗🙏🏾


## [0.3.0] - 2020-10-05
### Breaking changes
* The `SMTP_ADDRESS` environment variable has been renamed to `SMTP_HOST` #750
    - Existing deployed environments will have to be updated and restarted/redeployed

### Enhancements
* Rudimentary peer-to-peer exchange; users can initiate a match w/o dispatcher involvement #730, #741
* New map view on Contributions page that dynamically adds pins for Asks/Offers #720, #742
* Redesigned Landing page #626
* Redesigned Contributions page with collapsible filters section #728, #735, #747
* Allow expanded set of html tags for site customization (eg /about page) #683
* Ask|Offer form submissions now email the contributor and log the communication #758
* Admins can now toggle whether to show the Navigation bar on Community Resource and Announcement pages #691
* Add data migration task to separate old asks/offers into multiple listings #624
* Considerable improvements to readme and guides #669, #674, #675, #679, #682, #662, #688, #689, #746

### Bugfixes
* Get outgoing email working #660, #676
* User signup is now working (was previously blocked by #660), however has been disabled ↙️
* Disable user signup until we get authorizations working #767
* Fix long horizontal scroll of tag lists 615

### Development notes
* Moved repo under `rubyforgood` organization 💎❤️
* Switched primary branch from `master` to `main` #658
* Major improvements to our docker development setup #685, #700, #706, #722, #726, #740, #743, #746, #757, #760
* Added a pull request template #678, #733, #751
* Introduce `annotate` gem to help with schema discovery #686
* Support `asdf` tool manager #703, #762
* Drop `guard` support #749

### Appreciations 🙏🏾 💞
* @viamin
* @svileshina
* @slaloggia
* @reevesalic
* @pollygee
* @phylum
* @thestephenmarshall
* @maricris-sn
* @lucasfeijo
* @kevinschlabach
* @indiebrain
* @isabeltunguxd
* @gingeralbertson
* @grenewode
* @evertoncunha
* @eabousaif
* @danielmmack
* @craigjz
* @cflipse
* @acherukuri


## [0.2.9] - 2020-08-06
### Enhancements
* Ask/Offer form now generates a listing for each category selected #536, #620

### Bugfixes
* Ask/Offer form breaks when no custom questions are configured #621, #622


## [0.2.8] - 2020-08-02
### Bugfixes
* Remove final & operator so all nils -> 0.0  #618


## [0.2.7] - 2020-07-30
### Enhancements
* Display inexhaustible icon on Contributions, Matches, Respond #601
* Update Listings index layout to include buttons to get to Listing edit #604

### Bugfixes
* Fix bug where inexhaustible wasn't updating when edited on Triage page #604
* Add more terms to glossary #603
* Add Listings index to Contribution data section of Admin landing page #602


## [0.2.6] - 2020-07-25
### Enhancements
* Allow custom questions to be added to Ask and Offer forms #597


## [0.2.5] - 2020-07-24
### Bugfixes
* Only show visible subcategories for any visible category #594


## [0.2.4] - 2020-07-23
### Bugfixes
* Make login logo get populated from current_organization (last is_instance_owner) #581

### Enhancements
* Update submissions importer #577 & #579
* Add UI to upload submission responses for import #589, #585
* Improve tag_list checkbox UI #579
* Add +Listing buttons to Submission #578 #590
* Add node-version dotfile


## [0.2.3] - 2020-07-09
### Enhancements
* Improve contributions readability (remove labels, change prominence of created_at values). #558
* Nested Categories now display under their parent on index #570

### Bugfixes
* Font-awesome icons now load in more deployed environments. #479, #560, #566
* Tags are now displayed independently on Matches index (to fix nowrap issue) #565
* HTML-sanitization now works for custom landing (and about) page text #568
* Categories are now correctly ordered on forms #569
* Subcategories on Ask/Offer form weren't displaying their descriptions. #571

### Development notes
* All frontend assets are being served by webpack and sprockets has been removed 👋🏾🙏🏾! #566


## [0.2.2] - 2020-06-27
### Breaking changes
* If you were relying on the stock header/footer text on ask/offer forms, that text will need to be customized. #492

### Enhancements
* Customize header/footer text on ask/offer forms. #531, #492
* Rudimentary ansible support. #509
* Improve readme setup instructions. #513
* Improve people index layout. #523, #522
* Add inexhaustible to Listing. #542
* Remove profile & match buttons from Contributions page. #544
* Update listings index layout. #545

### Bugfixes
* Fix vue styles (add a stylesheet_pack_tag to include vue styles in prod). #524

### Development notes
* Consolidating dotenv files. #532
* Add release-it package. #534, #517

### Appreciations 🙏🏾 💞
* @compwron
* @bascibaran


## [0.2.1] - 2020-06-13
### Bugfixes
* Rename `CustomFormQuestion.name` scope to fix heroku build error


## [0.2] - 2020-06-13
*DEPRECATED*

### Enhancements
* Customize navbar logo w Organzation.current_organization.logo_url
* Add initial support for dockerized deployment #516

### Appreciations 🙏🏾 💞
* @SMores


## [0.1] - 2020-06-04
*DEPRECATED*

This is an MVP that provides ask and offer forms (that stop people from storing everyone's data in public spreadsheets), and provides a way to "match" people.
It's currently in "fully-moderated" mode, but we're working with a few groups to talk about what peer-to-peer could/should look like.
Has a bunch of CRM/admin tracking, etc, too.

### Appreciations 🙏🏾 💞
* @ry-dowd
* @padthaitofuhot
* @maebeale
* @h-m-m
* @harumhelmy
* @grenewode
* @exbinary
* @armahillo

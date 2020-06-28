# Changelog

## [0.2.2] - 2020-06-27

### Breaking changes
* #492 If you were relying on the stock header/footer text on ask/offer forms, that text will need to be customized.

### Enhancements
* #509 Rudimentary ansible support
* #513 Improve readme setup instructions
* #523 #522 Improve people index layout
* #531 #492 Customize header/footer text on ask/offer forms.
* #532 Consolidating dotenv files
* #534 #517 Add release-it package
* #542 Add inexhaustible to Listing
* #544 Remove profile & match buttons from Contributions page
* #545 Update listings index layout

### Bugfixes
* #524 Fix vue styles (Add a stylesheet_pack_tag to include vue styles in prod)

## [0.2.1] - 2020-06-13
### Bugfixes
* Rename `CustomFormQuestion.name` scope to fix heroku build error


## [0.2] - 2020-06-13
*DEPRECATED*

### Enhancements
* Customize navbar logo w Organzation.current_organization.logo_url


## [0.1] - 2020-06-04
*DEPRECATED*

This is an MVP that provides ask and offer forms (that stop people from storing everyone's data in public spreadsheets), and provides a way to "match" people.
It's currently in "fully-moderated" mode, but we're working with a few groups to talk about what peer-to-peer could/should look like.
Has a bunch of CRM/admin tracking, etc, too.

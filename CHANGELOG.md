# Changelog

## [0.2.4] - 2020-07-23
### Bugfixes
* Make login logo get populated from current_organization (last is_instance_owner) #581

### Enhancements
* Update submissions importer #577 & #579
* Add UI to upload submission responses for import #589, #585
* Improve tag_list checkbox UI #579
* Add +Listing buttons to Submission #578

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

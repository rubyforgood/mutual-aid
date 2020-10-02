[![CircleCI](https://circleci.com/gh/rubyforgood/mutual-aid/tree/main.svg?style=svg)](https://circleci.com/gh/rubyforgood/mutual-aid/tree/main)

**Welcome, and thanks for coming by! 👋🏾**

## What is mutual aid?
Mutual Aid is when people get together to build community by volunarily sharing resources with each other. Mutual Aid groups are more concerned about local resiliency than global campaigns, and prefer solidarity before charity. Mutual aid groups have existed around the world for over 200 years. Mutual aid groups generally prioritize the needs of minorities and other underserved communities.

To learn more about mutual aid, checkout this [list](https://bigdoorbrigade.wordpress.com/2017/01/31/what-do-we-mean-by-mutual-aid/) and [video](https://www.deanspade.net/2019/07/10/animated-video-about-mutual-aid/).

Many people working in mutual aid were overwhelmed by requests early this year due to the COVID pandemic. Some of these groups were relying on dispatchers to match up people who could help each other. These dispatchers were in turn relying on spreadsheets, and the spreadsheets grew to be unmanageable.

We've created an app to support this work, currently used by seven mutual aid groups in cities across the country.

Our current status is that dispatcher capacity is waning as local governments restart schools and lift pandemic bans. While we contiune to support the ongoing work of **dispatch-based** mutual aid, we're now building out a new **peer-to-peer** communication path that will ease reliance on dispatchers.

More (and snazzier!) details in this [project pitch deck](https://docs.google.com/presentation/d/1iUakTWYsj1tMAyOUO-1gp4oxNJzwGTFsZnkkDJk8Ax8/edit?usp=drive_web&ouid=109561030287749477812).

## Contribute!
We would love contributions from newbies, experienced devs, UX/UI designers and PM folks. We have standalone tickets that can be worked on fairly **independently**, as well as some that will need more **collaboration**.

Check out [this guide](doc/contributing.md) for how to get started.

If you have any questions and/or are having a hard time finding where or how to jump in to the project, please comment on an issue and we'll be in touch.

We look forward to your contributions and brilliance and being!

## Check out the demo
[http://mutual-aid-demo.herokuapp.com/](http://mutual-aid-demo.herokuapp.com/)

* username: `demouser@example.com`
* password: `doubly dreamy demo`

## Glossary
We wrote up a [Glossary of terms](http://mutual-aid-demo.herokuapp.com/admin/glossary)  that's available in the demo instance once you're logged in.
You can also review it [in code](app/views/admin/glossary.html.erb).

## Deploying the app
Visit our [deployment guide](doc/deployment.md) for more information on deploying the app.

## More guides and documentation
* [Contribution guide](doc/contributing.md)
* [Code of conduct](https://github.com/rubyforgood/code-of-conduct)
* [Releases and Changelog](https://github.com/rubyforgood/mutual-aid/releases)
* [Dev environment setup](doc/setup.md)
* [Seeding and importing data](doc/seeding.md)
* [Some testing tips](doc/testing.md)
* [Rudimentary ERD and workflow diagrams](db/db_diagram_yEd.graphml)
* Customization (WIP)

## Get involved in your local mutual aid efforts!
Mutual aid is not new. If it is new to you, please check out the history of mutual aid in your neighborhood or region, as likely you will find mentors and partners ready to accept your help. There are most likely leaders of color in your area. Please see if there are ways to support them before creating your own new network. There is also plenty of research to be done, and national and regional networks to connect in to.

Mutual aid groups are community groups that member-led, member-organized, and open to all to participate in.
Mutual aid participants work together to figure out strategies and resources to meet each others' needs, such as food, housing, medical care, and disaster relief.

Typically one member requests something and they are matched with a member who wishes to contribute that very thing.

In addition to the background links in the 'What is mutual aid?' section, here's a [good definition of a mutual aid network](https://www.idealist.org/en/days/what-is-a-mutual-aid-network).

Please, get involved! All of our communities could benefit from more resiliency and connection.

## Who we are
We are devs and organizers committed to making mutual aid manageable and longstanding, so as to build, support, and strengthen resilient communities.

This is not intended to be strictly a "product" -- we will be in partnership with specific mutual aid groups to solicit feedback and support their operations, with a nod to all mutual aid groups and administrative best practices.

The idea is that each group -- or cluster of groups -- would own their database and "instance" of this software, rather than there becoming one large/shared database (as is the case with products). This is to protect privacy, and to prioritize locality.

Ideally mutual aid networks will have their own tech teams, but we will provide initial support as capacity permits.

Feel free to browse [some of our earliest notes](doc/orientation.md).

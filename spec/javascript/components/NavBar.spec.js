import {createLocalVue, mount} from '@vue/test-utils'
import {configure} from 'vue_config'
import NavBar from 'components/NavBar'

describe('NavBar', () => {
  def('wrapper', () => mount(NavBar, {
    localVue: configure(createLocalVue()),
    propsData: {
      logoUrl: '/some-url',
      visibleButtons: $visibleButtons,
    },
  }))

  def('renderedNavItems', () => {
    const navLinks = $wrapper.findAll('a.navbar-item').wrappers
    const navButtons = $wrapper.findAll('.navbar-item a').wrappers
    const navForms = $wrapper.findAll('.navbar-item form').wrappers
    return [...navLinks, ...navButtons, ...navForms].map(link => link.text())
  })

  describe('visible buttons', () => {
    describe('when not instructed to show additional buttons', () => {
      def('visibleButtons', ['Login'])

      it('shows publicly accessible links', () => {
        assert.sameMembers($renderedNavItems, [
          '', // home
          'About',
          'Community Resources',
          'Announcements',
          'Login',
        ])
      })
    })

    describe('when instructed to show Contributions', () => {
      def('visibleButtons', ['Contributions', 'Login'])

      it('includes specified buttons', () => {
        assert.sameMembers($renderedNavItems, [
          '', // home
          'About',
          'Community Resources',
          'Announcements',
          'Contributions',
          'Login',
        ])
      })
    })

    describe('when instructed to show all admin buttons', () => {
      def('visibleButtons', ['Contributions', 'Matches', 'Admin', 'Feedback', 'Logout'])
      it('includes specified buttons', () => {
        assert.sameMembers($renderedNavItems, [
          '',
          'About',
          'Community Resources',
          'Announcements',
          'Contributions',
          'Matches',
          'Admin',
          'Feedback',
          'Logout',
        ])
      })
    })
  })
})


import {createLocalVue, mount} from '@vue/test-utils'
import {configure} from 'vue_config'
import NavBar from 'components/NavBar'

describe('NavBar', () => {
  def('wrapper', () => mount(NavBar, {
    localVue: configure(createLocalVue()),
    propsData: {
      loggedIn:   $loggedIn,
      logoUrl:    '/some-url',
      p2pEnabled: $p2pEnabled,
    },
  }))

  def('renderedNavItems', () => {
    const navLinks = $wrapper.findAll('a.navbar-item').wrappers
    const navButtons = $wrapper.findAll('.navbar-item a').wrappers
    const navForms = $wrapper.findAll('.navbar-item form').wrappers
    return [...navLinks, ...navButtons, ...navForms].map(link => link.text())
  })

  describe('when not logged in', () => {
    def('loggedIn', false)

    describe('when p2p is not enabled', () => {
      def('p2pEnabled', false)

      it('shows publicly accessible links except Contributions', () => {
        assert.sameMembers($renderedNavItems, [
          '', // home
          'About',
          'Community Resources',
          'Announcements',
          'Login',
        ])
      })
    })

    describe('when p2p is enabled', () => {
      def('p2pEnabled', true)

      it('also includes Contributions', () => {
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
  })

  describe('when logged in', () => {
    def('loggedIn', true)

    it('includes admin links', () => {
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


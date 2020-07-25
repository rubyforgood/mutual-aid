import {configure} from 'vue_config'
import {createLocalVue, mount} from '@vue/test-utils'
import {CustomQuestions} from 'components/forms'

describe('CategoryFields', () => {
  def('wrapper', () => {
    return mount(CustomQuestions, {
      localVue: configure(createLocalVue()),
      propsData: {
        fieldNamePrefix: 'submission[responses]',
        questions: $questions,
      },
    })
  })

  def('questions', () => {
    return [
      {id: 1, name: 'got one?'},
      {id: 2, name: 'got two?'},
    ]
  })

  it('renders input fields for each question', () => {
    assert.equal($wrapper.get('label[for="submission[responses][1]"]').text(), 'got one?')
    assert($wrapper.contains('input[name="submission[responses][1]"]'))

    assert.equal($wrapper.get('label[for="submission[responses][2]"]').text(), 'got two?')
    assert($wrapper.contains('input[name="submission[responses][2]"]'))
  })

  describe('when there are no custom questions', () => {
    def('questions', () => [])

    it('does not fail', () => {
      assert.doesNotThrow(() => $wrapper)
    })
  })
})

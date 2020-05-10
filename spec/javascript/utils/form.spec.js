import {partial} from 'utils/function'
import {fieldNameWithPrefix} from 'utils/form'

describe('form utils', () => {
  describe('fieldNameWithPrefix', () => {
    describe('without a prefix', () => {
      it('returns the field name given', () => {
        assert.equal(fieldNameWithPrefix(null, 'field'), 'field')
        assert.equal(fieldNameWithPrefix('',   'field'), 'field')
      })
    })

    describe('with a prefix', () => {
      def('withPrefix', () => partial(fieldNameWithPrefix, 'prefix'))

      it('returns the field with a rails style prefix', () => {
        assert.equal($withPrefix('field'), 'prefix[field]')
      })

      describe('an array field', () => {
        it('correctly appends the bracket', () => {
          assert.equal($withPrefix('arrayField[]'), 'prefix[arrayField][]')
        })
      })
    })
  })
})

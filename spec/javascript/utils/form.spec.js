import {composeFieldName} from 'utils/form'

describe('form utils', () => {
  describe('composeFieldName', () => {
    it('returns the field with a rails style prefix', () => {
      assert.equal(composeFieldName('prefix', 'field'), 'prefix[field]')
    })

    it('appends all segments given', () => {
      assert.equal(composeFieldName('prefix', 'two', 'segments'), 'prefix[two][segments]')
    })

    it('understands an array signifier', () => {
      assert.equal(composeFieldName('prefix', 'arrayField', '[]'), 'prefix[arrayField][]')
    })

    it('ignores a missing prefix and combines other segments given', () => {
      assert.equal(composeFieldName(null, 'field'), 'field')
      assert.equal(composeFieldName('',   'one', 'two'), 'one[two]')
    })
  })
})

import { assert } from 'chai'
import ListingDataAdapter from 'pages/browse/ListingDataAdapter'

describe('ListingDataAdapter', function () {
  it('category_for returns an appropriate default object if the category is not found', function () {
    const adapter = new ListingDataAdapter({categories: []})
    const test_id = 100
    const blank_category = adapter.category_for(test_id)
    assert.equal(blank_category.id, test_id)
    assert.equal(blank_category.name, 'Unknown')
  })
})

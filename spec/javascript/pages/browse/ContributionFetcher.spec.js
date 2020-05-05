import ContributionFetcher from 'pages/browse/ContributionFetcher'
import sinon from 'sinon'

describe('ContributionFetcher', function () {
  def('path', () => '/contributions.json?')
  def('mockResponse', () => ({json: () => [{id: 1, results: 'expected'}]}))
  def('fetchSpy', () => sinon.spy(async () => $mockResponse))

  it('fetches an update from a given URL path with reasonable parameters', async function () {
    const givenArgs = ['urgency[0]', 'location[1]', 'location[2]']
    const expectedArgs = 'urgency[0]=1&location[1]=1&location[2]=1'

    const subject = new ContributionFetcher($path, $fetchSpy)
    const result = await subject.fetch(givenArgs)

    assert.isTrue($fetchSpy.calledOnce)
    assert.deepEqual([$path + expectedArgs], $fetchSpy.firstCall.args)
    assert.deepEqual(result, {data: $mockResponse.json()})
  })

  it('fetches without parameters when given an empty list', async function () {
    const subject = new ContributionFetcher($path, $fetchSpy)
    await subject.fetch([])
    assert.isTrue($fetchSpy.calledOnce)
    assert.deepEqual([$path], $fetchSpy.firstCall.args)
  })

  describe('given a bad fetch response', function () {
    def('failingFetch', () => async () => undefined)
    def('subject', () => new ContributionFetcher($path, $failingFetch))

    it('returns an error', async function () {
      const result = await $subject.fetch([])
      assert.equal(result.error.message, "Cannot read property 'json' of undefined")
    })

    it('returns the provided fallback data', async function () {
      const fallback = [
        {id: 1, name: 'fallback[1]'},
        {id: 2, name: 'fallback[2]'},
      ]
      const result = await $subject.fetch([], fallback)
      assert.deepEqual(result.data, fallback)
    })
  })
})

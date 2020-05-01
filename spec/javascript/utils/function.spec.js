import {partial} from 'utils/function'

describe('function utils', () => {
  describe('partial', () => {
    function divideBy(denominator, numerator) {
      return numerator / denominator
    }

    function sum(...numbers) {
      return numbers.reduce((total, number) => total + number)
    }

    it('works on a function with two arguments', () => {
      const divideBy3 = partial(divideBy, 3)
      assert.equal(divideBy3(27), 9)
    })

    it('works on a function with many arguments', () => {
      const oneAndTwoAnd = partial(sum, 1, 2)
      assert.equal(oneAndTwoAnd(3, 4), 10)
    })
  })
})

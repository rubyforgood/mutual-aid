export function partial(fn, ...left) {
  return (...right) => fn(...left, ...right)
}

export function capitalize(string) {
  if (!string) return ''
  return string.charAt(0).toUpperCase() + string.slice(1)
}

export function replace(string, target, replacement) {
  if (!string) return ''
  return string.replace(target, replacement)
}

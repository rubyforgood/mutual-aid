export function fieldNameWithPrefix(prefix, name) {
  if (!prefix || !prefix.length) return name

  return name.endsWith('[]')
    ? `${prefix}[${name.slice(0, -2)}][]`
    : `${prefix}[${name}]`
}

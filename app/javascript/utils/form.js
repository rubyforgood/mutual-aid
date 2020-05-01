export function fieldNameWithPrefix(prefix, name) {
  return prefix && prefix.length ? `${prefix}[${name}]` : name
}

export function composeFieldName(preceding, current, ...subsequent) {
  if (!current) return preceding

  if (preceding && preceding.length) {
    const combined =
      current === '[]' ?
      `${preceding}[]` :
      `${preceding}[${current}]`

    return composeFieldName(combined, ...subsequent)
  }
  else {
    return composeFieldName(current, ...subsequent)
  }
}

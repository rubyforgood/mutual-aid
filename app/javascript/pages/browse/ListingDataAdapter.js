export default class {
  constructor(options) {
    this.categories = options.categories || []
    this.locations = options.locations || []
  }
  category_for(id) {
    return this.categories.find((c) => c.id == id) || {id: id, name: 'Unknown'}
  }
  location_for(id) {
    return this.locations.find((c) => c.id == id) || {id: id, name: 'Unknown'}
  }
}

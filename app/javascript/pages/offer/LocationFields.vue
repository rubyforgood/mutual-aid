<template>
  <div>
    <b-field :label-for="withPrefix('street_address')" label="Street address">
      <b-input :name="withPrefix('street_address')" :value="street_address" />
    </b-field>

    <!-- TODO: remove this with the DB constraint on state and replace with `type` (maybe in the controller?) -->
    <b-input :name="withPrefix('state')" type="hidden" value="MI" />
  </div>
</template>

<script>
import {partial} from 'utils/function'
import {fieldNameWithPrefix} from 'utils/form'

export default {
  props: {
    fieldNamePrefix: String,
    street_address: String,
  },
  created: function() {
    // TODO: tiny bit of duplication with partial+fieldNameWithPrefix
    this.withPrefix = partial(fieldNameWithPrefix, this.fieldNamePrefix)
  },
}
</script>

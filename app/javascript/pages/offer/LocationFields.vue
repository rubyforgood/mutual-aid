<template>
  <div>
    <b-field :label-for="withPrefix('street_address')" label="Street address">
      <b-input :name="withPrefix('street_address')" :value="street_address" />
    </b-field>

    <!-- TODO: replace this with a dropdown -->
    <b-input :name="withPrefix('location_type')" type="hidden" value="1" />
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

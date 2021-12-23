<template>
  <div>
    <b-field
      :label-for="fieldName('street_address')"
      label="Street address"
      custom-class="is-medium"
    >
      <b-input :name="fieldName('street_address')" v-model="streetAddress" />
    </b-field>

    <b-field
      v-if="streetAddress.length"
      :label-for="fieldName('location_type')"
      label="Address type"
      custom-class="required-field is-medium"
    >
      <b-select
        :name="fieldName('location_type')"
        :value="location_type.id"
        placeholder="Type"
        required
      >
        <option v-for="{id, name} in location_types" :key="id" :value="id" >
          {{ name | replace('_', ' ') | capitalize }}
        </option>
      </b-select>
    </b-field>
  </div>
</template>

<script>
import {partial} from 'utils/function'
import {capitalize, replace} from 'utils/string'
import {composeFieldName} from 'utils/form'

export default {
  props: {
    fieldNamePrefix: String,
    location_types:  Array,
    location_type:   {type: Object, default: () => { return {} }},
    street_address:  {type: String, default: ''},
  },
  data() {
    return {
      streetAddress: this.street_address,
    }
  },
  created: function() {
    this.fieldName = partial(composeFieldName, this.fieldNamePrefix)
  },
  filters: {
    capitalize,
    replace
  },
}
</script>

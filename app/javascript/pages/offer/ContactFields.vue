<template>
  <div>
    <b-field
      :label-for="withPrefix('preferred_contact_type')"
      label="Best way to contact you"
      custom-class="required-field"
    >
      <b-select
        :name="withPrefix('preferred_contact_type')"
        :value="preferredContactTypeKey"
        @input="$emit('updated', 'preferred_contact_type', $event)"
        placeholder="Select …"
        required
      >
        <option v-for="type in contactTypes" :key="type.key" :value="type.key" >
          {{ type.key }}
        </option>
      </b-select>
    </b-field>

    <b-field
      v-for="(fieldLabel, fieldName) in contactTypesByUniqueField"
      :key="fieldName"
      :label="fieldLabel"
      :label-for="withPrefix(fieldName)"
      :custom-class="isPreferred(fieldName) ? 'required-field' : ''"
    >
      <b-input
        :name="withPrefix(fieldName)"
        :value="contactFields[fieldName]"
        :required="isPreferred(fieldName)"
        @input="$emit('updated', fieldName, $event)"
      />
    </b-field>
  </div>
</template>

<script>
import {partial} from 'utils/function'
import {fieldNameWithPrefix} from 'utils/form'

export default {
  props: {
    contactFields: Object,
    contactTypes: Array,
    fieldNamePrefix: {type: String, default: ''},
    preferredContactTypeKey: {String, default: null},
  },
  computed: {
    preferredContactType() {
      return this.contactTypes.find(type => type.key === this.preferredContactTypeKey)
    },
    contactTypesByUniqueField() {
      return this.contactTypes.reduce((uniq, {fieldName, fieldLabel}) => {
        uniq[fieldName] = fieldLabel
        return uniq
      }, {})
    },
  },
  methods: {
    isPreferred(fieldName) {
      return this.preferredContactType && this.preferredContactType.fieldName === fieldName
    },
  },
  created: function() {
    this.withPrefix = partial(fieldNameWithPrefix, this.fieldNamePrefix)
  },
}
</script>

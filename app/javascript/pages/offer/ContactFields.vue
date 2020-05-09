<template>
  <div>
    <b-field
      :label-for="withPrefix('preferred_contact_method')"
      label="Best way to contact you"
      custom-class="required-field"
    >
      <b-select
        :name="withPrefix('preferred_contact_method')"
        :value="preferredContactMethodId"
        @input="$emit('preference-changed', $event)"
        placeholder="Select …"
        required
      >
        <option v-for="method in contactMethods" :key="method.id" :value="method.id" >
          {{ method.name }}
        </option>
      </b-select>
    </b-field>

    <b-field
      v-for="(fieldLabel, fieldName) in contactMethodsByUniqueField"
      :key="fieldName"
      :label="fieldLabel"
      :label-for="withPrefix(fieldName)"
      :custom-class="isPreferred(fieldName) ? 'required-field' : ''"
    >
      <b-input
        :name="withPrefix(fieldName)"
        :value="contactFields[fieldName]"
        :required="isPreferred(fieldName)"
        @input="$emit('field-changed', fieldName, $event)"
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
    contactMethods: Array,
    fieldNamePrefix: {type: String, default: ''},
    preferredContactMethodId: {String, default: null},
  },
  computed: {
    preferredContactMethod() {
      return this.contactMethods.find(method => method.id === this.preferredContactMethodId)
    },
    contactMethodsByUniqueField() {
      return this.contactMethods.reduce((uniq, {field_name, field_label}) => {
        uniq[field_name] = field_label
        return uniq
      }, {})
    },
  },
  methods: {
    isPreferred(fieldName) {
      return this.preferredContactMethod && this.preferredContactMethod.field_name === fieldName
    },
  },
  created: function() {
    this.withPrefix = partial(fieldNameWithPrefix, this.fieldNamePrefix)
  },
}
</script>

<template>
  <div>
    <b-field
      :label-for="withPrefix('preferred_contact_method')"
      label="Best way to contact you"
      custom-class="required-field is-medium"
    >
      <b-select
        :name="withPrefix('preferred_contact_method')"
        v-model="preferredContactMethodId"
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
      :custom-class="fieldCustomClasses(fieldName)"
    >
      <b-input
        :name="withPrefix(fieldName)"
        :value="person[fieldName]"
        :required="isPreferred(fieldName)"
      />
    </b-field>
  </div>
</template>

<script>
import {partial} from 'utils/function'
import {composeFieldName} from 'utils/form'

export default {
  props: {
    person: Object,
    contactMethods: Array,
    fieldNamePrefix: {type: String, default: ''},
  },
  data() {
    const preference = this.person.preferred_contact_method
    return {
      preferredContactMethodId: preference ? preference.id : null,
      withPrefix: partial(composeFieldName, this.fieldNamePrefix),
    }
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
    fieldCustomClasses(fieldName) {
      const classes = ['is-medium']
      if (this.isPreferred(fieldName)) classes.push('required-field')
      return classes.join(' ')
    }
  },
}
</script>

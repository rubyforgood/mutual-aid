<template>
  <div>
    <b-field
      label="Best way to contact you"
      custom-class="required-field"
    >
      <b-select v-model="person.preferred_contact_type" required>
        <option
          v-for="type in contactTypes"
          :key="type.key"
          :value="type.key"
        >
          {{ type.key }}
        </option>
      </b-select>
    </b-field>

    <b-field
      v-for="(label, field) in uniqueContactFields"
      :label="label"
      :custom-class="isPreferred(field) ? 'required-field' : ''"
    >
      <b-input
        v-model="person[field]"
        :required="isPreferred(field)"
      />
    </b-field>
  </div>
</template>

<script>
// TODO: don't mutate data -- need some state management solution here
export default {
  props: {
    person: Object,
    contactTypes: Array,
  },
  computed: {
    preferredContactType() {
      return this.contactTypes.find(type => type.key === this.person.preferred_contact_type)
    },
    uniqueContactFields() {
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
}
</script>

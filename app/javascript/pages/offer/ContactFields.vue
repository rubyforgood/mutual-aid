<template>
  <div>
    <b-field
      label="Best way to contact you"
      label-for="preferred_contact_type"
      custom-class="required-field"
    >
      <b-select
        v-model="preferred_contact_type"
        name="preferred_contact_type"
        placeholder="Select …"
        required
      >
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
      :key="field"
      :label="label"
      :label-for="field"
      :custom-class="isPreferred(field) ? 'required-field' : ''"
    >
      <b-input
        v-model="person[field]"
        :required="isPreferred(field)"
        :name="field"
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
  data() {
    return {
      // TODO: need to propogate this, and other writes into person
      preferred_contact_type: null,
    }
  },
  computed: {
    preferredContactType() {
      return this.contactTypes.find(type => type.key === this.preferred_contact_type)
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

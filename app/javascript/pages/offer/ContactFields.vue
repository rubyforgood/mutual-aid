<template>
  <div>
    <b-field
      label="Best way to contact you"
      label-for="preferred_contact_type"
      custom-class="required-field"
    >
      <b-select
        :value="preferredContactTypeKey"
        @input="$emit('updated', 'preferred_contact_type', $event)"
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
      v-for="(fieldLabel, fieldName) in contactTypesByUniqueField"
      :key="fieldName"
      :label="fieldLabel"
      :label-for="fieldName"
      :custom-class="isPreferred(fieldName) ? 'required-field' : ''"
    >
      <b-input
        :value="contactFields[fieldName]"
        :required="isPreferred(fieldName)"
        :name="fieldName"
        @input="$emit('updated', fieldName, $event)"
      />
    </b-field>
  </div>
</template>

<script>
export default {
  props: {
    preferredContactTypeKey: String,
    contactFields: Object,
    contactTypes: Array,
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
}
</script>

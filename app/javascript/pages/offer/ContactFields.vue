<template>
  <div>
    <div class="columns">
      <b-field class="column is-narrow" label="Best way to contact you" custom-class="required-field">
        <b-select v-model="preferredKey">
          <option v-for="type in contactTypes" :key="type.key" :value="type.key">
            {{ type.key }}
          </option>
        </b-select>
      </b-field>
      <b-field class="column" :label="preferredType.fieldLabel" v-if="preferredKey" custom-class="required-field">
        <b-input :value="preferredValue" @input="onPreferredInput" required />
      </b-field>
    </div>

    <div class="columns">
      <b-field class="column is-narrow" label="Another way to contact you">
        <b-select v-model="alternateKey">
          <option v-for="type in remainingTypes" :key="type.key" :value="type.key">
            {{ type.key }}
          </option>
        </b-select>
      </b-field>
      <b-field class="column" :label="alternateType.fieldLabel" v-if="alternateKey">
        <b-input :value="alternateValue" @input="onAlternateInput" required />
      </b-field>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    person: Object,
    contactTypes: Array,
  },
  data() {
    return {
      preferredKey: this.person.preferred_contact_type,
      alternateKey: this.person.alternate_contact_type,
    }
  },
  computed: {
    preferredType() {
      return this.contactTypes.find(({key}) => key === this.preferredKey) || this.contactTypes[0]
    },
    alternateType() {
      return this.contactTypes.find(({key}) => key === this.alternateKey) || this.remainingTypes[0]
    },
    preferredValue() {
      return this.person[this.preferredType.fieldName]
    },
    alternateValue() {
      return this.person[this.alternateType.fieldName]
    },
    remainingTypes() {
      return this.contactTypes.filter(({key}) => key !== this.preferredKey)
    },
  },
  methods: {
    // TODO: don't mutate data -- need some state management solution here
    onPreferredInput(value) {
      this.person[this.preferredType.fieldName] = value
    },
    onAlternateInput(value) {
      this.person[this.alternateType.fieldName] = value
    },
  },
}
</script>

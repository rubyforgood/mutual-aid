<template>
  <div class="offer-form">
    <h1 class="title">Offer support</h1>

    <div class="columns">
      <form action="/offers" method="post" class="column is-half-tablet">
        <AuthTokenInput />

        <!-- TODO: switch to inline errors instead -->
        <b-message
          v-if="hasErrors"
          title="Please fix the problems below"
          type="is-danger"
          class="content"
          aria-close-label="Close message"
        >
          <ul>
            <li v-for="(value) in errors">
              {{ value.join(', ') }}
            </li>
          </ul>
        </b-message>

        <ServiceAreaField
          v-model="offer.service_area_id"
          :options="service_areas"
          name="listing[service_area]"
        />

        <!-- TODO: maybe some visual demarcation of logical sections? -->

        <b-field
          :label-for="withPersonPrefix('name')"
          label="Name"
          custom-class="required-field"
        >
          <b-input
            v-model="person.name"
            :name="withPersonPrefix('name')"
            required
          />
        </b-field>

        <ContactFields
          fieldNamePrefix="listing[person]"
          :contactMethods="contact_methods"
          :preferredContactMethodId="preferredContactMethodId"
          v-bind:contactFields="person"
          v-on:preference-changed="(value) => preferredContactMethodId = value"
          v-on:field-changed="(field, value) => person[field] = value"
        />
        <SpacerField />

        <LocationFields
          fieldNamePrefix="listing[person][location]"
          v-bind="person.location"
        />
        <SpacerField />

        <CategoryFields
          fieldNamePrefix="listing[tag_list][]"
          :categories="categories"
          :tags="tagList"
        />
        <SpacerField />

        <b-field>
          <div class="control">
            <b-button native-type="submit" type="is-primary" size="is-medium">
              Submit
            </b-button>
          </div>
        </b-field>
      </form>
    </div>
  </div>
</template>

<script>
import {partial} from 'utils/function'
import {fieldNameWithPrefix} from 'utils/form'
import AuthTokenInput from 'components/AuthTokenInput'
import SpacerField from 'components/SpacerField'
import CategoryFields from './offer/CategoryFields'
import ContactFields from './offer/ContactFields'
import LocationFields from './offer/LocationFields'
import ServiceAreaField from './offer/ServiceAreaField'

export default {
  components: {
    AuthTokenInput,
    CategoryFields,
    ContactFields,
    LocationFields,
    ServiceAreaField,
    SpacerField
  },
  props: {
    offer: Object,
    categories: Array,
    contact_methods: Array,
    service_areas: Array,
  },
  data() {
    const person = this.offer.person || {}
    return {
      person,
      preferredContactMethodId: person.preferred_contact_method_id,
      tagList: this.offer.tag_list,
      errors: this.offer.errors,
    }
  },
  computed: {
    hasErrors() {
      return this.errors && Object.keys(this.errors).length
    },
  },
  created: function() {
    this.withPersonPrefix = partial(fieldNameWithPrefix, 'listing[person]')
  },
}
</script>

<style>
label.required-field:after {
  content: '*';
  color: orange;
  margin-left: 2px;
}
</style>

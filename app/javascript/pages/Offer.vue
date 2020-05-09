<template>
  <div>
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
          :preferredContactMethodKey="preferredContactMethodKey"
          v-bind:contactFields="person"
          v-on:preference-changed="(value) => preferredContactMethodKey = value"
          v-on:field-changed="(field, value) => person[field] = value"
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
import ContactFields from './offer/ContactFields'
import ServiceAreaField from './offer/ServiceAreaField'
import SpacerField from 'components/SpacerField'

export default {
  components: {AuthTokenInput, ContactFields, ServiceAreaField, SpacerField},
  props: {
    offer: Object,
    service_areas: Array,
    contact_methods: {
      type: Array,
      default: () => {
        return [
          // TODO: get these from the server
          {key: 'Call',     fieldName: 'phone',    fieldLabel: 'Phone number'},
          {key: 'Text',     fieldName: 'phone',    fieldLabel: 'Phone number'},
          {key: 'Email',    fieldName: 'email',    fieldLabel: 'Email address'},
          {key: 'WhatsApp', fieldName: 'whatsapp', fieldLabel: 'WhatsApp handle (?)'},
        ]
      },
    }
  },
  data() {
    const person = this.offer.person || {}
    return {
      person,
      preferredContactMethodKey: person.preferred_contact_method,
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

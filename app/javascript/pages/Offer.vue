<template>
  <div>
    <h1 class="title">Offer support</h1>

    <div class="columns">
      <form action="/offers" method="post" class="column is-half-tablet">
        <AuthTokenInput />

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
          :contactTypes="contactTypes"
          :preferredContactTypeKey="person.preferred_contact_type"
          v-bind:contactFields="person"
          v-on:updated="(field, value) => person[field] = value"
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
import SpacerField from 'components/SpacerField'

export default {
  components: {AuthTokenInput, ContactFields, SpacerField},
  props: {
    person: {
      type: Object,
      default: () => {
        return {
          name: 'My Name',
          phone: '202 202 1234',
          email: 'me@example.com',
          preferred_contact_type: null,
        }
      },
    },
    contactTypes: {
      type: Array,
      default: () => {
        return [
          {key: 'Call',     fieldName: 'phone',    fieldLabel: 'Phone number'},
          {key: 'Text',     fieldName: 'phone',    fieldLabel: 'Phone number'},
          {key: 'Email',    fieldName: 'email',    fieldLabel: 'Email address'},
          {key: 'WhatsApp', fieldName: 'whatsapp', fieldLabel: 'WhatsApp handle (?)'},
        ]
      },
    }
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

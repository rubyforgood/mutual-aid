<template>
  <div>
    <h1 class="title">Offer support</h1>

    <form>
      <b-field label="Name" custom-class="required-field">
        <b-input v-model="person.name" required />
      </b-field>

      <ContactFields :person="person" :contactTypes="contactTypes" />
    </form>
  </div>
</template>

<script>
import ContactFields from './offer/ContactFields'

export default {
  components: {ContactFields},
  props: {
    person: {
      type: Object,
      default: () => {
        return {
          name: 'My Name',
          phone: '202 202 1234',
          email: 'me@example.com',
          preferred_contact_type: 'Text',
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
}
</script>

<style>
label.required-field:after {
  content: '*';
  color: orange;
  margin-left: 2px;
}
</style>

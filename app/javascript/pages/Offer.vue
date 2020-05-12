<template>
  <form action="/offers" method="post" class="offer-form">
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
      label-for="listing[person][name]"
      label="Name"
      custom-class="required-field is-medium"
      message="If you would like, please indicate pronouns"
    >
      <b-input v-model="person.name" name="listing[person][name]" required />
    </b-field>

    <ContactFields
      fieldNamePrefix="listing[person]"
      :contactMethods="contact_methods"
      :preferredContactMethodId="preferredContactMethodId"
      v-bind:contactFields="person"
      v-on:preference-changed="(value) => preferredContactMethodId = value"
      v-on:field-changed="(field, value) => person[field] = value"
    /><SpacerField />

    <LocationFields
      fieldNamePrefix="listing[person][location]"
      v-bind="person.location"
    /><SpacerField />

    <CategoryFields
      fieldNamePrefix="listing[tag_list][]"
      :categories="categories"
      :tags="tagList"
    /><SpacerField />

    <b-field
      label-for="listing[person][skills]"
      label="Do you have any special skills or particular resources you would like us to be aware of?"
      :message="$options.skillsMessage"
      custom-class="is-medium"
    >
      <b-input :value="person.skills" name="listing[person][skills]" type="textarea" rows="2" />
    </b-field>

    <!-- TODO: probably needs a different field, not `description` -->
    <b-field
      label-for="listing[description]"
      label="This is an open slot to leave any questions, comments, clarifications, or criticisms."
      custom-class="is-medium"
    >
      <b-input :value="offer.description" name="listing[description]" type="textarea" rows="2" />
    </b-field>

    <b-field>
      <div class="control">
        <b-button native-type="submit" type="is-primary" size="is-medium">
          Submit
        </b-button>
      </div>
    </b-field>
  </form>
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

const skillsMessage = `
  Current or expired medical licences. Military medic training. Carpentry, electrical,
  plumbing, mechanical. MSW. Examples: 'I have 2 gallons of hand sanitizer.' or
  'I have a gas container for filling up cars if you can't go to a gas station' or
  'I have literally a thousand plastic bags' or 'I dropped 400$ on TP.'
  Whatever you can think of. For instance, if you have room to spare, tell us how many
  people could be housed with you short term. Or anything else that doesn't quite fit
  in the above spaces.
`

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
  skillsMessage,
}
</script>

<style>
label.required-field:after {
  content: '*';
  color: orange;
  margin-left: 2px;
}
</style>

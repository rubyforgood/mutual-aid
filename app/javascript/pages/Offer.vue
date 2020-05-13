<template>
  <form action="/offers" method="post" class="offer-form">
    <AuthTokenInput />

    <!-- TODO: switch to inline errors instead -->
    <ErrorMessages :errors="offer.errors" />

    <ServiceAreaField
      v-model="offer.service_area_id"
      :options="service_areas"
      name="listing[service_area]"
    />

    <NameField
      fieldName="listing[person][name]"
      :value="person.name"
    />

    <ContactFields
      fieldNamePrefix="listing[person]"
      :contactMethods="contact_methods"
      :person="person"
    /><SpacerField />

    <LocationFields
      fieldNamePrefix="listing[person][location]"
      v-bind="person.location"
    /><SpacerField />

    <CategoryFields
      fieldNamePrefix="listing[tag_list][]"
      :categories="categories"
      :tags="offer.tag_list"
    >
      <p class="title is-4">
        What are you able to offer?
      </p>
      <p>
      Note: Risks and best practices will be discussed before any work is done.
      People over 50 and people with vulnerable conditions should be especially cautious in these times,
      so this option will not be right for everyone.
      </p>
      <p class="mt-1 mb-1">
      Your safety is community safety. Do what is best.
      </p>
    </CategoryFields>
    <SpacerField />

    <b-field
      label-for="listing[person][skills]"
      label="Do you have any special skills or particular resources you would like us to be aware of?"
      :message="$options.skillsMessage"
      custom-class="is-medium"
    >
      <b-input :value="person.skills" name="listing[person][skills]" type="textarea" rows="2" />
    </b-field>


    <!-- TODO: probably needs a different field, not `description` -->
    <CommentsField
      fieldName="listing[description]"
      :value="offer.description"
    />

    <SubmitButton />
  </form>
</template>

<script>
import {partial} from 'utils/function'
import {fieldNameWithPrefix} from 'utils/form'
import {
  AuthTokenInput,
  CategoryFields,
  ContactFields,
  CommentsField,
  ErrorMessages,
  LocationFields,
  NameField,
  ServiceAreaField,
  SpacerField,
  SubmitButton,
} from 'components/forms'

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
    CommentsField,
    ErrorMessages,
    LocationFields,
    NameField,
    ServiceAreaField,
    SpacerField,
    SubmitButton,
  },
  props: {
    offer: Object,
    categories: Array,
    contact_methods: Array,
    service_areas: Array,
  },
  data() {
    return {
      person: this.offer.person || {},
    }
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

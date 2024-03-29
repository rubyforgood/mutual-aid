<template>
  <form action="/offers" method="post" class="offer-form">
    <AuthTokenInput />

    <!-- TODO: switch to inline errors instead -->
    <ErrorMessages :errors="submission.errors" />

    <ServiceAreaField
      :service_area="submission.service_area"
      :options="configuration.service_areas"
      name="submission[service_area]"
    />

    <NameField
      :fieldName="withPersonPrefix('name')"
      :value="person.name"
    />

    <ContactFields
      fieldNamePrefix="submission[person_attributes]"
      :contactMethods="configuration.contact_methods"
      :person="person"
    /><SpacerField />

    <LocationFields
      fieldNamePrefix="submission[location_attributes]"
      :location_types="configuration.location_types"
      v-bind="location"
    /><SpacerField />

    <CustomQuestions
      fieldNamePrefix="submission[responses_attributes]"
      :questions="form.questions"
    /><SpacerField />

    <CategoryFields
      :fieldNamePrefix="withListingPrefix('categories', '[]')"
      :categories="configuration.categories"
      :tags="listing.tag_list"
    >
      <p class="label is-medium">
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

    <b-field
      label="Do you have any special skills or particular resources you would like us to be aware of?"
      :label-for="withPersonPrefix('skills')"
      :message="$options.skillsMessage"
      custom-class="mt-2 is-medium"
    >
      <b-input :value="person.skills" :name="withPersonPrefix('skills')" type="textarea" rows="2" />
    </b-field>


    <!-- TODO: probably needs a different field, not `description` -->
    <CommentsField
      :fieldName="withListingPrefix('description')"
      :value="listing.description"
    />

    <SubmitButton />
  </form>
</template>

<script>
import {partial} from 'utils/function'
import {composeFieldName} from 'utils/form'
import {
  AuthTokenInput,
  CategoryFields,
  ContactFields,
  CommentsField,
  CustomQuestions,
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
    CustomQuestions,
    ErrorMessages,
    LocationFields,
    NameField,
    ServiceAreaField,
    SpacerField,
    SubmitButton,
  },
  props: {
    submission: Object,
    configuration: Object,
    form: Object,
  },
  data() {
    return {
      location: this.submission.location || {},
      listing: this.submission.listing || {},  // todo: change to render from multiple listings
      person: this.submission.person || {},
    }
  },
  created: function() {
    this.withListingPrefix = partial(composeFieldName, 'submission', 'listings_attributes')
    this.withPersonPrefix  = partial(composeFieldName, 'submission', 'person_attributes')
  },
  skillsMessage,
}
</script>

<style scoped>
label.required-field:after {
  content: '*';
  color: orange;
  margin-left: 2px;
}
</style>

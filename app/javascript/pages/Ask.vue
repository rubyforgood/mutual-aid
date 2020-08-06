<template>
  <form action="/asks" method="post" class="ask-form">
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

    <LocationFields
      fieldNamePrefix="submission[location_attributes]"
      :location_types="configuration.location_types"
      v-bind="location"
    /><SpacerField />

    <ContactFields
      fieldNamePrefix="submission[person_attributes]"
      :contactMethods="configuration.contact_methods"
      :person="person"
    /><SpacerField />

    <CustomQuestions
      fieldNamePrefix="submission[responses_attributes]"
      :questions="form.questions"
    /><SpacerField />

    <CategoryFields
      :fieldNamePrefix="withListingPrefix('categories[]')"
      :categories="configuration.categories"
      :tags="listing.tag_list"
    >
      <p class="label is-medium">
        What are you requesting?
      </p>
    </CategoryFields>

    <!-- TODO: probably needs a different field, not `description` -->
    <CommentsField
      :fieldName="withListingPrefix('description')"
      :value="listing.description"
      class="mt-2"
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
  CommentsField,
  ContactFields,
  CustomQuestions,
  ErrorMessages,
  LocationFields,
  NameField,
  ServiceAreaField,
  SpacerField,
  SubmitButton,
} from 'components/forms'

export default {
  components: {
    AuthTokenInput,
    CategoryFields,
    CommentsField,
    ContactFields,
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
      listing: this.submission.listing || {},
      person: this.submission.person || {},
    }
  },
  created: function() {
    this.withListingPrefix = partial(fieldNameWithPrefix, 'submission[listings_attributes]')
    this.withPersonPrefix  = partial(fieldNameWithPrefix, 'submission[person_attributes]')
  },
}
</script>

<style scoped>
label.required-field:after {
  content: '*';
  color: orange;
  margin-left: 2px;
}
</style>

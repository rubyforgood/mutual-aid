<template>
  <form action="/asks" method="post" class="ask-form">
    <AuthTokenInput />

    <!-- TODO: switch to inline errors instead -->
    <ErrorMessages :errors="ask.errors" />

    <ServiceAreaField
      v-model="ask.service_area_id"
      :options="service_areas"
      name="listing[service_area]"
    />

    <NameField
      fieldName="listing[person][name]"
      :value="person.name"
    />

    <LocationFields
      fieldNamePrefix="listing[person][location]"
      v-bind="person.location"
    /><SpacerField />

    <ContactFields
      fieldNamePrefix="listing[person]"
      :contactMethods="contact_methods"
      :person="person"
    /><SpacerField />

    <CategoryFields
      fieldNamePrefix="listing[tag_list][]"
      :categories="categories"
      :tags="ask.tag_list"
    >
      <p class="title is-4">
        What are you requesting?
      </p>
    </CategoryFields>
    <SpacerField />

    <!-- TODO: probably needs a different field, not `description` -->
    <CommentsField
      fieldName="listing[description]"
      :value="ask.description"
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
    ErrorMessages,
    LocationFields,
    NameField,
    ServiceAreaField,
    SpacerField,
    SubmitButton,
  },
  props: {
    ask: Object,
    categories: Array,
    contact_methods: Array,
    service_areas: Array,
  },
  data() {
    return {
      person: this.ask.person || {},
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

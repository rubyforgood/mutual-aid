<template>
  <b-field
    v-if="options.length > 1"
    :label-for="name"
    label="Service area"
    custom-class="required-field is-medium"
  >
    <b-select
      :name="name"
      :value="service_area_id"
      required
    >
      <option
        v-for="serviceAreas in options"
        :key="serviceAreas.id"
        :value="serviceAreas.id"
      >
        {{ serviceAreas.name }}
      </option>
    </b-select>
  </b-field>

  <input
    v-else
    :name="name"
    :value="options[0].id"
    type="hidden"
  />
</template>

<script>
export default {
  props: {
    options: Array,
    name: String,
    service_area: Object,
  },
  data() {
    return {
      service_area_id: this.service_area ? this.service_area.id : null,
    }
  },
}</script>

<template>
  <b-field
    v-if="options.length > 1"
    label-for="service_area_id"
    label="Service area"
    custom-class="required-field"
  >
    <b-select
      :value="value"
      @input="$emit('input', $event)"
      name="listing[service_area]"
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
    value: String,
  },
}</script>

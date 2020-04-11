<template>
  <div class="listing-form">
    <div class="contact-info">
      <div class="name">
        <InputField label="Name" name="listing[name]" :required="true"/>
      </div>
      <div class="email">
        <InputField label="Email" name="listing[email]" type="email" :required="true"/>
      </div>
      <div class="phone">
        <InputField label="Phone" name="listing[phone]" type="tel"/>
      </div>
      <div class="city">
        <InputField label="City" name="listing[location_attributes][city]"/>
      </div>
      <div class="postal-code">
        <InputField label="Zip" name="listing[location_attributes][zip]"/>
      </div>
      <div class="street-address">
        <InputField label="Street Address" name="listing[location_attributes][street_address]"/>
      </div>
    </div>
    <div class="support-form">
      <div class="support-offered">
      </div>
      <div class="support-asked">
      </div>
    </div>
  </div>
</template>

<script>
import InputField from "./InputField";

export default {
  components: {
    InputField
  },
  props: { values: Object }
}
</script>

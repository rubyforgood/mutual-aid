<template>
  <div class="listing-form">
    <div class="contact-info">
      <div class="name">
        <InputField labelText="Name" dataName="listing[name]" :required="true"/>
      </div>
      <div class="email">
      </div>
      <div class="phone">
      </div>
      <div class="postal-code">
      </div>
      <div class="city">
      </div>
      <div class="street-address">
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
  }
}
</script>

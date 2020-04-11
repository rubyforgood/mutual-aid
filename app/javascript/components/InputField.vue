<template>
 <div class="field"
   v-bind:class="{required: required}">
   <label class="label" :for="dataName">{{labelText}}</label>
   <div class="control">
     <input class="input" :type="inputType" :name="dataName">
   </div>
  </div>
</template>

<script>
export default {
  props: {
    labelText: { type: String },
    inputType: { type: String, default: 'text'},
    dataName: { type: String },
    required: { type: Boolean, default: false}
  }
}
</script>

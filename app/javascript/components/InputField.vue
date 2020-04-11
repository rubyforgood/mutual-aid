<template>
 <div class="field"
   v-bind:class="{required: required}">
   <label class="label" :for="name">{{label}}</label>
   <div class="control">
     <input class="input" :type="type" :name="dataName" v-model="dataValue" @input="doUpdate">
   </div>
  </div>
</template>

<script>
export default {
  props: {
    label: { type: String },
    type: { type: String, default: 'text'},
    name: { type: String },
    value: { type: String, default: ''},
    required: { type: Boolean, default: false},
  },
  data () {
    return {
      dataValue: this.value
    }
  },
  methods: {
    doUpdate() {
      this.$emit('input', this.dataValue)
    }
  }
}
</script>

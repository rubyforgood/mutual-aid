<template>
  <div class='section'>
    <h2 class='subtitle'>{{title}}</h2>
    <p v-html="description" class='description'></p>
  </div>
</template>

<script>
export default {
  props:{
    title:{type: String, default:"This is a placeholder!"},
    description:{type: String, default:"Put descriptive things about this section here"}
  },
}
</script>
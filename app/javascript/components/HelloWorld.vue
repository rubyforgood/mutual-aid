<template>
  <p>{{ message }}</p>
</template>

<script>
export default {
  props: {
    message: {type: String, default: 'Hello from Vue'}
  },
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>

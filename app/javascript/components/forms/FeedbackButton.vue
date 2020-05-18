<template>
  <a :href="url" class="button is-outlined">
    Feedback
  </a>
</template>

<script>
export default {
  computed: {
    url() {
      const pathname = window.location.pathname
      return `/software_feedbacks/new?page_url=${pathname}`
    },
  },
}
</script>

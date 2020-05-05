<template>
  <ul v-if="isTagsValid" class="tagList tags">
    <li v-for="tag in tags" :key="tag.id" class="tagList-tag tag" :class="tagClasses">
      {{ tag.name }}
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    tagClasses: {type: String, default: 'is-info is-light'},
    tags: Array,
  },
  computed: {
    isTagsValid() {
      return (
        !!this.tags &&
        Array.isArray(this.tags) &&
        this.tags.some((tag) => !!tag && tag.hasOwnProperty('id') && tag.hasOwnProperty('name'))
      )
    },
  },
}
</script>

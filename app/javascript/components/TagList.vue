<template>
  <ul class="tagList" :class="listClasses">
    <li v-for="tag in tags" :key="tag.id" class="tagList-tag" :class="tagClasses">
      {{ tag.name }}
    </li>
  </ul>
</template>

<script>
export default {
  props: {
    listClasses: String,
    tagClasses: {type: String, default: 'tag is-info is-light'},
    tags: Array,
  },
}
</script>

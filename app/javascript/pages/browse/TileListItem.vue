<template>
  <li class="tileBrowser-listItem box">
    <div class="tileBrowser-listItem-categories">
      <TagList :tags="category_tags" tagClasses="tag is-info is-light is-inline-flex" />
    </div>
    <div class="tileBrowser-listItem-body">
      <TagList v-if="service_area" :tags="[service_area]" />
      <h5 class="subtitle">{{ short_title }}</h5>
      <p>{{ description }}</p>
      <div>
        <time :datetime="publish_until"></time>
      </div>
    </div>
    <div class="tileBrowser-listItem-actions">
      <button class="button icon-list is-primary is-outlined">View Profile</button>
      <button class="button icon-list is-primary is-outlined">Contact</button>
    </div>
  </li>
</template>

<script>
import TagList from 'components/TagList'

export default {
  props: {
    category_tags: {type: Array, default: () => []},
    service_area: {type: Object, default: null},
    short_title: String,
    description: String,
    publish_until: String,
  },
  components: {
    TagList,
  },
}
</script>

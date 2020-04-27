<template>
  <li class="tileBrowser-listItem box">
    <div class="tileBrowser-listItem-categories  ">
      <TagList :tags="categoryTags" tagClasses="tag is-info is-light is-inline-flex" />
    </div>
    <div class="tileBrowser-listItem-body ">
      <TagList :tags="locationTags" />
      <h5 class="subtitle">{{ listing.short_title }}</h5>
      <p>{{ listing.description }}</p>
      <div>
        <time :datetime="listing.publish_until"></time>
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
    listing: {type: Object},
    helper: {type: Object},
  },
  computed: {
    categoryTags: function() {
      return this.listing.categories.map(category_id => this.helper.category_for(category_id))
    },
    locationTags: function() {
      return [this.helper.location_for(this.listing.location)]
    },
  },
  components: {
    TagList,
  },
}
</script>

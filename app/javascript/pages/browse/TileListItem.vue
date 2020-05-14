<template>
  <li class="tileListItem box is-paddingless">
    <div class="header header--withShadow">
      <div class="left-tags">
        <TagList :tags="category_tags" class="categoryTags" tagClasses="tag is-info is-light" />
      </div>
      <div class="right-tags tags">
        <b-tag v-if="urgency" :class="urgencyColor">
          <b-icon v-if="showUrgentIcon" icon="exclamation-triangle" size="is-small" />
          {{ urgency.name }}
        </b-tag>
        <MappedIconList :iconTypes="[{id: contribution_type, name: contribution_type}]" />
      </div>
    </div>
    <div class="body">
      <div class="tags">
        <div v-if="service_area" class="tag is-info is-light">{{ service_area.name }}</div>
        <MappedIconList :iconTypes="contact_types" />
      </div>
      <div class="text">
        <h5 class="subtitle">{{ title }}</h5>
        <p>{{ description }}</p>
        <div>
          <small>
            <time :datetime="created_at">{{ created_at }}</time>
          </small>
        </div>
      </div>
    </div>
    <div class="actions">
      <div class="buttonSpacing" v-if="profile_path">
        <a :href="profile_path" class="button icon-list is-primary is-outlined">View Profile</a>
      </div>
      <div class="buttonSpacing" v-if="match_path">
        <a :href="match_path" class="button icon-list is-primary is-outlined">Match</a>
      </div>
    </div>
  </li>
</template>

<script>
import TagList from 'components/TagList'
import MappedIconList from 'components/MappedIconList'

export default {
  props: {
    contribution_type: String,
    category_tags: {type: Array, default: () => []},
    service_area: {type: Object, default: null},
    title: String,
    description: String,
    created_at: String,
    urgency: Object,
    contact_types: {type: Array, default: () => []},
    profile_path: String,
    match_path: String
  },
  components: {
    TagList,
    MappedIconList,
  },
  computed: {
    showUrgentIcon() {
      return !(this.urgency && this.urgency.id > 2)
    },
    urgencyColor() {
      return this.showUrgentIcon ? 'is-warning' : 'is-light is-warning'
    },
  },
}
</script>

<style lang="scss" scoped>
@import 'bulma/bulma';

.tileListItem {
  @include tablet {
    margin-left: 0.5rem;
    margin-right: 0.5rem;
    display: flex;
    flex-direction: column;
  }
}

.header {
  display: flex;
  flex-wrap: wrap;
  padding: 0.2rem 0.3rem 0.3rem;
  &--withShadow {
    box-shadow: 0px 0.1rem 0.1rem rgba(0, 0, 0, 0.2);
  }
  & div {
    margin-top: 0.1rem;
  }
  & .left-tags {
    flex-grow: 1;
  }
}
.body {
  padding: 0.3rem;
  box-shadow: 0px 0.1rem 0.1rem rgba(0, 0, 0, 0.2);
  flex: auto;
}
.text {
  margin: 0.2rem;
}

.actions {
  margin: 0.1rem;
}

.buttonSpacing {
  display: inline-block;
  margin: 0.1rem;
}
small {
  font-size: small;
  font-style: italic;
}
</style>

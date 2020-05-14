<template>
  <div class="listBrowser">
    <h2 class="title">List view</h2>
    <table class="table table-hover table-curved table-condensed is-hoverable">
      <tr>
        <th>Type</th>
        <th>Categories</th>
        <th>Service Area</th>
        <th>Connect</th>
        <th>Details</th>
      </tr>
      <tr v-for="contribution in contributions" :key="contribution.id">
        <td><MappedIconList :iconTypes="[{id: id, name: contribution.contribution_type}]" /></td>
        <td><TagList :tags="contribution.category_tags" /></td>
        <td><TagList :tags="[contribution.service_area]" /></td>
        <td>
          <MappedIconList :iconTypes="contribution.contact_types" />
          <a :href="contribution.profile_path" class="button icon-list is-primary is-outlined">View Profile</a>
          <a :href="contribution.respond_path" class="button icon-list is-primary is-outlined">Respond</a>
        </td>
        <td>{{ contribution.title }}</td>
      </tr>
    </table>
  </div>
</template>

<script>
import TagList from 'components/TagList'
import MappedIconList from 'components/MappedIconList'

export default {
  props: {
    contributions: {type: Array, default: () => []},
    filters: Object,
  },
  components: {
    TagList,
    MappedIconList,
  },
}
</script>

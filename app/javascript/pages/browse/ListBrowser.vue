<template>
  <div class="listBrowser">
    <h2 class="title">List view</h2>
    <table class="table table-hover table-curved table-condensed is-hoverable">
      <tr>
        <th>Type</th>
        <th>Categories</th>
        <th>Service Area</th>
        <th>Connect</th>
<!--        <th>Details</th>-->
      </tr>
      <tr v-for="contribution in contributions" :key="contribution.id">
        <td><MappedIconList :iconTypes="[{name: contribution.contribution_type}]" /></td>
        <td><TagList :tags="contribution.category_tags" /></td>
        <td><TagList :tags="[contribution.service_area]" /></td>
        <td style="text: nowrap;">
          <SingleIcon :iconType="contribution.contact_types[0].name" />
          <a :href="contribution.profile_path" class="button icon-list is-primary is-outlined"><span class="fa fa-user-circle"></span></a>
          <a :href="contribution.respond_path" class="button icon-list is-primary is-outlined">Respond</a>
          <a :href="contribution.match_path" class="button icon-list is-primary is-outlined">Match</a>
        </td>
<!--        <td>{{ contribution.title }}</td>-->
      </tr>
    </table>
  </div>
</template>

<script>
import TagList from 'components/TagList'
import MappedIconList from 'components/MappedIconList'
import SingleIcon from 'components/SingleIcon'

export default {
  props: {
    contributions: {type: Array, default: () => []},
    filters: Object,
  },
  components: {
    TagList,
    SingleIcon,
    MappedIconList,
  },
}
</script>

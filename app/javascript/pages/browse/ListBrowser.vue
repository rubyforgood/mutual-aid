<template>
  <div class="listBrowser">
    <table class="table table-hover table-curved table-condensed is-hoverable is-fullwidth">
      <tr>
        <th>Type</th>
        <th>Categories</th>
        <th>Urgency</th>
        <th>Service Area</th>
        <th>Connect</th>
        <th>View</th>
        <th v-if="showContributorNames">Contributor Name</th>
      </tr>
      <tr v-for="contribution in contributions" :key="contribution.key">
        <td>
          <MappedIconList :iconTypes="contribution.inexhaustible ? [{name: contribution.contribution_type}, {name: 'Inexhaustible'}] : [{name: contribution.contribution_type}]" />
        </td>
        <td>
          <TagList :tags="contribution.category_tags" />
        </td>
        <td>
          <b-tag v-if="contribution.urgency" :class="!(contribution.urgency && contribution.urgency.id > 1) ? 'is-light is-warning' : ''" size="is-small" >
            <b-icon v-if="!(contribution.urgency && contribution.urgency.id > 1)" icon="exclamation-triangle" />
            {{ contribution.urgency.name }}
          </b-tag>
        </td>
        <td>
          <div v-for="service_area in contribution.service_areas" :key="service_area.id" class="has-text-grey-lighter">
            {{ service_area.name }}
          </div>
        </td>
        <td style="text: nowrap;">
          <SingleIcon :iconType="contribution.contact_types[0].name" />
        </td>
        <td>
          <div>
            <a :href="contribution.view_path" class="button icon-list is-primary"><span class=""> View</span></a>
          </div>
        </td>
        <td v-if="showContributorNames ">{{ !!contribution.person ? contribution.person.name : ' ' }}</td>
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
  computed: {
    showContributorNames() {
      return this.contributions.some(contribution => contribution.person && contribution.person.name)
    },
  },
}
</script>

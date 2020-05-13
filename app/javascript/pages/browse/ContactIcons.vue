<template>
  <ul>
    <li v-for="icon in iconData" :key="icon.name" class="tag">
      <b-icon :icon="icon.image" :aria-label="icon.name"/>
    </li>
  </ul>
</template>

<script>
import TagList from 'components/TagList'

const iconNameMapping = {
  email: 'envelope',
  text: 'mobile-alt',
  phone: 'phone'
}

export default {
  components: {TagList},
  props: {
    contactTypes: {type: Array, default: () => []},
  },
  computed: {
    iconData() {
      return this.contactTypes.map(function (type) {
        return {name: type.name, image: iconNameMapping[type.name]}
      })
    },
  },
}
</script>

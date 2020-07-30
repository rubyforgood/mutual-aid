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
  Email: 'envelope',
  Text: 'mobile-alt',
  Phone: 'phone',
  WhatsApp: 'whatsapp',
  Call: 'phone',
  Ask: 'hand-sparkles',
  Offer: 'hand-holding-heart',
  Inexhaustible: 'hourglass-half has-text-primary'
}

export default {
  iconNameMapping: iconNameMapping,
  components: {TagList},
  props: {
    iconTypes: {type: Array, default: () => []},
  },
  computed: {
    iconData() {
      return this.iconTypes.map(function (type) {
        return {name: type.name, image: iconNameMapping[type.name]}
      })
    },
  },
}
</script>

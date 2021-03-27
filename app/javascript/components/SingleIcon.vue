<template>
  <span :class="klass">
    <b-icon :icon="iconNameMapping[iconType]" :aria-label="iconType"/>
  </span>
</template>

<script>
import TagList from 'components/TagList'
const iconNameMapping = {
  Email: 'envelope',
  Text: 'mobile-alt',
  Phone: 'phone',
  WhatsApp: 'whatsapp fab',
  Call: 'phone',
  Ask: 'hand-sparkles',
  Offer: 'hand-holding-heart',
  Reply: 'reply',
}

export default {
  components: {TagList},
  props: {
    iconType: {type: String},
    klass: {type: String, default: 'tag'},
  },
  data(){ return { iconNameMapping, } }
}
</script>

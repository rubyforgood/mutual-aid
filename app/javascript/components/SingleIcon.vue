<template>
  <span class="tag">
    <b-icon :icon="iconNameMapping[iconType]" :aria-label="iconType"/>
  </span>
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
  Offer: 'hand-holding-heart'
}

export default {
  components: {TagList},
  props: {
    iconType: {type: String},
  },
  data(){ return { iconNameMapping, } }
}
</script>

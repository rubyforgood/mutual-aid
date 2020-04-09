<template>
  <div class='orientation section'>
    <h1 class='title'>Welcome</h1>
    <AboutSection title='What is Mutual-Aid?' description="Mutual-aid is a movement. It's about connecting people with each other in a time of need. It's people helping people, because we can."/>
    <AboutSection title="Where do you fit in?" description="If there are ways that you'd like to contribute to bettering the lives of the community around you. If there are needs of yours that your community could help you meet. Whatever your individual case may be, we're here to help you make that connection." />
    <div class='columns'>
      <div class='column'>
        
      </div>
      <div class='column'>
        
      </div>
      <div class='column'>
        
      </div>
    </div>
  </div>
</template>

<script>
import AboutSection from "./AboutSection";

export default {
  components:{
    AboutSection
  },
  props:{
    organization: String
  }
}
</script>
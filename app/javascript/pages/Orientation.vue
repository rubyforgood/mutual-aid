<template>
  <div class='orientation section'>
    <div class='columns'>
      <div class='column'>
        <h1 class='title'>Welcome!</h1>
      </div>
    </div>
    <div class='columns'>
      <div class='column'>
        <AboutSection title='What is Mutual Aid?' description="Mutual aid is a movement. It's about connecting people with each other in a time of need. It's people helping people, because we can."/>
        <AboutSection title='Who are we?' description="We're your regional mutual aid group. Learn more"/>
        <AboutSection title="Where do you fit in?" description="Good neighbors share. Asking is a gift to the giver. Whatever your individual case may be, we're here to help you make connections." />
      </div>
      <div class='column'>
        <div>
          <h2 class='subtitle is-3'>Need some help?</h2>
          <div class='action-buttons'>
            <b-button type='is-primary'>Submit an Ask</b-button>
            <br>
            <span class=''><a href='/listings'>View offers and resources</a></span>
          </div>
        </div>
        <div>
          <br><br>
          <h2 class='subtitle is-3'>Want to help?</h2>
          <div class='action-buttons'>
            <b-button type='is-primary'>View Asks</b-button>
            <br>
            <span class=''><a href='/listings'>Submit an offer</a></span>
            <br>
            <span class=''><a href='/community_resources/new'>Submit a community resource</a></span>
            <br>
            <span class=''><a href='/announcements/new'>Submit an announcement</a></span>
            <br>
            <span class=''><a href='/donations/new'>Donate money</a></span> | <span class=''><a href='/donations/new'>Donate goods</a></span>
            <br>
            <span class=''><a href='/volunteers/new'>Volunteer</a></span>
          </div>
        </div>

        <div>
          <br><br>
          <h2 class='subtitle is-3'>Want to do both?</h2>
          <div class='action-buttons'>
            <b-button type='is-primary'>Create a Profile</b-button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import AboutSection from "components/AboutSection";

export default {
  components:{
    AboutSection
  },
  props:{
    organization: String
  }
}
</script>

<style scoped>
  .column div{
    text-align:left;
  }
</style>

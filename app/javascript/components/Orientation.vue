<template>
  <div class='orientation section'>
    <h1 class='title'>Welcome!</h1>
    <div class='columns'>
      <div class='column'>
        <AboutSection title='What is Mutual-Aid?' description="Mutual-aid is a movement. It's about connecting people with each other in a time of need. It's people helping people, because we can."/>
      </div>
      <div class='column'>
        <AboutSection title='Who are we?' description="We're your regional mutual aid group. Learn more"/>
      </div>
    </div>
    <div class='has-text-center' style='text-align: center;'>
       <AboutSection title="Where do you fit in?" description="Good neighbors share. Asking is a gift to the giver. Whatever your individual case may be, we're here to help you make connections." />
    </div>
    <div class='columns'>
      <div class='column'>
        <div>
          <h2 class='subtitle is-3'>Need some help?</h2>
          <div class='action-buttons'>
            <span class="action-button"><span class='button is-primary is-outlined'>View offers</span></span>
            <span class="action-button"><span class='button is-primary'>Submit an Ask</span></span>
            <br>
            <span class=''><a href='/community_resources'>Browse resources</a></span>
            <!-- <span class="action-button"><span class='button is-primary is-outlined'>Browse resources</span></span> -->
          </div>
        </div>
      </div>
      <div class='column'>
        <div>
          <h2 class='subtitle is-3'>Want to help?</h2>
          <div class='action-buttons'>
            <span class="action-button"><span class='button is-primary'>View Asks</span></span>
            <span class="action-button"><span class='button is-primary is-outlined'>Submit an Offer</span></span>
            <br>
            <span class=''><a href='/external_resources/new'>Share a community resource</a></span>
            <br>
            <span class=''><a href='/donations/new'>Donate money</a></span> | <span class=''><a href='/donations/new'>Donate goods</a></span>
            <br>
            <span class=''><a href='/volunteers/new'>Volunteer</a></span>
            <!-- <div class="action-button"><span class='button is-primary is-outlined'>Volunteer</span></div>
            <div class="action-button"><span class='button is-primary is-outlined'>Donate</span></div>
            <div class="action-button"><span class='button is-primary is-outlined'>Share a community resource</span></div> -->
          </div>
        </div>
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

<style scoped>
  .column div{
    text-align:center;
  }
</style>
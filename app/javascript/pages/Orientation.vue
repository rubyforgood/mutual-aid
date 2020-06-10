<template>
  <div class='orientation section'>
    <div class='columns'>
      <div class='column'>
        <h1 class='title'>Welcome!</h1>
      </div>
    </div>
    <div class='columns'>
      <div class='column'>
        <AboutSection id='landing_page_text_what' title='What is Mutual Aid?' :description="landingPageTextWhat"/>
        <AboutSection id='landing_page_text_who' title='Who are we?' :description="landingPageTextWho"/>
        <AboutSection id='landing_page_text_how' title="Where do you fit in?" :description="landingPageTextHow" />
      </div>
      <div class='column'>
        <div>
          <h2 class='subtitle is-3'>Need some help?</h2>
          <div class='action-buttons'>
            <a href="/asks/new" class="button is-primary">Submit an Ask</a>
<!--            <a href="/contributions?contribution_type=offer" class="button is-primary is-outlined">View Offers [*]</a>-->
<!--            <br><br>-->
<!--            <span class=''><a href='/contributions'>View offers and resources [*]</a></span>-->
          </div>
        </div>
        <div>
          <br><br>
          <h2 class='subtitle is-3'>Want to help?</h2>
          <div class='action-buttons'>
            <a href="/offers/new" class="button is-primary">Submit an Offer</a>
<!--            <a href="/contributions?contribution_type=ask" class="button is-primary is-outlined">View Asks [*]</a>-->
            <br><br>
            <span class=''><a href='/community_resources/new'>Submit a community resource</a></span>
            <br>
            <span class=''><a href='/announcements/new'>Submit an announcement</a></span>
<!--            <br>-->
<!--            <span class=''><a href='/donations/new'>Donate money or goods</a></span>-->
<!--            <br>-->
<!--            <span class=''><a href='/offers/new?page_title=Volunteer Request'>Volunteer [TBD]</a></span>-->
          </div>
        </div>

<!--        <div>-->
<!--          <br><br>-->
<!--          <h2 class='subtitle is-3'>Both, maybe?</h2>-->
<!--          <div class='action-buttons'>-->
<!--            <a href="/combined_form" class="button is-primary">Create a Profile [TBD]</a>-->
<!--          </div>-->
<!--        </div>-->
      </div>
    </div>
  </div>
</template>

<script>
import AboutSection from "./orientation/AboutSection";

export default {
  components:{
    AboutSection
  },
  props:{
    organization: String,
    landingPageTextWhat: { type: String,
      default: "Mutual Aid is people helping people. When we take responsibility for our communities, " +
              "caring for each-other, in good times and bad, we can thrive together." },
    landingPageTextWho: { type: String,
      default: "While Lansing Area Mutual Aid started in response to COVID, " +
              "we're a growing organization making sure Neighbors are getting their needs met, " +
              "in this crisis and beyond." },
    landingPageTextHow: { type: String,
      default: "If you are in the Lansing area, you are a Neighbor, and we've got your back. Got something you need? " +
              "Ask. Got something to give? Offer. Everybody needs help, and everyone has something to give. " +
              "We'll help connect you." }
  }
}
</script>

<style scoped>
  .column div{
    text-align:left;
  }
</style>

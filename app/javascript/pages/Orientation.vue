<template>
  <div class='orientation section'>
      <div class='columns actions is-centered'>
        <div class='column is-one-third'>
          <div class='box action'>
            <h2 class='subtitle is-3'>Need some help?</h2>
            <div class='action-buttons'>
              <a href="/asks/new" class="button is-primary">Submit an Ask</a>
            </div>
          </div>
        </div>
        <div class='column is-one-third'>
          <div class='box action'>
            <h2 class='subtitle is-3'>Want to help?</h2>
            <div class='action-buttons'>
              <a href="/offers/new" class="button is-primary">Submit an Offer</a>
            </div>
          </div>
        </div>
      </div>
      <hr>
      <div class='level'>
        <h1 class='title level-item'>Mutual Aid</h1>
      </div>
      <hr>
      <div class='columns'>
        <div class='column'>
          <AboutSection id='landing_page_text_what' title='What is Mutual Aid?' :description="landing_page_text_what"/>
        </div>
        <div class='column'>
          <AboutSection id='landing_page_text_who' title='Who are we?' :description="landing_page_text_who"/>
        </div>
        <div class='column'>
          <AboutSection id='landing_page_text_how' title="Where do you fit in?" :description="landing_page_text_how"/>
        </div>
      </div>
      <div class='section anouncements columns is-centered'>
        <div class='column is-half'>
          <Carousel id='landing_anouncements' name='carousel' />
        </div>
      </div>
      <hr>
      <div class='columns is-centered links'>
        <div class='column'><a href='/community_resources/new' class='button is-primary is-outlined'>Submit a Community Resource</a></div>
        <div class='column'><a href='/announcements/new' class='button is-primary is-outlined'>Submit an Announcement</a></div>
      </div>
  </div>
</template>

<script>
import AboutSection from "./orientation/AboutSection";
import Carousel from "./orientation/Carousel";

export default {
  components:{
    AboutSection,
    Carousel,
  },
  props:{
    organization: String,
    landing_page_text_what: { type: String,
      default: "Mutual Aid is people helping people. When we take responsibility for our communities, " +
              "caring for each-other, in good times and bad, we can thrive together." },
    landing_page_text_who: { type: String,
      default: "While Lansing Area Mutual Aid started in response to COVID, " +
              "we're a growing organization making sure Neighbors are getting their needs met, " +
              "in this crisis and beyond." },
    landing_page_text_how: { type: String,
      default: "If you are in the Lansing area, you are a Neighbor, and we've got your back. Got something you need? " +
              "Ask. Got something to give? Offer. Everybody needs help, and everyone has something to give. " +
              "We'll help connect you." }
  }
}

</script>

<style scoped>

  .box {
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }
  .action {
    height: 80%;
  }
  .columns.actions {
    height: 22em;
  }
  .column {
    text-align: center;
  }
  .level {
    padding: 1.5em;
  }

  hr {
    background-color: darkgrey;
  }

</style>

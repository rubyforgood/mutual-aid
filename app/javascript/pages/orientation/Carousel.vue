<template>
  <section>
    <b-carousel
      :autoplay="true"
      :arrow="true"
      :repeat="true"
      :arrow-hover="true"
      :interval="5000"
      :pause-hover="false"
    >
      <b-carousel-item v-for="(announcement, i) in announcements" :key="i" :id="announcement.id">
        <section :class="`hero is-light`" style="background-color: grey-lightest;">
          <div class="hero-body has-text-centered">
            <h1 class="title" v-if="announcement.id === 'default'">{{ announcement.name }}</h1>
            <h1 class="title" v-else>
              <a :href="`/announcements/${announcement.id}`">{{ announcement.name }}</a>
            </h1>
            <p class="content">{{ announcement.description }}</p>
          </div>
        </section>
      </b-carousel-item>
    </b-carousel>
  </section>
</template>

<script>
import {Carousel} from 'buefy'
import fetch from 'node-fetch'

export default {
  data() {
    return {
      announcements: [{name: 'No Current Announcements', description: '', id: 'default'}],
    }
  },
  mounted() {
    this.fetchAnnouncements()
  },
  methods: {
    fetchAnnouncements() {
      fetch('/announcements_list.json?')
        .then((response) => response.json())
        .then((data) => {
          if (data.length > 0) {
            this.announcements = data
          }
        })
    },
  },
}
</script>

<style scoped>
@media (min-width: 450px) {
  .hero {
    height: 20em;
  }
  .hero-body {
    max-height: 20em;
    padding: 5em 3em 2em;
  }
}
.content {
  max-height: 60%;
  overflow: hidden;
}
a {
  color: black;
  text-decoration: underline;
}
</style>

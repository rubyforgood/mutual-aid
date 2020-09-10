<template>
    <section>
        <b-carousel
            :autoplay="auto"
            :arrow="arrow"
            :repeat="arrowBoth"
            :arrow-hover="arrowHover"
            :interval="interval"
            :pause-hover="pauseHover">
            <b-carousel-item v-for="(announcement, i) in announcements" :key="i">
                <section :class="`hero is-medium is-light`" style="background-color:grey-lightest">
                    <div class="hero-body has-text-centered">
                        <h1 class="title">{{announcement.name}}</h1>
                        <p class="content">{{announcement.description}}</p>
                    </div>
                </section>
            </b-carousel-item>
        </b-carousel>
    </section>
</template>

<script>
import { Carousel } from 'buefy';

export default {
    data() {
        return {
            auto: true,
            arrow: true,
            pauseHover: false,
            arrowBoth: true,
            arrowHover: false,
            interval: 5000,
            announcements: [{title: 'No Current Announcements', description: ''}],
        }
    },
  mounted() {
    this.fetchAnnouncements()
  },
  methods: {
    fetchAnnouncements() {
      fetch('/announcements_public')
      .then(response => response.json())
      .then(data => {
        if (data.length > 0) {
            this.announcements = data
        }
      })
    }
  }
}
</script>
<template>
  <b-navbar fixed-top transparent shadow>
    <template slot="brand">
      <b-navbar-item href="/">
        <img :src="logoUrl || $options.defaultLogo" alt="mutual-aid-app logo" height="300px">
      </b-navbar-item>
    </template>

    <template slot="start">
      <b-navbar-item href="/about">About</b-navbar-item>
      <b-navbar-item href="/community_resources">Community Resources</b-navbar-item>
      <b-navbar-item href="/announcements">Announcements</b-navbar-item>
    </template>

    <template slot="end">
      <b-navbar-item tag="div" v-if="visible('Feedback')">
        <FeedbackButton action="software_feedbacks/new">Feedback</FeedbackButton>
      </b-navbar-item>
      <b-navbar-item href="/contributions" v-if="visible('Contributions')">Contributions</b-navbar-item>
      <b-navbar-item href="/matches" v-if="visible('Matches')">Matches</b-navbar-item>
      <b-navbar-item href="/admin" v-if="visible('Admin')">Admin</b-navbar-item>
      <b-navbar-item tag="div" v-if="visible('Login')">
        <a href="/users/sign_in" class="button is-outlined">Login</a>
      </b-navbar-item>
      <b-navbar-item tag="div" v-if="visible('Logout')">
        <DeleteButton action="/users/sign_out">Logout</DeleteButton>
      </b-navbar-item>
    </template>
  </b-navbar>
</template>

<script>
import logo from 'images/logo.png'
import {DeleteButton} from 'components/forms'
import {FeedbackButton} from 'components/forms'

export default {
  props: {
    logoUrl: { type: String },
    visibleButtons: { type: Array, default: [] },
  },
  components: {
    DeleteButton,
    FeedbackButton
  },
  methods: {
    visible(button) {
      return this.visibleButtons.includes(button)
    },
  },

  defaultLogo: logo,
}
</script>


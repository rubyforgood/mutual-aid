<template>
  <b-navbar fixed-top transparent shadow>
    <template slot="brand">
      <b-navbar-item href="/">
        <img :src="$options.logo" alt="mutual-aid-app logo" height="300px">
      </b-navbar-item>
    </template>

    <template slot="start">
      <b-navbar-item href="/about">About</b-navbar-item>
      <b-navbar-item href="/share">Share</b-navbar-item>
      <b-navbar-item href="/community_resources_list">Community Resources</b-navbar-item>
      <b-navbar-item href="/news">Announcements</b-navbar-item>
    </template>

    <template slot="end" v-if="loggedIn">
      <b-navbar-item href="/users/edit">Account</b-navbar-item>
      <b-navbar-item href="/admin">Admin</b-navbar-item>
      <b-navbar-item tag="div">
        <DeleteButton action="users/sign_out">Logout</DeleteButton>
      </b-navbar-item>
    </template>
    <template slot="end" v-else>
      <b-navbar-item tag="div">
        <a href="/users/sign_in" class="button is-outlined">Login</a>
      </b-navbar-item>
    </template>
  </b-navbar>
</template>

<script>
import logo from 'images/logo.png'
import DeleteButton from './DeleteButton'

export default {
  props: {
    loggedIn: Boolean,
  },
  components: {
    DeleteButton,
  },
  logo: logo,
}
</script>


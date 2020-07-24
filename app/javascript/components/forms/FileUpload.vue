<template>
  <b-field class="file has-name is-fullwidth">
    <b-upload
      v-model="file"
      :name="fieldName"
      accept=".csv,text/plain"
      required
      native
      expanded
    >
      <a class="file-cta">
        <b-icon class="file-icon" icon="upload"></b-icon>
        <span class="file-label">Click to select file</span>
      </a>
    </b-upload>

    <span class="file-name">
      {{ file ? file.name : 'Select a file ...' }}
    </span>
  </b-field>
</template>

<script>
export default {
  props: {
    fieldName: String,
  },
  data() {
    return {file: null}
  },
}
</script>

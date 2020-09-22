<template>
  <section class="MapBrowser">
    <div id='map'></div>

  </section>
</template>

<script>
mapboxgl.accessToken = 'pk.eyJ1IjoibWFyaWNyaXMtc24iLCJhIjoiY2sxcnlkOGJrMGFnbjNjbGc1NnN5Znh4NiJ9.d-U3XcJ1_OUfWImLfda4Fg'; // replace this with your access token
var map = new mapboxgl.Map({
  container: 'map',
  style: 'your-style-URL-here', // replace this with your style URL
  center: [-87.661557, 41.893748],
  zoom: 10.7
});
</script>

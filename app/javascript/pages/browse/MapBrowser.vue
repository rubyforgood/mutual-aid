<template>
  <section class="MapBrowser">
    <mapbox
        access-token="pk.eyJ1IjoibXV0dWFsLWFpZC1hcHAiLCJhIjoiY2tmZTBvd3UwMDBhbTJ4cDlic2JmMWZoaiJ9.rWscBjdl1SMT5N0yekIJYg"
        :map-options="{
          style: 'mapbox://styles/mapbox/streets-v11',
          center: [-75.1635262, 39.9527237],
          zoom: 9,
        }"
        :geolocate-control="{
          show: true,
          position: 'top-left',
        }"
        @map-load="loaded"
        @map-zoomend="zoomend"
        @map-click:points="clicked"
        @geolocate-error="geolocateError"
        @geolocate-geolocate="geolocate"
      />
  </section>
</template>

<script>
import Mapbox from 'mapbox-gl-vue'

export default {
  components: { Mapbox },
  methods: {
    loaded(map) {
      map.addLayer({
        id: 'points',
        type: 'symbol',
        source: {
          type: 'geojson',
          data: {
            type: 'FeatureCollection',
            features: [],
          },
        },
        layout: {
          'icon-image': '{icon}-15',
          'text-field': '{title}',
          'text-font': ['Open Sans Semibold', 'Arial Unicode MS Bold'],
          'text-offset': [0, 0.6],
          'text-anchor': 'top',
        },
      })
    },
    zoomend(map, e) {
      console.log('Map zoomed')
    },
    clicked(map, e) {
      const title = e.features[0].properties.title
      console.log(title)
    },
    geolocateError(control, positionError) {
      console.log(positionError)
    },
    geolocate(control, position) {
      console.log(
        `User position: ${position.coords.latitude}, ${position.coords.longitude}`
      )
    },
  },
}
</script>

<style>
  #map {
    width: 100%;
    height: 500px;
  }
</style>

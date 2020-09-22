<template>
  <section class="MapBrowser">
    <mapbox
        access-token="pk.eyJ1Ijoibml0cm8tbWFwLXRlYW0iLCJhIjoiY2tmZTJkYWV1MDBzYzMwbzM0a2VrbmhvZCJ9.oQhyoN77onZHe9otKsFAuw"
        :map-options="{
          style: 'mapbox://styles/mapbox/light-v9',
          center: [-96, 37.8],
          zoom: 3,
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
            features: [
              {
                type: 'Feature',
                geometry: {
                  type: 'Point',
                  coordinates: [-77.03238901390978, 38.913188059745586],
                },
                properties: {
                  title: 'Mapbox DC',
                  icon: 'monument',
                },
              },
              {
                type: 'Feature',
                geometry: {
                  type: 'Point',
                  coordinates: [-122.414, 37.776],
                },
                properties: {
                  title: 'Mapbox SF',
                  icon: 'harbor',
                },
              },
            ],
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

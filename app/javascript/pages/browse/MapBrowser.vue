<template>
  <section class="MapBrowser">
    <!-- FIXME Pull access-token via environment variable -->
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
      var geojson = {
        'type': 'FeatureCollection',
        'features': [
          {
            'type': 'Feature',
            'properties': {
              'message': 'Foo',
              'icon': 'harbor',
              'iconSize': [60, 60]
            },
            'geometry': {
              'type': 'Point',
              'coordinates': [-75.1635262, 39.9527237]
            }
          },
        ]
      }

      map.addLayer({
        id: 'points',
        type: 'symbol',
        source: {
          type: 'geojson',
          data: geojson,
        },
        layout: {
          'icon-image': '{icon}-15',
          'text-field': '{title}',
          'text-font': ['Open Sans Semibold', 'Arial Unicode MS Bold'],
          'text-offset': [0, 0.6],
          'text-anchor': 'top',
        },
      })

      geojson.features.forEach(function (marker) {
        var el = document.createElement('div');
        el.className = 'marker';
        el.style.backgroundImage =
        'url(https://placekitten.com/g/5/5/)';
        el.style.width = marker.properties.iconSize[0] + 'px';
        el.style.height = marker.properties.iconSize[1] + 'px';

        el.addEventListener('click', function () {
          window.alert(marker.properties.message);
        });

        new mapboxgl.Marker(el)
          .setLngLat(marker.geometry.coordinates)
          .addTo(map);
      });
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

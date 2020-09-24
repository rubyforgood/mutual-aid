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
const mbxClient = require('@mapbox/mapbox-sdk');
const geoCoding = require('@mapbox/mapbox-sdk/services/geocoding');

const baseClient = mbxClient({ accessToken: "pk.eyJ1IjoibXV0dWFsLWFpZC1hcHAiLCJhIjoiY2tmZTBvd3UwMDBhbTJ4cDlic2JmMWZoaiJ9.rWscBjdl1SMT5N0yekIJYg" });
const geoCodingService = geoCoding(baseClient)

export default {
  props: {
    contributions: {type: Array, default: () => []},
    filters: Object,
  },
  components: { Mapbox },
  methods: {
    loaded(map) {
      let geojson = {
        'type': 'FeatureCollection',
        'features': [
          {
            'type': 'Feature',
            'properties': {
              'title': 'Contributions Title', // contributions.title
              'description': 'Contributions Description', // contributions.description
              'categoryTag': 'First category', // contributions.category_tags (first element)
              'urgency': 'Contributions Urgency', // contributions.urgency
              'iconSize': [60, 60],
              'contributionType': 'offer', // contributions.contribution_type
            },
            'geometry': {
              'type': 'Point',
              'coordinates': [-75.1635262, 39.9527237]
            }
          }, 
        ]
      }

      const buildGeoJson = () => {
        return new Promise((resolve) => {
          let forwarded = 0

          this.contributions.forEach(contribution => {
            console.log("contribution", contribution)
            // this is where we build the address to search for
            let features = []
            geoCodingService.forwardGeocode({
              query: 'Chester, PA',
              limit: 1
            }).send()
              .then(response => {
                ++forwarded

                const match = response.body;

                console.log("match", match.features)
                // console.log("g.f", geojson.features)

                geojson.features = [ ...geojson.features, {
                  'type': 'Feature',
                  'properties': {
                    'title': contribution.name,
                    'description': contribution.description,
                    'categoryTag': 'First category', // contributions.category_tags (first element)
                    'urgency': contribution.urgency,
                    'icon': 'harbor',
                    'iconSize': [60, 60],
                    'contributionType': contribution.contribution_type,
                  },
                  'geometry': {
                    'type': 'Point',
                    'coordinates': match.features[0].center
                  }
                } ]

                console.log("geojson-after-update", geojson)
              })
              .then(() => {
                console.log("geojson", geojson)
                if (forwarded === this.contributions.length) resolve()
                // map.addLayer({
                //   id: 'points',
                //   type: 'symbol',
                //   source: {
                //     type: 'geojson',
                //     data: geojson,
                //   },
                //   layout: {
                //     'text-font': ['Open Sans Semibold', 'Arial Unicode MS Bold'],
                //     'text-offset': [0, 0.6],
                //     'text-anchor': 'top',
                //   },
                // })

                // geojson.features.forEach(function (marker) {
                //   console.log("marker", marker)
                //   var el = document.createElement('div');
                //   el.className = 'marker ' + marker.properties.contributionType + '-marker';
                //   el.style.width = marker.properties.iconSize[0] + 'px';
                //   el.style.height = marker.properties.iconSize[1] + 'px';

                //   new mapboxgl.Marker(el)
                //     .setLngLat(marker.geometry.coordinates)
                //     .setPopup(new mapboxgl.Popup({ offset: 35 })
                //     .setHTML('<h3>' + marker.properties.title + '</h3><p>' + marker.properties.categoryTag + '</p><p>' + marker.properties.description + '</p>'))
                //     .addTo(map);
                // });

              })
            })
          })
      }

      buildGeoJson()
        .then(() => {
          map.addLayer({
            id: 'points',
            type: 'symbol',
            source: {
              type: 'geojson',
              data: geojson,
            },
            layout: {
              'text-font': ['Open Sans Semibold', 'Arial Unicode MS Bold'],
              'text-offset': [0, 0.6],
              'text-anchor': 'top',
            },
          })

          geojson.features.forEach(function (marker) {
            var el = document.createElement('div');
            el.className = 'marker ' + marker.properties.contributionType + '-marker';
            el.style.width = marker.properties.iconSize[0] + 'px';
            el.style.height = marker.properties.iconSize[1] + 'px';

            const newMarker = new mapboxgl.Marker(el)
              .setLngLat(marker.geometry.coordinates)
              .setPopup(new mapboxgl.Popup({ offset: 35 })
              .setHTML('<h3>' + marker.properties.title + '</h3><p>' + marker.properties.categoryTag + '</p><p>' + marker.properties.description + '</p>'))

            newMarker.addTo(map)
          })
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

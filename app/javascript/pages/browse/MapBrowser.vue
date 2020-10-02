<template>
  <section class="MapBrowser">
    <!-- FIXME Pull access-token via environment variable -->
    <mapbox
      :access-token= this.accessToken
      :map-options="{
        style: 'mapbox://styles/mapbox/streets-v11',
        center: [-96, 37.8],
        zoom: 4,
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
  //  FIXME Attempt to pass accessToken in script tag as seen in line 6
  const baseClient = mbxClient({ accessToken: "pk.eyJ1IjoibXV0dWFsLWFpZC1hcHAiLCJhIjoiY2tmZTBvd3UwMDBhbTJ4cDlic2JmMWZoaiJ9.rWscBjdl1SMT5N0yekIJYg"});
  const geoCodingService = geoCoding(baseClient)

  export default {
    props: {
      accessToken: String,
      contributions: {type: Array, default: () => []},
      filters: Object,
    },
    components: { Mapbox },
    methods: {
      loaded(map) {
        let geojson = {
          'type': 'FeatureCollection',
          'features': []
        }

        const buildGeoJson = () => {
          return new Promise((resolve) => {
            let forwarded = 0

            this.contributions.forEach(contribution => {
              geoCodingService.forwardGeocode({
                query: `${contribution.location && contribution.location.street_address ? contribution.location.street_address : ""} ${contribution.service_area.location.city} ${contribution.service_area.location.state} ${contribution.service_area.location.zip_code}`,
                limit: 1
              }).send()
                .then(response => {
                  ++forwarded

                  const match = response.body;

                  geojson.features = [ ...geojson.features, {
                    'type': 'Feature',
                    'properties': {
                      'title': contribution.name,
                      'description': contribution.description ? contribution.description : "",
                      'categoryTag': contribution.category_tags[0].name,
                      'urgency': contribution.urgency ? contribution.urgency : "",
                      'icon': 'harbor',
                      'iconSize': [50, 50],
                      'contributionType': contribution.contribution_type,
                    },
                    'geometry': {
                      'type': 'Point',
                      'coordinates': match.features[0].center
                    }
                  } ]
                })
                .then(() => {
                  if (forwarded === this.contributions.length) resolve()
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
              el.className = 'marker ' + marker.properties.contributionType.toLowerCase() + '-marker';
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

class Mapping

  constructor: ->
    if $('#map').length == 1 && GBrowserIsCompatible()
      @icon = new GIcon(G_DEFAULT_ICON)
      @mapListing = $('#map-pub-listing')
      @markers = []
      @clustering_on = true
      @showMap()

  showMap: ->
    @map = new GMap2($('#map')[0])
    @map.setCenter(new GLatLng(54, -1), 6)
    @map.addControl(new GLargeMapControl())
    @addPubsToMap()
    @centerToParams()
    @addMapListeners()

  addPubsToMap: ->
    $.getJSON '/pubs.json', (pubs)=>
      this.addPubToMap pub for pub in pubs

      @markerCluster = new MarkerClusterer(@map, @markers, {gridSize: 80, maxZoom: 14})

  addPubToMap: (json)->
    pub = json.pub
    location = new GLatLng(pub.lat, pub.lng)
    marker = @createMarker(location, pub.id)
    @markers.push(marker)

  centerToParams: ->
    if $.query.get('lat') && $.query.get('lng')
      #coordinates in the query string, lets zoom in (cluster bug present when load map sratignht to this position)
      @map.setCenter(new GLatLng($.query.get('lat'), $.query.get('lng')), 16)

  createMarker: (location, pubId, number)->
    icon = @numberedIcon(number) if number
    marker = new GMarker(location, icon)
    GEvent.addListener marker, "click", =>
      @openPubMarkerInfo(marker, pubId)
    return marker

  addMapListeners: ->
    GEvent.addListener @map, "zoomend", =>
      @map.clearOverlays();

    GEvent.addListener @map, "moveend", (overlay, point)=>
      curzoom = @map.getZoom()
      if curzoom >= 14
        #we are zoomed in, dynamically update numbered markers
        if @clustering_on
          @markerCluster.turn_off()
          @map.clearOverlays()
          @clustering_on = false #set flag so if we zoom out again, clustering gets restarted
        @updateNonClusteredMarkers()
      else
        #we are zoomed out, just use the clustering
        unless @clustering_on
          @mapListing.html('') #remove anything in the bottom table
          @clustering_on = true #set flag again so we don't keep clustering
          @markerCluster.turn_back_on()

  openPubMarkerInfo: (marker, id)->
    $.get "/pubs/#{id}/map_marker_html", (html)->
      marker.openInfoWindowHtml(html)

  numberedIcon: (number)->
    icon = new GIcon()
    icon.image            = "/assets/markers/marker" + number + ".png"
    icon.iconSize         = new GSize(20,34)
    icon.iconAnchor       = new GPoint(16,32)
    icon.infoWindowAnchor = new GPoint(16, 0)
    icon

  updateNonClusteredMarkers: ->
    bounds = @map.getBounds()
    southWest = bounds.getSouthWest()
    northEast = bounds.getNorthEast()
    $.ajax
      type: 'GET'
      url: '/pubs.js'
      dataType: 'script'
      data:
        min_lat: southWest.lat(), max_lat: northEast.lat(),
        min_lng: southWest.lng(), max_lng: northEast.lng()

$(document).ready ->
  window.mapping = new Mapping

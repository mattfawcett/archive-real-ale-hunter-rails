$(document).ready(function(){
  initialize();
});


function initialize() {

  if(GBrowserIsCompatible()) {
    var map = new GMap2(document.getElementById('map'));
    map.setCenter(new GLatLng(54, -1), 6);
    map.addControl(new GLargeMapControl());
    var icon = new GIcon(G_DEFAULT_ICON);  
    var markers = [];   
    
    
    $.getJSON('/pubs.json','', function(json)
   	{
			for (x in json) 
			{
			  var latlng = new GLatLng(json[x].pub.lat, json[x].pub.lng);        
				marker = createMarker(latlng, json[x].pub.id);
    
				markers.push(marker);     
      }
      
      var markerCluster = new MarkerClusterer(map, markers, {gridSize: 50, maxZoom: 12});
    });
    
  }
  
  //create a marker object for the cluster
  function createMarker(point, pub_id)
	{
		var marker = new GMarker(point, icon);
		// Show this markers index in the info window when it is clicked
		GEvent.addListener(marker, "click", function() {marker.openInfoWindowHtml(marker_info_window_html_for_pub(pub_id));});
		return marker;
	};
	
	//for a particular pub_id, generate the HTMl for its overlay
	function marker_info_window_html_for_pub(pub_id)
	{
		alert(pub_id);
	}
		
}

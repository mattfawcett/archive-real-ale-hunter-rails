$(document).ready(function(){
  initialize();
});


function initialize() {

  if(GBrowserIsCompatible()) {
    var map = new GMap2(document.getElementById('map'));
    map.setCenter(new GLatLng(54, -1), 6);
    map.addControl(new GLargeMapControl());
    var icon = new GIcon(G_DEFAULT_ICON);
    //icon.image = "http://labs.google.com/ridefinder/images/mm_20_red.png";    
    var markers = [];   
    
    
    $.getJSON('/pubs.json','', function(json)
   	{
			for (x in json) 
			{
			  var latlng = new GLatLng(json[x].pub.lat, json[x].pub.lng);        
				marker = createMarker(latlng, html = json[x].pub.name);
    
				markers.push(marker);     
      }
      
      var markerCluster = new MarkerClusterer(map, markers, {gridSize: 50, maxZoom: 12});
    });
    
  }
  
  function createMarker(point, html)
	{
		var marker = new GMarker(point, icon);
		// Show this markers index in the info window when it is clicked
		GEvent.addListener(marker, "click", function() {marker.openInfoWindowHtml(html);});
		return marker;
	};
		
}

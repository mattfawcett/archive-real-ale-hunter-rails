$(document).ready(function(){
  initialize();
});


var icon = new GIcon(G_DEFAULT_ICON);  
var markers = [];
var markerCluster;
var clustering_on = true;
var map;
function initialize() {

  if(GBrowserIsCompatible()) {
    
    map = new GMap2(document.getElementById('map'));
    map.setCenter(new GLatLng(54, -1), 6);
    map.addControl(new GLargeMapControl());
    
    $.getJSON('/pubs.json','', function(json)
   	{
			for (x in json) 
			{
			  var latlng = new GLatLng(json[x].pub.lat, json[x].pub.lng);        
				marker = createMarker(latlng, json[x].pub.id);
				markers.push(marker);     
      }
      markerCluster = new MarkerClusterer(map, markers, {gridSize: 50, maxZoom: 14});
    });
    
    GEvent.addListener(map, "zoomend", function(overlay, point)
 	  {
      map.clearOverlays(); 
    });
    
    GEvent.addListener(map, "moveend", function(overlay, point)
	  {			
			var curzoom = map.getZoom();
			if(curzoom >= 14)
			{
				//we are zoomed in, dynamically update numbered markers	
		    if(clustering_on){
				  markerCluster.turn_off();
				  map.clearOverlays();
          clustering_on = false; //set flag so if we zoom out again, clustering gets restarted        
        }
        update_non_clustered_markers();
			}
			else
			{
				//we are zoomed out, just use the clustering
				if(!clustering_on){
					$('#map-pub-listing').html(''); //remove anything in the bottom table
					clustering_on = true; //set flag again so we don't keep clustering
          markerCluster.turn_back_on();
				}
			}
		});				    
  }
}


//create a marker object for the cluster, (if a number is passed in then a numbered icon will be used)
function createMarker(point, pub_id, number)
{
  if(number)
	{
  	var icon = numbered_icon(number);
		var marker = new GMarker(point, icon);			
	}
	else
	{
    var marker = new GMarker(point, icon);
	}
		
	GEvent.addListener(marker, "click", function() {marker.openInfoWindowHtml(marker_info_window_html_for_pub(pub_id));});
	return marker;
};
	
//for a particular pub_id, generate the HTMl for its overlay
function marker_info_window_html_for_pub(pub_id)
{
	var html = '';
	$.ajax({
    type: 'GET',
    url: '/pubs/' + pub_id + '.json',
    dataType: 'json',
    success: function(json) {
      html = html + '<strong><a target="_blank" href="/pubs/' + json.pub.slug.slug.name + '">' + json.pub.name + '</a></strong><br/>';              
      html = html + json.pub.address_1 + '<br/>';
      if(json.pub.address_2){
        html = html + json.pub.address_2 + '<br/>';
      }
      html = html + json.pub.town + '<br/>';
      html = html + json.pub.post_code + '<br/>';
      html = html + json.pub.telephone + '<br/>';
    },
    data: {},
    async: false
  });
  return html;
}


// gets called when zoom level is >= 14, use ajax to get more information on pubs for this
// zoomed in area
function update_non_clustered_markers()
{
  var bounds = map.getBounds();
	var southWest = bounds.getSouthWest();
  var northEast = bounds.getNorthEast();	
	$.ajax({
    type: 'GET',
    url: '/pubs.js',
    dataType: 'script',
    data: {min_lat: southWest.lat(), max_lat: northEast.lat(), 
           min_lng: southWest.lng(), max_lng: northEast.lng()}
  });
}

function numbered_icon(number)
{
	var icon = new GIcon();	
	icon.image="http://www.realalehunter.co.uk/img/markers/marker" + number + ".png";
	icon.iconSize=new GSize(20,34);
	icon.iconAnchor=new GPoint(16,32);
	icon.infoWindowAnchor=new GPoint(16, 0);	
 	return icon;	
}

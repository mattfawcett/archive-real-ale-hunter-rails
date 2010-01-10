function change_id_of_dynamically_added_field(html, new_id)
{
	html = html.replace(/attributes_(\d)+/g, "attributes_" + new_id);
	html = html.replace(/attributes\]\[(\d)+\]/g, "attributes][" + new_id + "]");
	return html;
}
jQuery(function($) {
	jQuery("a[rel^='lightbox']").slimbox({}, 
										 function(el) {
										   var title = el.title + " | <a href=\"" + el.href.replace("medium", "original") + "\" target=\"_blank\">Download Original</a>";
										   return [el.href, title];
										 }
	);
});


$(document).ready(function() {
    //decide whether top nav should reflect logged in or logged out
	if($.cookie('phpbb3_7uah4_u') != undefined && $.cookie('phpbb3_7uah4_u') > 1)
	{
		$('#top-menu-logged-in').show();
		$('#top-menu-logged-out').hide();
	}
	else
	{
		$('#top-menu-logged-in').hide();
		$('#top-menu-logged-out').show();
	}
});

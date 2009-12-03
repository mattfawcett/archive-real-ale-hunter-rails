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
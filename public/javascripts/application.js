function change_id_of_dynamically_added_field(html, new_id)
{
	html.replace(/attributes_0/g, "attributes_" + new_id)
}
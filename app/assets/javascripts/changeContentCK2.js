function changeContent(rt) {

	if (rt == "1") {
		document.getElementById("content_area").innerHTML = '<p><label for="resource_res"> Document</label>  <input id="resource_res" name="resource[res]" size="30" type="file" </p>';
			}
	if (rt == "2") {
		document.getElementById("content_area").innerHTML = '<p><label for="res_file_name">URL</label><br /><input type="text" id="resource_res_file_name" name="resource[res_file_name]" size="80" maxlength="254"> <span class="instructions"> e.g. http://www.amazon.com</span></p>';
	}
	if (rt == "3") {
		document.getElementById("content_area").innerHTML = '<input type="hidden" id="resource_res_file_name" name="resource[res_file_name]" value="Text">';
	}
}

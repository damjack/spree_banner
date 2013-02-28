$(document).ready(function() {

  $('.destroy_banner_style').on("click", function() {
   $(this).parent().remove();
  });

  // Handle adding new styles
  var styles_hash_index = 1;
  $('.add_banner_style').click(function() {
    $('#styles_list').append(generate_html_for_hash("new_banner_styles", styles_hash_index));
  });

  // Generates html for new paperclip styles form fields
  generate_html_for_hash = function(hash_name, index) {
    var html = '<li>';
    html += '<label for="' + hash_name + '_' + index + '_name">';
    html += 'Name</label>';
    html += '<input id="' + hash_name + '_' + index + '_name" name="' + hash_name + '[' + index + '][name]" type="text">';
    html += '<label for="' + hash_name + '_' + index + '_value">';
    html += 'Value</label>';
    html += '<input id="' + hash_name + '_' + index + '_value" name="' + hash_name + '[' + index + '][value]" type="text">';
    html += '<a href="#" alt="Destroy" class="destroy_banner_style">&nbsp;x</a>';
    html += '</li>';

    index += 1;
    return html;
  };



});

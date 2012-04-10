Deface::Override.new(
  :virtual_path => "spree/layouts/admin",
  :name => "include_tinymce_js",
  :insert_bottom => "[data-hook='admin_inside_head'], #admin_inside_head[data-hook]",
  :text => "<%= render :partial => 'partials/tinymce_javascript' -%>"
)
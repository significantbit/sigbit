$.attachinary.config.template = """
  <div class="row attachinary_file_list">
    <% for(var i=0; i < files.length; i++) { %>
      <div class="col-md-12 attachinary-file-item" style="margin-bottom:30px;">
        <% if(files[i].resource_type == "raw") { %>
          <div class="raw-file"></div>
        <% } else { %>
          <img
            src="<%= $.cloudinary.url(files[i].public_id, { "version": files[i].version, "format": "jpg", "crop": "pad", "width": 500, "height": 400 }) %>"
            alt="" class="img-fluid" />
        <% } %>
        <a href="#" data-remove="<%= files[i].public_id %>" class="attachinary-remove-btn btn btn-danger btn-sm"><i class="fa fa-trash"></i></a>
      </div>
    <% } %>
  </div>
"""

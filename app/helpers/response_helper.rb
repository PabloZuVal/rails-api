module ResponseHelper

    # success
  
    def welcome_render()
      success_render('Ok', 200, nil, nil)
    end
  
    def ok_render(resource, data = nil)
      success_render('Ok', 200, resource, data)
    end
  
    def found_render(resource, data, page = nil, per_page = nil, total = nil)
      success_render('Found', 200, resource, data, page, per_page, total)
    end
  
    def found_many_render(resource, data, page = nil, per_page = nil, total = nil)
      success_render('Found', 200, resource, data, page, per_page, total)
    end
  
    def create_resource_render(resource, data)
      success_render('Created', 201, resource, data) {}
    end
  
    def update_resource_render(resource, data)
      success_render('Updated', 200, resource, data)
    end
  
    def already_canceled_render(resource, data)
      success_render('Already canceled', 200, resource, data)
    end
  
    def canceled_render(resource, data)
      success_render('Canceled', 200, resource, data)
    end
  
    def paused_render(resource, data)
      success_render('Paused', 200, resource, data)
    end
  
    def already_paused_render(resource, data)
      success_render('Already paused', 200, resource, data)
    end
  
    def resumed_render(resource, data)
      success_render('Resumed', 200, resource, data)
    end
  
    def already_resumed_render(resource, data)
      success_render('Already resumed', 200, resource, data)
    end
  
    # fail
  
    def duplicate_resource_render(resource, message)
      fail_render('Duplicated', 409, resource, message)
    end
  
    def duplicate_resource_render_without_payload(resource)
      fail_render('Duplicated', 409, resource, nil)
    end
  
    def creation_fail_render(resource, errors)
      fail_render('Fail', 422, resource, errors)
    end
  
    def not_found_render(resource)
      fail_render('Not found', 404, resource, nil)
    end
  
    def not_exists_render(resource, errors)
      fail_render('Not exists', 404, resource, errors)
    end
  
    def bad_request(resource, errors)
      fail_render('Bad request', 400, resource, errors)
    end
  
    def unauthorized_response(resource, errors)
      fail_render('Unauthorized', 401, resource, errors)
    end
  
    def forbidden_response
      fail_render('Forbidden', 403, nil, nil)
    end
  
    private
  
    def success_render(message, code, resource, data, page=nil, per_page=nil, total=nil)
      render json: {
        code: code,
        resource: resource,
        data: data,
        message: message,
        page: page,
        per_page: per_page,
        total: total
      }.compact, status: code
    end
  
    def fail_render(message, code, resource, errors)
      render json: {
        code: code,
        resource: resource,
        message: message,
        errors: errors
      }.compact, status: code
    end
  end
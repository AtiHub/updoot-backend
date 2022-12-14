class ApplicationController < ActionController::API
  rescue_from Exception do |error|
    render(json: { errors: [{ message: error.to_s }] }, status: 422)
  end
end

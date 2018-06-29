class ApplicationController < ActionController::Base
    def after_sign_in_path_for(resource)
        request.env['omniauth.origin'] || root_path
    end

    rescue_from CanCan::AccessDenied do |exception|
        redirect_to root_url, alert: exception.message
    end
end

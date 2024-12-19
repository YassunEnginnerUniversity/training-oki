class ApplicationController < ActionController::API
  include ActionController::Cookies

  private

  def authenticate_user!
    unless session[:user_id]
      render json: { error: I18n.t('errors.authentication.unauthorized') }, status: :unauthorized
    end
  end

  def current_user
    return @current_user if @current_user
    if (user_id = session[:user_id])
      @current_user = User.find_by(id: user_id)
    end
  end

  def handle_parse_error(exception)
    render json: { error: I18n.t('errors.request.invalid_json') }, status: :bad_request
  end

  def handle_parameter_missing(exception)
    render json: { error: I18n.t('errors.request.invalid_parameters') }, status: :unprocessable_entity
  end

  def handle_record_not_found(exception)
    error_message = case exception.model
    when "Post"
      I18n.t('errors.posts.not_found')
    when "Comment"
      I18n.t('errors.comments.not_found')
    else
      I18n.t('errors.users.not_found')
    end
    render json: { error: error_message }, status: :not_found
  end
end

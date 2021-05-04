module ApplicationControllerHelper
  def get_user_params_from_decoded_token(decoded_token)
    t = decoded_token[0]
    user_params = {}
    user_params[:provider] = t['iss']
    user_params[:uid] = t['sub']
    user_params[:email] = t['email']
    user_params[:name] = t['name']
    user_params[:picture] = t['picture']
    return user_params 
  end
end
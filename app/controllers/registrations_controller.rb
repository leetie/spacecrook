class RegistrationsController < Devise::RegistrationsController
  def update_resource(resource, params)
    # puts "*" * 100
    # puts request.inspect
    if request.referer.present? && request.referer.include?('profile')
      resource.update_without_password(params)
    elsif resource.provider != nil
      params.delete("current_password")
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
    # if resource.provider != nil
    #   params.delete("current_password")
    #   resource.update_without_password(params)
    # else
    #   resource.update_with_password(params)
    # end
  end
end
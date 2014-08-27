class UserIdNumberController < ApplicationController

  def edit
    unless authenticated?(
      :web => _("To change your email address used on {{site_name}}", :site_name => site_name),
      :email => _("Then you can change your email address used on {{site_name}}", :site_name => site_name),
      :email_subject => _("Change your email address used on {{site_name}}",:site_name => site_name)
    )
      # "authenticated?" has done the redirect to signin page for us
      return
    end
  end

  def update
    if @user.update_attributes(:id_number => params[:user][:id_number])
      redirect_to show_user_profile_path(:url_name => @user.url_name)
    else
      render :edit
    end
  end

end

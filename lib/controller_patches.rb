# Add a callback - to be executed before each request in development,
# and at startup in production - to patch existing app classes.
# Doing so in init/environment.rb wouldn't work in development, since
# classes are reloaded, but initialization is not run each time.
# See http://stackoverflow.com/questions/7072758/plugin-not-reloading-in-development-mode
#
Rails.configuration.to_prepare do
    HelpController.class_eval do
        def terms_of_use
        end

        def privacy_policy
        end
    end

    UserController.class_eval do
      def signin
          @user = User.new
          @user.build_general_law

          work_out_post_redirect
          @request_from_foreign_country = country_from_ip != AlaveteliConfiguration::iso_country_code
          # make sure we have cookies
          if session.instance_variable_get(:@dbman)
              if not session.instance_variable_get(:@dbman).instance_variable_get(:@original)
                  # try and set them if we don't
                  if !params[:again]
                      redirect_to signin_url(:r => params[:r], :again => 1)
                      return
                  end
                  render :action => 'no_cookies'
                  return
              end
          end
          # remove "cookie setting attempt has happened" parameter if there is one and cookies worked
          if params[:again]
              redirect_to signin_url(:r => params[:r], :again => nil)
              return
          end

          if not params[:user_signin]
              # First time page is shown
              render :action => 'sign'
              return
          else
              if !@post_redirect.nil?
                  @user_signin = User.authenticate_from_form(params[:user_signin], @post_redirect.reason_params[:user_name] ? true : false)
              end
              if @post_redirect.nil? || @user_signin.errors.size > 0
                  # Failed to authenticate
                  render :action => 'sign'
                  return
              else
                  # Successful login
                  if @user_signin.email_confirmed
                      session[:user_id] = @user_signin.id
                      session[:user_circumstance] = nil
                      session[:remember_me] = params[:remember_me] ? true : false

                      if is_modal_dialog
                          render :action => 'signin_successful'
                      else
                          do_post_redirect @post_redirect
                      end
                  else
                      send_confirmation_mail @user_signin
                  end
                  return
              end
          end
      end

      def signup
        work_out_post_redirect

        @request_from_foreign_country = country_from_ip != AlaveteliConfiguration.iso_country_code
        @user = User.new(params[:user])

        capture_error = false
        if @request_from_foreign_country && !verify_recaptcha
            capture_error = true
        end

        existing_user = User.find_user_by_email(params[:user][:email])
        if existing_user
            already_registered_mail(existing_user)
            return
        end

        if @user.save && !capture_error
            @user.email_confirmed = false
            send_confirmation_mail(@user)
            return
        else
            if capture_error
                flash.now[:error] = _("There was an error with the words you entered, please try again.")
            end

            render :action => 'sign'
        end
      end

    end

end

require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe UserIdNumberController do
  render_views

  describe :edit do

    before(:each) do
      @user = users(:bob_smith_user)
      session[:user_id] = @user.id
    end

    it 'requires login' do
      session[:user_id] = nil

      get :edit

      post_redirect = PostRedirect.get_last_post_redirect
      expect(response).to redirect_to(
        :controller => 'user',
        :action => 'signin',
        :token => post_redirect.token)
    end

    it 'finds the logged in user to edit' do
      get :edit
      expect(assigns[:user]).to eql(@user)
    end

    it 'renders the form for changing ID number' do
      get :edit
      expect(response).to render_template('edit')
    end

  end

  describe :update do

    before(:each) do
      @user = users(:bob_smith_user)
      session[:user_id] = @user.id
    end

    it 'changes the users ID number' do
      put :update, { :user => { :id_number => '123456789' } }

      expect(assigns[:user]).to eql(@user)
      expect(assigns[:user].id_number).to eql('123456789')
      expect(response).to redirect_to(show_user_profile_path(:url_name => @user.url_name))
    end

    it 'does not accept a blank ID number' do
      put :update, { :user => { :id_number => nil } }
      expect(response).to render_template('edit')
    end

  end

end

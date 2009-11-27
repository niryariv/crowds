# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def login_button
    form_tag session_url, {:style=>'text-align:bottom;'} do
       hidden_field_tag("openid_identifier", "https://www.google.com/accounts/o8/id") +
       image_submit_tag("openid/googleW.png")
    end
  end

end

# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  def login_button
    form_tag session_url, { :id => 'login-button' } do
       hidden_field_tag("openid_identifier", "https://www.google.com/accounts/o8/id") +
       image_submit_tag("openid/googleW.png")
    end
  end
  
  def sharethis_button
      '<script type="text/javascript" src="http://w.sharethis.com/button/sharethis.js#publisher=3675c913-7ace-4cb1-b80d-200793078aed&amp;type=website&amp;buttonText=Share&amp;post_services=email%2Cfacebook%2Ctwitter%2Cmyspace%2Cdigg%2Cdelicious%2Cstumbleupon%2Creddit%2Clinkedin%2Cblogger%2Cwordpress%2Cnewsvine%2Clivejournal%2Ctypepad"></script>'
  end

  def share_link(url)
      '<script language="javascript" type="text/javascript">SHARETHIS.addEntry({title:"share"}, {button:true} );</script>'
  end
  
end

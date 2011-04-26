module HelperMethods 

  def random_email
    random_token.split("").insert(random_token.length / 2, "@").push(".com").join("")
  end
  
  def random_token
    Digest::SHA1.hexdigest((Time.now.to_i * rand).to_s)
  end
  
end
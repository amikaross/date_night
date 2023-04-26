class ErrorSerializer
  def self.bad_request(messages)
    {
      "message": "Bad Request",
      "errors": messages
    }
  end

  def self.bad_credentials
    {
      "message": "Bad Credentials",
      "errors": ["Email or password is incorrect."]
    }
  end

  def self.not_found(resource) 
    {
      "message": "Resource Not Found",
      "errors": ["#{resource} does not exist."]
    }
  end

  def self.not_authorized
    {
      "message": "Not Authorized",
      "errors": ["Authorization to access this resource has not been received."]
    }
  end
end
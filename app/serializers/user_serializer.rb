class UserSerializer
  include JSONAPI::Serializer 

  attributes :email, :location, :lat, :long, :radius
end
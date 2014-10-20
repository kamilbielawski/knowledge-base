json.array! @resources do |resource|
  json.partial! "api/v1/resources/show", resource: resource
end

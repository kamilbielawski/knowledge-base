json.array! @topics do |topic|
    json.partial! "api/v1/topics/show", topic: topic
end

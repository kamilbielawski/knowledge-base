angular.module('services').factory('Topic', ['$resource',
  ($resource)->
    $resource('/api/v1/topics/:topicId', {
      topicId: "@topic.id",
      format: 'json'
    },{
      update:
        method: 'PUT'
    })
])



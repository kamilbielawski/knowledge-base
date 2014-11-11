angular.module('services').factory('Resource', ['$resource',
  ($resource)->
    $resource('/api/v1/topics/:topicId/resources/:resourceId', {
      topicId: '@resource.topicId'
      resourceId: "@resource.id"
      format: 'json'
    },{
      update:
        method: 'PUT'
    })
])

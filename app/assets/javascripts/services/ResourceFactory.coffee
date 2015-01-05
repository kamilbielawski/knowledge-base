angular.module('services').factory('Resource', ['$resource',
  ($resource)->
    $resource('/api/v1/topics/:topicId/resources/:resourceId', {
      topicId: '@resource.topicId'
      resourceId: "@resource.id"
      format: 'json'
    },{
      update:
        method: 'PUT'
      vote_up:
        method: 'PUT'
        url: '/api/v1/resources/:resourceId/vote_up'
      vote_down:
        method: 'PUT'
        url: '/api/v1/resources/:resourceId/vote_down'
    })
])

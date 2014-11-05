angular.module('controllers').
  controller('ResourcesController', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    topicId = $routeParams.topicId
    Topic = $resource('/api/v1/topics/:topicId', { topicId: "@id", format: 'json' })
    Resource = $resource('/api/v1/topics/:topicId/resources/:resourceId',
                          {topicId: topicId, resourceId: "@id", format: 'json'})

    Topic.get({topicId: topicId}, (topic) -> $scope.topic = topic)
    Resource.query({}, (results) -> $scope.resources = results)
  ])

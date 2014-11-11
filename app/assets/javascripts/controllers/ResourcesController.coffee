angular.module('controllers').
  controller('ResourcesController', ['$scope', '$routeParams', '$location', '$resource', 'Topic', 'Resource'
  ($scope, $routeParams, $location, $resource, Topic, Resource)->
    topicId = $routeParams.topicId

    Topic.get({topicId: topicId}, (topic) -> $scope.topic = topic)
    Resource.query({topicId: topicId}, (results) -> $scope.resources = results)
  ])

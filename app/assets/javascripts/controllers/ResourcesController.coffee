angular.module('controllers').
  controller('ResourcesController', ['$scope', '$routeParams', '$location',
    '$resource', '$modal', 'Topic', 'Resource',
  ($scope, $routeParams, $location, $resource, $modal, Topic, Resource)->
    topicId = $routeParams.topicId

    Topic.get({topicId: topicId}, (topic) -> $scope.topic = topic)
    Resource.query({topicId: topicId}, (results) -> $scope.resources = results)

    $scope.openModal = ->
      modalInstance = $modal.open
        templateUrl: 'new_resource_modal.html'
        controller: 'NewResourceController'
        resolve:
          resources: => $scope.resources

    $scope.voteUp  = (resource)->
      resource.rating++

    $scope.voteDown  = (resource)->
      resource.rating--
  ])

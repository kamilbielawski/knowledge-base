angular.module('controllers').
  controller('ResourcesController', ['$scope', '$routeParams', '$location',
    '$resource', '$modal', 'localStorageService', 'Topic', 'Resource',
  ($scope, $routeParams, $location, $resource, $modal, localStorageService, Topic, Resource)->
    topicId = $routeParams.topicId

    Topic.get({topicId: topicId}, (topic) -> $scope.topic = topic)
    Resource.query({topicId: topicId}, (results) -> $scope.resources = results)

    $scope.openModal = ->
      modalInstance = $modal.open
        templateUrl: 'new_resource_modal.html'
        controller: 'NewResourceController'
        resolve:
          resources: => $scope.resources

    $scope.voteUp = (resource)=>
      resource_id = resource.id
      unless localStorageService.get("resource/#{resource_id}.voted")
        Resource.vote_up({resource: resource}, =>
          resource.rating++
          localStorageService.set("resource/#{resource_id}.voted", true)
        )

    $scope.voteDown = (resource)=>
      resource_id = resource.id
      unless localStorageService.get("resource/#{resource_id}.voted")
        Resource.vote_down({resource: resource}, =>
          resource.rating--
          localStorageService.set("resource/#{resource_id}.voted", true)
        )
  ])

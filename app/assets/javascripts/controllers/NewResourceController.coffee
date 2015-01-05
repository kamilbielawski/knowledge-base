angular.module('controllers').
  controller('NewResourceController', ['$scope', '$routeParams',
    '$resource', 'Resource', '$modalInstance', 'resources',
  ($scope, $routeParams, $resource, Resource, $modalInstance, resources)->
    $scope.resource = {topicId: $routeParams.topicId}

    $scope.add = ->
      $modalInstance.close()
      Resource.save(resource: this.resource, =>
        $scope.resource.created_at = new Date()
        $scope.resource.updated_at = new Date()
        $scope.resource.rating = 0
        resources.push($scope.resource)
      )

    $scope.cancel = ->
      $modalInstance.dismiss('cancel')
  ])

angular.module('controllers').
  controller('TopicsController', ['$scope', '$routeParams', '$location', '$resource', 'Topic'
  ($scope, $routeParams, $location, $resource, Topic)->
    $scope.allTopics = []
    Topic.query(all: true, (results) -> $scope.allTopics = results)

    $scope.search = (keywords)->
      topicId = ($scope.allTopics.filter (t)-> t.name == keywords)[0].id
      $location.path("/topic/#{topicId}/resources")
  ])

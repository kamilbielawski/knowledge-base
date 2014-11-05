angular.module('controllers').
  controller('TopicsController', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
    Topic = $resource('/api/v1/topics/:topicId', { topicId: "@id", format: 'json' })
    Topic.query(all: true, (results) -> $scope.allTopics = results)

    $scope.search = (keywords)->
      topicId = ($scope.allTopics.filter (t)-> t.name == keywords)[0].id
      $location.path("/topic/#{topicId}/resources")
  ])

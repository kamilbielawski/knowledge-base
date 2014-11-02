angular.module('controllers').
  controller('TopicsController', ['$scope', '$routeParams', '$location', '$resource',
  ($scope, $routeParams, $location, $resource)->
     $scope.search = (keywords)->  $location.path("/").search('keywords',keywords)
     Topic = $resource('/api/v1/topics/:topicId', { topicId: "@id", format: 'json' })

     if $routeParams.keywords
       Topic.query(keywords: $routeParams.keywords, (results)-> $scope.topics = results)
     else
       $scope.topics = []
])

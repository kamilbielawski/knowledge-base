app = angular.module('app', ['templates', 'ngRoute', 'ngResource', 'controllers'])

app.config([ '$routeProvider',
   ($routeProvider)->
     $routeProvider
       .when('/',
         templateUrl: "index.html"
         controller: 'TopicsController'
       )
       .when('/topic/:topicId/resources',
         templateUrl: 'resources.html'
         controller: 'ResourcesController'
       )
])

controllers = angular.module('controllers', [])

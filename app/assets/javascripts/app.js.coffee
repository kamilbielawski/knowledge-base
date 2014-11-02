app = angular.module('app', ['templates', 'ngRoute', 'ngResource', 'controllers'])

app.config([ '$routeProvider',
   ($routeProvider)->
     $routeProvider
       .when('/',
         templateUrl: "index.html"
         controller: 'TopicsController'
       )
])

controllers = angular.module('controllers', [])

angular.module('controllers').
  controller('NewResourceController', ['$scope', '$routeParams', '$resource', 'Resource'
  ($scope, $routeParams, $resource, Resource)->
    this.resource = {topicId: $routeParams.topicId}

    this.add = ()->
      Resource.save(resource: this.resource, ->
        console.log 'saved'
      )
  ])

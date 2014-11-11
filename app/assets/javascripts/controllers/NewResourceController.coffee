angular.module('controllers').
  controller('NewResourceController', ['$scope', '$routeParams', '$resource',
  ($scope, $routeParams, $resource)->
    topicId = $routeParams.topicId
    Resource = $resource('/api/v1/topics/:topicId/resources/:resourceId',
                          {topicId: topicId, resourceId: "@id", format: 'json'})

    this.resource = {}

    this.add = ()->
      Resource.save(resource: this.resource, ->
        console.log 'saved'
      )
  ])

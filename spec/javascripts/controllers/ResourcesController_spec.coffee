describe "ResourcesController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null
  resourcesResponse = null

  setupController = (options = {})->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.topicId = options.topicId if options.topicId?
      httpBackend = $httpBackend
      ctrl = $controller('ResourcesController',
                                $scope: scope
                                $location: location)

      topicRequest = new RegExp("\/topics\/#{routeParams.topicId}")
      httpBackend.expectGET(topicRequest).respond({id: 1, name: 'Ruby'})

      resourcesResponse = options.resourcesResponse || [
        {id: 1, name: 'Ruby-Doc'},
        {id: 2, name: 'Ruby Koans'},
        {id: 4, name: 'Ruby Tapas'},
        {id: 8, name: 'Learn Ruby the Hard Way'}
      ]
      resourcesRequest = new RegExp("\/topics\/#{routeParams.topicId}\/resources")
      httpBackend.expectGET(resourcesRequest).respond(resourcesResponse)
    )

  beforeEach(module('app'))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    beforeEach ->
      topicId = 1
      setupController({topicId: topicId})
      httpBackend.flush()
      location.path("/topic/#{topicId}/resources")

    it 'loads all resources for the requested topic', ->
      expect(scope.resources).toEqualData(resourcesResponse)




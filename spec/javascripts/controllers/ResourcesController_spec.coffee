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
        {id: 1, name: 'Ruby-Doc', rating: 10},
        {id: 2, name: 'Ruby Koans', rating: 8},
        {id: 4, name: 'Ruby Tapas', rating: 6},
        {id: 8, name: 'Learn Ruby the Hard Way', rating: 7}
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

  describe 'voting', ->
    beforeEach ->
      topicId = 1
      setupController({topicId: topicId})
      httpBackend.flush()
      location.path("/topic/#{topicId}/resources")

    it 'increases rating by 1 when voting up', ->
      votingRequest = new RegExp("resources\/#{scope.resources[0].id}\/vote_up")
      httpBackend.expectPUT(votingRequest).respond({status: 'ok'})
      oldRating = scope.resources[0].rating
      scope.voteUp(scope.resources[0])
      httpBackend.flush()
      expect(scope.resources[0].rating).toEqual(oldRating+1)

    it 'decreases rating by 1 when voting down', ->
      votingRequest = new RegExp("resources\/#{scope.resources[2].id}\/vote_down")
      httpBackend.expectPUT(votingRequest).respond({status: 'ok'})
      oldRating = scope.resources[2].rating
      scope.voteDown(scope.resources[2])
      httpBackend.flush()
      expect(scope.resources[2].rating).toEqual(oldRating-1)

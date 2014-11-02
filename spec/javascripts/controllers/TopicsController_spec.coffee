describe "TopicsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null

  setupController = (keywords, results)->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = keywords

      httpBackend = $httpBackend

      if results
        request = new RegExp("\/topics.*keywords=#{keywords}")
        httpBackend.expectGET(request).respond(results)

      ctrl = $controller('TopicsController',
                                $scope: scope
                                $location: location)
    )

  beforeEach(module("app"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach(setupController())

      it 'defaults to no topics', ->
        expect(scope.topics).toEqualData([])

    describe 'with keywords', ->
      keywords = 'ruby'
      topics = [
        {
          id: 1
          name: 'Ruby'
        },
        {
          id: 3
          name: 'Ruby on Rails'
        }
      ]
      beforeEach ->
        setupController(keywords, topics)
        httpBackend.flush()

      it 'calls the back-end', ->
        expect(scope.topics).toEqualData(topics)

    describe 'search()', ->
      beforeEach ->
        setupController()

      it 'redirects to itself with a keyword param', ->
        keywords = 'ruby'
        scope.search(keywords)
        expect(location.path()).toBe('/')
        expect(location.search()).toEqualData({keywords: keywords})


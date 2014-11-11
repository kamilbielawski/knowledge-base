describe "TopicsController", ->
  scope        = null
  ctrl         = null
  location     = null
  routeParams  = null
  resource     = null
  httpBackend  = null
  autocompleteResults = null

  setupController = (options = {})->
    inject(($location, $routeParams, $rootScope, $resource, $httpBackend, $controller)->
      scope       = $rootScope.$new()
      location    = $location
      resource    = $resource
      routeParams = $routeParams
      routeParams.keywords = options.keywords
      httpBackend = $httpBackend
      ctrl = $controller('TopicsController',
                                $scope: scope
                                $location: location)

      autocompleteResults = options.autocompleteResults || [
        {id: 1, name: 'Ruby'},
        {id: 2, name: 'Ruby on Rails'},
        {id: 3, name: 'JavaScript'},
        {id: 4, name: 'AngularJS'},
        {id: 5, name: 'CSS'}
      ]
      autocompleteRequest = new RegExp("\/topics.*all=true")
      httpBackend.expectGET(autocompleteRequest).respond(autocompleteResults)
    )

  beforeEach(module("app"))

  afterEach ->
    httpBackend.verifyNoOutstandingExpectation()
    httpBackend.verifyNoOutstandingRequest()

  describe 'controller initialization', ->
    describe 'when no keywords present', ->
      beforeEach ->
        setupController()
        httpBackend.flush()

      it 'loads list of all topics for autocomplete', ->
        expect(scope.allTopics).toEqualData(autocompleteResults)

    describe 'search()', ->
      beforeEach ->
        setupController()
        httpBackend.flush()

      it 'redirects to resources list with a keyword param', ->
        keywords = 'Ruby'
        scope.search(keywords)
        expect(location.path()).toBe('/topic/1/resources')


@app.controller "ServerSearchCtrl",
  class ServerSearchCtrl
    @$inject: ['ServerSearchState', 'Locations', 'Packages'] 
    
    constructor: (@state, @locationsQuery, @packages) ->
      @initializeLocations()

    initializeLocations: ->
      @locationsQuery.query (result) =>
        @state.locations.push(new models.Location(loc)) for loc in result
        @state.filteredLocationsArray = @state.filteredSortedLocations()
        @state.mapActiveLocation = @state.filteredLocationsArray[0]
        
    showVpsLocations: ->
      !@packages.activePackage and
      (Object.keys(@state.cloudVpsFilter).length is 0 or
       @state.cloudVpsFilter.budgetVps)

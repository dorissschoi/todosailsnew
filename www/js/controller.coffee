env = require './env.coffee'

require './model.coffee'

angular.module 'starter.controller', [ 'ionic', 'http-auth-interceptor', 'ngCordova',  'starter.model', 'platform']

	.controller 'MenuCtrl', ($scope) ->
		$scope.env = env
		$scope.navigator = navigator

	.controller 'ListCtrl', ($rootScope, $stateParams, $scope, collection, $location) ->
		_.extend $scope,
			collection: collection
			
			edit: (item) ->
				$location.url "/todo/edit/#{item.id}"		
				
			delete: (item) ->
				collection.remove item				

	.controller 'TodoCtrl', ($scope, model, $location) ->
		_.extend $scope,
			model: model
			save: ->			
				$scope.model.$save().then =>
					$location.url "/todo/weekList?ownedBy=me"		
										
	.filter 'todosFilter', ->
		(todos, search) ->
		 	return _.filter todos, (todo) ->
		 		if _.isUndefined(search)
		 			true
		 		else if _.isEmpty(search)
		 			true
		 		else	
		 			todo.task.indexOf(search) > -1 
	

env = require './env.coffee'

require './model.coffee'

angular.module 'starter.controller', [ 'ionic', 'http-auth-interceptor', 'ngCordova',  'starter.model', 'platform']

	.controller 'MenuCtrl', ($scope) ->
		$scope.env = env
		$scope.navigator = navigator

	.controller 'ListCtrl', ($rootScope, $stateParams, $scope, collection, $location, ownedBy, defaultSortField) ->
		_.extend $scope,
			collection: collection
			
			edit: (item) ->
				$location.url "/todo/edit/#{item.id}"		
				
			delete: (item) ->
				collection.remove item
			
			order: (field) ->
				$rootScope.sort = field 

			loadMore: ->
				if _.isUndefined(sortBy)
					if _.isUndefined($rootScope.sort)
						sortBy = defaultSortField
					else
						sortBy = $scope.sort	
				collection.$fetch({params: {ownedBy: ownedBy, sort: sortBy}})
					.then ->
						$scope.$broadcast('scroll.infiniteScrollComplete')
					.catch alert								

	.controller 'TodoCtrl', ($rootScope, $scope, model, $location, userlist) ->
		_.extend $scope,
			model: model
			userlist: userlist
			selected: userlist.models[0]
			save: ->			
				$scope.model.$save().then =>
					if _.isUndefined($rootScope.sort)
						$location.url "/todo/weekList?ownedBy=me&sort=project asc"
					else
						$location.url "/todo/weekList?ownedBy=me&sort="+ $rootScope.sort			
		$scope.$on 'selectuser', (event, item) ->
			$scope.model.ownedBy = item
										
	.filter 'todosFilter', ->
		(todos, search) ->
		 	return _.filter todos, (todo) ->
		 		if _.isUndefined(search)
		 			true
		 		else if _.isEmpty(search)
		 			true
		 		else	
		 			todo.task.indexOf(search) > -1 
	
	.filter 'UserSearchFilter', ->
		(collection, search) ->
			if search
				return _.filter collection, (item) ->
					r = new RegExp(search, 'i')
					r.test(item.username()) 
			else
				return collection
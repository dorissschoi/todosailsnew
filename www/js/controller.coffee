env = require './env.coffee'

require './model.coffee'

angular.module 'starter.controller', [ 'ionic', 'http-auth-interceptor', 'ngCordova',  'starter.model', 'platform']

	.controller 'MenuCtrl', ($scope) ->
		$scope.env = env
		$scope.navigator = navigator

	.controller 'ListCtrl', ($rootScope, $stateParams, $scope, collection, $location, ownedBy, sortBy, defaultSortField) ->
		_.extend $scope,
			ownedBy: ownedBy
			
			sortBy: sortBy
			
			collection: collection
			
			edit: (item) ->
				$location.url "/todo/edit/#{item.id}"		
				
			delete: (item) ->
				collection.remove item
			
			order: (field) ->
				$rootScope.sort = field 
			
			neworder: (field) ->
				if !field.localeCompare("task")
					if _.values(sortBy)[0] ==0
						sortBy = 
							"task":1
							"project":1
					else
						sortBy = 
							"task":0
							"project":0
				else		
					if _.values(sortBy)[0] ==0
						sortBy = 
							"#{field}":1
					else 
						sortBy =
							"#{field}":0
				collection.$refetch({params: {ownedBy: ownedBy, sort: sortBy }}) 
				
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

	.controller 'TodoCtrl', ($rootScope, $scope, model, $location, userlist, me) ->
		_.extend $scope,
			model: model
			userlist: userlist
			selected: _.findWhere(userlist.models,{username: me.username})
			save: ->
				$scope.model.$save()
					.then ->
						if _.isUndefined($rootScope.sort)
							$location.url "/todo/weekList?ownedBy=me&sort=project asc"
						else
							$location.url "/todo/weekList?ownedBy=me&sort="+ $rootScope.sort
					.catch (err) ->
						alert {data:{error: "Not authorized to edit."}}					
		$scope.$on 'selectuser', (event, item) ->
			$scope.model.ownedBy = item

	.filter 'todosFilter', ($ionicScrollDelegate)->
		(collection, search, skip, count, limit) ->
			if search
				return _.filter collection, (item) ->
					r = new RegExp(search, 'i')
					r.test(item.project) or r.test(item.task) or r.test(item.createdBy.username) or r.test(item.ownedBy.username)
			else
				return collection

	.filter 'UserSearchFilter', ->
		(collection, search) ->
			if search
				return _.filter collection, (item) ->
					r = new RegExp(search, 'i')
					r.test(item.username()) 
			else
				return collection
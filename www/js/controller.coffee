env = require './env.coffee'

require './model.coffee'

angular.module 'starter.controller', [ 'ionic', 'http-auth-interceptor', 'ngCordova',  'starter.model', 'platform']

	.controller 'MenuCtrl', ($scope) ->
		$scope.env = env
		$scope.navigator = navigator

	.controller 'ListCtrl', ($rootScope, $stateParams, $scope, collection, $location, ownedBy, sortBy) ->
		_.extend $scope,
			ownedBy: ownedBy
			
			sortBy: sortBy
			
			collection: collection
			
			edit: (item) ->
				$location.url "/todo/edit/#{item.id}"		
				
			delete: (item) ->
				collection.remove item
			
			reorder: (field) ->
				if field == "task"
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
				$location.url "/todo/weekList?ownedBy=me&sort=#{JSON.stringify sortBy}" 
				#collection.$refetch({params: {ownedBy: ownedBy, sort: sortBy }}) 	 
			
			loadMore: ->
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
						$location.url "/todo/weekList?ownedBy=me&sort=%7B%22task%22:1%7D"
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
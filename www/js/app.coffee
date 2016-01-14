env = require './env.coffee'

angular.module 'starter', ['ionic', 'util.auth', 'starter.controller', 'starter.model', 'http-auth-interceptor', 'ngTagEditor', 'ActiveRecord', 'ngTouch', 'ngAnimate', 'ionic-datepicker', 'ionic-timepicker', 'pascalprecht.translate', 'locale']
	
	.run (authService) ->
		authService.login env.oauth2.opts
	        
	.run ($rootScope, platform, $ionicPlatform, $location, $http) ->
		$ionicPlatform.ready ->
			if (window.cordova && window.cordova.plugins.Keyboard)
				cordova.plugins.Keyboard.hideKeyboardAccessoryBar(true)
			if (window.StatusBar)
				StatusBar.styleDefault()
						
	.config ($stateProvider, $urlRouterProvider, $translateProvider) ->
	
		$stateProvider.state 'app',
			url: ""
			abstract: true
			templateUrl: "templates/menu.html"
	
		$stateProvider.state 'app.createTodo',
			url: "/todo/create"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/todo/create.html"
					controller: 'TodoCtrl'
			resolve:
				resources: 'resources'	
				model: (resources) ->
					ret = new resources.Todo()				
	
		# edit #	
		$stateProvider.state 'app.editTodo',
			url: "/todo/edit/:id"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/todo/edit.html"
					controller: 'TodoCtrl'
			resolve:
				id: ($stateParams) ->
					$stateParams.id
				resources: 'resources'	
				model: (resources, id) ->
					ret = new resources.Todo({id: id})
					ret.$fetch()			
		
		# list #
		$stateProvider.state 'app.list',
			url: "/todo/weekList?ownedBy"
			cache: false
			views:
				'menuContent':
					templateUrl: "templates/todo/list.html"
					controller: 'ListCtrl'
			resolve:
				ownedBy: ($stateParams) ->
					return $stateParams.ownedBy
							
				resources: 'resources'	
				collection: (resources, ownedBy) ->
					ret = new resources.TodoList()
					ret.$fetch({params: {ownedBy: ownedBy}})
		
		$urlRouterProvider.otherwise('/todo/weekList?ownedBy=me')				
		
		
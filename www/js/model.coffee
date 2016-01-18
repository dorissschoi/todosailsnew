require 'PageableAR'

angular.module 'starter.model', ['PageableAR']

	.factory 'resources', (pageableAR) ->

		class Todo extends pageableAR.Model
			$idAttribute: 'id'
			
			$urlRoot: "api/todo/"
			
			$parse: (res, opts) ->
				if !_.isUndefined(res.dateEnd)
					res.dateEnd = new Date(res.dateEnd)
				return res

		# TodoList
		class TodoList extends pageableAR.PageableCollection

			model: Todo
			
			$urlRoot: "api/todo/"

		class User extends pageableAR.Model
			$idAttribute: 'username'
			
			$urlRoot: "api/user/"
			
			_me = null
			
			@me: ->
				_me ?= new User username: 'me'
		
		# UserList
		class UserList extends pageableAR.PageableCollection

			model: User
			
			$urlRoot: "api/user/"		
					
		Todo:		Todo
		TodoList:	TodoList
		User:		User
		UserList:	UserList

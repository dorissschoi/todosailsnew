require 'PageableAR'

angular.module 'starter.model', ['PageableAR']

	.factory 'resources', (pageableAR) ->

		class Todo extends pageableAR.Model
			$idAttribute: 'id'
			
			$urlRoot: "/api/todo/"
			
			$parse: (res, opts) ->
				if !_.isUndefined(res.dateEnd)
					res.dateEnd = new Date(res.dateEnd)
				return res
			
			$save: (values, opts) ->
				if @$hasChanged()
					super(values, opts)
				else
					return new Promise (fulfill, reject) ->
						fulfill @		
	
		# TodoList
		class TodoList extends pageableAR.PageableCollection

			model: Todo
			
			$urlRoot: "/api/todo/"
					
		Todo:		Todo
		TodoList:	TodoList

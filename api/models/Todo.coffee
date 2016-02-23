				
module.exports =
	tableName:		'todos'
  
	schema: 		true
  
	attributes:
  
		task:
			type: 'string'
			required:	true

		location:
			type: 'string'

		project:
			type: 'string'

		notes:
			type: 'string'

		dateStart:
			type: 'datetime'
			defaultsTo: null			

		dateEnd:
			type: 'datetime'
			defaultsTo: null

		dateExpStart:
			type: 'datetime'
			defaultsTo: null	
						
		dateExpect:
			type: 'datetime'
			defaultsTo: null			

		createdBy:
			model: 'user'
			required:	true

		ownedBy:
			model: 'user'
			required:	true
		
		progress:
			type: 'integer'
			defaultsTo:	0
		
		ownerDel:
			type: 'boolean'
			defaultsTo: true

	afterCreate: (values, cb) ->
		MsgService.sendMsg(values)

		return cb null, values 
		
	beforeCreate: (values, cb) ->
		if (((_.isUndefined(values.dateEnd)) || (_.isNull(values.dateEnd))) && values.progress == 100)
			values.dateEnd = new Date()

		return cb null, values
									  
	beforeUpdate: (values, cb) ->
		if (((_.isUndefined(values.dateEnd)) || (_.isNull(values.dateEnd))) && values.progress == 100)
			values.dateEnd = new Date()

		return cb null, values 
			 
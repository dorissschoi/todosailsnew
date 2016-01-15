module.exports =
	tableName:	'users'
	schema:		true
	autoPK:		false
	attributes:
		url:
			type: 		'string'
			required: 	true
			
		username:
			type: 		'string'
			required: 	true
			primaryKey: true
			
		email:
			type:		'string' 
			required:	true

module.exports = 
	policies:
		TodoController:
			'*':	false
			find:	['isAuth', 'resolveMe']	
			create: ['isAuth', 'setCreatedBy' , 'setOwner']
			update: ['isAuth', 'isOwnerOrCreatedBy']
			destroy: ['isAuth', 'isCreatedBy']

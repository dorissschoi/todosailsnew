
module.exports = 
	policies:
		TodoController:
			'*':	false
			find:	['isAuth', 'resolveMe']	
			findOne:['isAuth', 'isOwnedBy']			
			create: ['isAuth', 'setCreatedBy' , 'setOwner']
			update: ['isAuth', 'isOwnedBy']
			destroy: ['isAuth', 'isOwnedBy']

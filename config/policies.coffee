
module.exports = 
	policies:
		TodoController:
			'*':		false
			find:		['isAuth', 'todo/resolveMe']	
			findOne:	['isAuth']			
			create: 	['isAuth', 'setCreatedBy' , 'setOwner']
			update: 	['isAuth', 'isOwnedBy']
			destroy: 	['isAuth', 'isCreatedBy']
		UserController:
			'*':		false
			find:		true
			findOne:	['isAuth', 'user/me']
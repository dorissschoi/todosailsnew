actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'

module.exports = (req, res, next) ->
	
	if req.query.ownedBy == 'me'
		req.query.ownedBy = req.user.username
		
	next()
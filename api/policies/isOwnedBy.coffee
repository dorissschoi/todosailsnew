# add criteria for room jid and current login user  
module.exports = (req, res, next) ->
	req.options.where = req.options.where || {}
	_.extend req.options.where, ownedBy: req.user.username	
	next()
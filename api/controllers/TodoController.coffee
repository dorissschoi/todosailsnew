 # TodoController
 #
 # @description :: Server-side logic for managing todoes
 # @help        :: See http://sailsjs.org/#!/documentation/concepts/Controllers


actionUtil = require 'sails/lib/hooks/blueprints/actionUtil'
find = require 'sails/lib/hooks/blueprints/actions/find'

module.exports =
	
	find: (req, res) ->
		sails.services.crud.find(req).then res.ok, res.serverError 
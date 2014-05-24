module ApplicationHelper
	def getRandomStatement()
		@rand_statement = Statement.order("RANDOM()").first
	end

        def activeClassIfModel( model )
	     if model && model == self.controller_name.classify
	        "class=""active"""
	     else ""

	     end
	end
end

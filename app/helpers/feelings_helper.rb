module FeelingsHelper
	def fomatdate_date(d)
		if !d
			d= DateTime.now.to_date
		end
		d.strftime("%d-%m-%Y")
	end
end

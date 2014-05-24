class SearchSuggestion < ActiveRecord::Base
	#protected_attributes :author, :term

	def self.terms_for(prefix) 
		suggestions = where("term like ?","#{prefix}_%")
		suggestions.pluck(:term)
	end

	def self.index_statements
		SearchSuggestion.delete_all()
		Statement.find_each do |statement|
			#index_term(statement.content)
			#statement.content.split.each {|t| index_term(t)}
			statement.content.split(/[, \.?!.–«»:;—\n]+/).each do |t| 
				if t.length > 2
					n = t.mb_chars.downcase
				    index_term(n)
				end
			end
		end
	end

	def self.index_term(term)
		where(term: term.downcase).first_or_initialize.tap do |suggestion|
			suggestion.increment! :author

		end
	end
end

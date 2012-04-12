module AlchemyCrm
  module AlchemyLanguageIdStore
    def self.included(c)
      c.send(:before_filter, :store_alchemy_language_id)
    end

    private

    def store_alchemy_language_id
      session[:language_id] ||= Alchemy::Language.get_default.id
    end

  end
end

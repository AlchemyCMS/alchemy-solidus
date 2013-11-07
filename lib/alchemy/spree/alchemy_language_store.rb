module AlchemySpree
  module AlchemyLanguageStore
    def self.included(c)
      c.send(:before_filter, :store_alchemy_language)
    end

  private

    def store_alchemy_language
      @alchemy_language ||= Alchemy::Language.find_by_code(::I18n.locale.to_s)
      @alchemy_language ||= Alchemy::Language.get_default
      session[:language_id] = @alchemy_language.id
      session[:language_code] = @alchemy_language.code
    end

  end
end

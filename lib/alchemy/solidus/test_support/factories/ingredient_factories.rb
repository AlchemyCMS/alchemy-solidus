FactoryBot.define do
  %w[
    product
    taxon
    variant
  ].each do |ingredient|
    factory :"alchemy_ingredient_spree_#{ingredient}", class: "Alchemy::Ingredients::Spree#{ingredient.classify}" do
      role { ingredient }
      type { "Alchemy::Ingredients::Spree#{ingredient.classify}" }
      association :element, name: ingredient, factory: :alchemy_element
    end
  end
end

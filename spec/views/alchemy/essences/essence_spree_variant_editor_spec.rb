# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'alchemy/essences/_essence_spree_variant_editor' do
  let(:content) { Alchemy::Content.new(essence: essence) }
  let(:essence) { Alchemy::EssenceSpreeVariant.new }

  before do
    view.class.send(:include, Alchemy::Admin::EssencesHelper)
    allow(view).to receive(:content_label).and_return(content.name)
  end

  it "renders a variant select box" do
    render 'alchemy/essences/essence_spree_variant_editor', content: content
    expect(rendered).to have_css('select.alchemy_selectbox.full_width')
  end

  context 'with a variant related to essence' do
    let(:product) { Spree::Product.new(name: 'Chocolate') }
    let(:variant) { Spree::Variant.new(id: 1, product: product) }
    let(:essence) { Alchemy::EssenceSpreeVariant.new(variant_id: variant.id) }

    before do
      expect(Spree::Variant).to receive(:all) { [variant] }
    end

    it "selects variant in select box" do
      render 'alchemy/essences/essence_spree_variant_editor', content: content
      expect(rendered).to have_css('option[value="1"][selected]')
    end
  end
end

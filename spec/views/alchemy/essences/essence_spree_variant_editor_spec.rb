# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'alchemy/essences/_essence_spree_variant_editor' do
  let(:content) do
    content = Alchemy::Content.new(essence: essence)
    if Alchemy.gem_version >= Gem::Version.new("4.9")
      Alchemy::ContentEditor.new(content)
    else
      content
    end
  end
  let(:essence) { Alchemy::EssenceSpreeVariant.new }

  before do
    view.class.send(:include, Alchemy::Admin::ElementsHelper)
    allow(view).to receive(:content_label) { content.name }
  end

  subject do
    render 'alchemy/essences/essence_spree_variant_editor',
      content: content,
      spree: double(api_variants_path: '/api/variants'),
      current_alchemy_user: double(spree_api_key: '123')
    rendered
  end

  it "renders a variant input" do
    is_expected.to have_css('input.alchemy_selectbox.full_width')
  end

  context 'with a variant related to essence' do
    let(:product) { Spree::Product.new(name: 'Chocolate') }
    let(:variant) { Spree::Variant.new(id: 1, product: product) }
    let(:essence) { Alchemy::EssenceSpreeVariant.new(variant_id: variant.id) }

    it "sets variant id as value" do
      is_expected.to have_css('input.alchemy_selectbox[value="1"]')
    end
  end
end

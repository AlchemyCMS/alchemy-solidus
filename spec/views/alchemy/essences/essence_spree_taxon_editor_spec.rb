# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'alchemy/essences/_essence_spree_taxon_editor' do
  let(:content) do
    content = Alchemy::Content.new(essence: essence)
    if Alchemy.gem_version >= Gem::Version.new("4.9")
      Alchemy::ContentEditor.new(content)
    else
      content
    end
  end
  let(:essence) { Alchemy::EssenceSpreeTaxon.new }

  before do
    view.class.send(:include,Alchemy::Admin::ElementsHelper)
    allow(view).to receive(:content_label) { content.name }
  end

  subject do
    render 'alchemy/essences/essence_spree_taxon_editor',
      content: content,
      spree: double(api_taxons_path: '/api/taxons'),
      current_alchemy_user: double(spree_api_key: '123')
    rendered
  end

  it "renders a taxon input" do
    is_expected.to have_css('input.alchemy_selectbox.full_width')
  end

  context 'with a taxon related to essence' do
    let(:taxon) { Spree::Taxon.new(id: 1) }
    let(:essence) { Alchemy::EssenceSpreeTaxon.new(taxon_id: taxon.id) }

    it "sets taxon id as value" do
      is_expected.to have_css('input.alchemy_selectbox[value="1"]')
    end
  end
end

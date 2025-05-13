module Alchemy
  module Solidus
    class InvalidateElementsCacheJob < BaseJob
      queue_as :default

      def perform(model_name, id)
        now = Time.current

        element_ids = model(model_name)
          .where(related_object_id: id)
          .joins(:element)
          .pluck("alchemy_elements.id")
        elements = ::Alchemy::Element.where(id: element_ids)

        all_element_ids = get_all_element_ids(elements, element_ids)
        ::Alchemy::Element.where(id: all_element_ids.uniq).update_all(updated_at: now)

        page_ids = elements.joins(page_version: :page).pluck("alchemy_pages.id")
        ::Alchemy::Page.where(id: page_ids.uniq).update_all(updated_at: now)
      end

      private

      def get_all_element_ids(elements, element_ids)
        parent_element_ids = elements.pluck(:parent_element_id).compact
        parent_elements = ::Alchemy::Element.distinct.where(id: parent_element_ids)

        if parent_elements.any?
          element_ids += parent_element_ids
          get_all_element_ids(parent_elements, element_ids)
        else
          element_ids
        end
      end

      def model(model_name) = "Alchemy::Ingredients::#{model_name}".constantize
    end
  end
end

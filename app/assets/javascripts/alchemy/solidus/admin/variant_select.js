//= require alchemy/solidus/admin/select2_config

$.fn.alchemyVariantSelect = function(options) {
  var config = Alchemy.Solidus.getSelect2Config(options)

  this.select2($.extend(true, config, {
    ajax: {
      data: function(term, page) {
        return {
          q: $.extend({
            product_name_or_sku_cont: term
          }, options.query_params),
          page: page
        }
      },
      results: function(data, page) {
        return {
          results: data.variants.map(function(variant) {
            return {
              id: variant.id,
              text: variant.frontend_display
            }
          }),
          more: page * data.per_page < data.total_count
        }
      }
    },
    formatSelection: function(variant) {
      return variant.text || variant.frontend_display
    }
  }))
}

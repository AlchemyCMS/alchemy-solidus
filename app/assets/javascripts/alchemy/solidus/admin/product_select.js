//= require alchemy/solidus/admin/select2_config

$.fn.alchemyProductSelect = function(options) {
  var config = Alchemy.Solidus.getSelect2Config(options)

  this.select2($.extend(true, config, {
    ajax: {
      data: function(term, page) {
        return {
          q: $.extend({
            name_cont: term
          }, options.query_params),
          page: page
        }
      },
      results: function(data, page) {
        return {
          results: data.products.map(function(product) {
            return {
              id: product.id,
              text: product.name
            }
          }),
          more: page * data.per_page < data.total_count
        }
      }
    },
    formatSelection: function(product) {
      return product.text || product.name
    }
  }))
}

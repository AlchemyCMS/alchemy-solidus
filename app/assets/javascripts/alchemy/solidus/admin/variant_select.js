//= require alchemy/solidus/admin/select2_config

$.fn.alchemyVariantSelect = function(options) {
  const config = Alchemy.Solidus.getSelect2Config(options)

  function formatSelection(variant) {
    return variant.options_text ? `${variant.name} - ${variant.options_text}` : variant.name
  }

  function formatResult(variant) {
    return `
      <div class="variant-select-result">  
        <div>
          <span>${variant.name}</span>
        </div>
        <div>
          <span>${variant.options_text}</span>
          <span>${variant.sku}</span>
        </div>
      </div>       
    `
  }

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
          results: data.variants,
          more: page * data.per_page < data.total_count
        }
      }
    },
    formatSelection,
    formatResult
  }))
}

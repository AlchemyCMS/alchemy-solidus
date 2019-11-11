$.fn.alchemyVariantSelect = function(options) {
  var headers = {
    'X-Spree-Token': options.apiToken
  }

  this.select2({
    placeholder: options.placeholder,
    minimumInputLength: 3,
    initSelection: function($element, callback) {
      $.ajax({
        url: options.baseUrl + '/' + $element.val(),
        headers: headers,
        success: callback,
        error: function (_xhr, _textStatus, errorThrown) {
          console.error(errorThrown)
        }
      })
    },
    ajax: {
      url: options.baseUrl,
      datatype: 'json',
      quietMillis: 300,
      params: { headers: headers },
      data: function (term, page) {
        return {
          q: { product_name_or_sku_cont: term },
          page: page
        }
      },
      results: function (data, page) {
        return {
          results: data.variants.map(function (variant) {
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
  })
}

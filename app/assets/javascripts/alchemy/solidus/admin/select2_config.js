Alchemy = window.Alchemy || {}
Alchemy.Solidus = Alchemy.Solidus || {}

Alchemy.Solidus.getSelect2Config = function(options) {
  var headers = {
    'X-Spree-Token': options.apiToken
  }

  return {
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
      params: { headers: headers }
    }
  }
}

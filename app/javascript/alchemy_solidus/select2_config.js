export function getSelect2Config(options) {
  var headers = {
    Authorization: "Bearer " + options.apiToken,
  }

  return {
    placeholder: options.placeholder,
    minimumInputLength: 3,
    allowClear: true,
    initSelection:
      options.initSelection ||
      function (_$el, callback) {
        if (options.initialSelection) {
          callback(options.initialSelection)
        }
      },
    ajax: {
      url: options.baseUrl,
      datatype: "json",
      quietMillis: 300,
      params: { headers: headers },
    },
  }
}

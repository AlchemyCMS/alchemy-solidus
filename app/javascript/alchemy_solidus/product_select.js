import { getSelect2Config } from "alchemy_solidus/select2_config"

$.fn.alchemyProductSelect = function (options) {
  var config = getSelect2Config(options)

  function formatResultObject(product) {
    return {
      id: product.id,
      text: product.name,
    }
  }

  var select2config = Object.assign(config, {
    ajax: Object.assign(config.ajax, {
      data: function (term, page) {
        return {
          q: Object.assign(
            {
              name_cont: term,
            },
            options.query_params
          ),
          page: page,
        }
      },
      results: function (data, page) {
        return {
          results: data.products.map(
            options.formatResultObject || formatResultObject
          ),
          more: page * data.per_page < data.total_count,
        }
      },
    }),
  })
  this.select2(select2config)
}

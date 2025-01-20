import { getSelect2Config } from "alchemy_solidus/select2_config"

$.fn.alchemyVariantSelect = function (options) {
  const config = getSelect2Config(options)

  function formatSelection(variant) {
    return variant.options_text
      ? `${variant.name} - ${variant.options_text}`
      : variant.name
  }

  function formatResult(variant, _el, query) {
    const matchTerm = new RegExp(query.term, "gi")
    const formatMatch = (match) => `<em>${match}</em>`
    const name = variant.name.replace(matchTerm, formatMatch)
    const sku = variant.sku.replace(matchTerm, formatMatch)
    return `
      <div class="variant-select-result">
        <div>
          <span>${name}</span>
        </div>
        <div>
          <span>${variant.options_text}</span>
          <span>${sku}</span>
        </div>
      </div>
    `
  }

  this.select2(
    $.extend(true, config, {
      ajax: {
        data: function (term, page) {
          return {
            q: $.extend(
              {
                product_name_or_sku_cont: term,
              },
              options.query_params
            ),
            page: page,
          }
        },
        results: function (data, page) {
          return {
            results: data.variants,
            more: page * data.per_page < data.total_count,
          }
        },
      },
      formatSelection,
      formatResult,
    })
  )
}

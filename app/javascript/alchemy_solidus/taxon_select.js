import { getSelect2Config } from "alchemy_solidus/select2_config"

$.fn.alchemyTaxonSelect = function (options) {
  const config = getSelect2Config(options)

  this.select2(
    $.extend(true, config, {
      ajax: {
        data(term, page) {
          return {
            q: $.extend(
              {
                name_cont: term,
              },
              options.query_params
            ),
            page: page,
          }
        },
        results(data, page) {
          return {
            results: data.taxons.map(function (taxon) {
              return {
                id: taxon.id,
                text: taxon.pretty_name,
              }
            }),
            more: page * data.per_page < data.total_count,
          }
        },
      },
      formatSelection(taxon) {
        return taxon.text || taxon.name
      },
    })
  )
}

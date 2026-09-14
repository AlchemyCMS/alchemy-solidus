import { RemoteSelect } from "alchemy_admin/components/remote_select"
import ajaxConfig from "alchemy_solidus/components/ajax_config"

export default class VariantSelect extends RemoteSelect {
  get ajaxConfig() {
    return ajaxConfig(super.ajaxConfig, this.apiKey)
  }

  get apiKey() {
    return this.getAttribute("api-key")
  }

  /**
   * Search query send to server
   * @param {string} term
   * @param {number} page
   * @returns {object}
   * @private
   */
  _searchQuery(term, page) {
    return {
      q: {
        product_name_or_sku_cont: term,
        ...JSON.parse(this.queryParams),
      },
      page: page,
    }
  }

  /**
   * Parses server response into a results object
   * @param {object} response
   * @returns {object}
   * @private
   */
  _parseResponse(response) {
    return {
      results: response.variants.map((variant) => {
        return {
          ...variant,
          image: variant.images[0]?.mini_url
        }
      }),
      more: response.current_page * response.per_page < response.total_count,
    }
  }

  /**
   * slots of a dropdown option
   * @param {object} variant
   * @param {string} term
   * @returns {object}
   * @protected
   */
  _entry(variant, term) {
    return {
      primary: this._hightlightTerm(variant.name, term),
      secondary: variant.options_text,
      secondaryAside: variant.sku,
      media: variant.image
    }
  }

  /**
   * slots of the selected variant shown in the control
   * @param {object} variant
   * @returns {object}
   * @protected
   */
  _selectedEntry(variant) {
    return {
      primary: variant.name,
      secondary: variant.options_text,
      media: variant.image
    }
  }
}

customElements.define("alchemy-variant-select", VariantSelect)

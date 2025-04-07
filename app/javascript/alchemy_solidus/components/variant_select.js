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
   * Search query send to server from select2
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
   * Parses server response into select2 results object
   * @param {object} response
   * @returns {object}
   * @private
   */
  _parseResponse(response) {
    return {
      results: response.variants,
      more: response.current_page * response.per_page < response.total_count,
    }
  }

  /**
   * result which is visible if a variant was selected
   * @param {object} variant
   * @returns {string}
   * @private
   */
  _renderResult(variant) {
    return variant.options_text
      ? `${variant.name} - ${variant.options_text}`
      : variant.name
  }

  /**
   * html template for each list entry
   * @param {object} variant
   * @param {string} term
   * @returns {string}
   * @private
   */
  _renderListEntry(variant, term) {
    const name = this._hightlightTerm(variant.name, term)
    const sku = this._hightlightTerm(variant.sku, term)
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
}

customElements.define("alchemy-variant-select", VariantSelect)

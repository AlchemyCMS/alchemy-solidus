import { RemoteSelect } from "alchemy_admin/components/remote_select"
import ajaxConfig from "alchemy_solidus/components/ajax_config"

export default class ProductSelect extends RemoteSelect {
  get ajaxConfig() {
    return ajaxConfig(super.ajaxConfig, this.apiKey)
  }

  get apiKey() {
    return this.getAttribute("api-key")
  }

  get valueAttribute() {
    return this.getAttribute("value-attribute") || "id"
  }

  /**
   * Parses server response into select2 results object
   * @param {object} response
   * @returns {object}
   * @private
   */
  _parseResponse(response) {
    return {
      results: response.products.map((product) => {
        return {
          id: this._parsedValue(product),
          name: product.name,
        }
      }),
      more: response.current_page * response.per_page < response.total_count,
    }
  }

  /**
   * The value used for the select send to the server
   * after submitting the form this select is placed in.
   *
   * @param {object} product
   * @returns {string}
   */
  _parsedValue(product) {
    return product[this.valueAttribute]
  }

  /**
   * result which is visible if a product was selected
   * @param {object} product
   * @returns {string}
   * @private
   */
  _renderResult(product) {
    return product.name
  }

  /**
   * html template for each list entry
   * @param {object} product
   * @param {string} term
   * @returns {string}
   * @private
   */
  _renderListEntry(product, term) {
    return this._hightlightTerm(product.name, term)
  }
}

customElements.define("alchemy-product-select", ProductSelect)

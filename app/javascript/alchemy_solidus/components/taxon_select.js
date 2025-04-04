import { RemoteSelect } from "alchemy_admin/components/remote_select"

export default class TaxonSelect extends RemoteSelect {
  get ajaxConfig() {
    return {
      ...super.ajaxConfig,
      params: {
        headers: {
          Authorization: `Bearer ${this.apiKey}`,
        },
      },
    }
  }

  get apiKey() {
    return this.getAttribute("api-key")
  }

  /**
   * Parses server response into select2 results object
   * @param {object} response
   * @returns {object}
   * @private
   */
  _parseResponse(response) {
    return {
      results: response.taxons,
      more: response.current_page * response.per_page < response.total_count,
    }
  }

  /**
   * result which is visible if a taxon was selected
   * @param {object} taxon
   * @returns {string}
   * @private
   */
  _renderResult(taxon) {
    return taxon.text || taxon.pretty_name
  }

  /**
   * html template for each list entry
   * @param {object} taxon
   * @param {string} term
   * @returns {string}
   * @private
   */
  _renderListEntry(taxon, term) {
    return this._hightlightTerm(taxon.pretty_name, term)
  }
}

customElements.define("alchemy-taxon-select", TaxonSelect)

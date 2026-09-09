import { RemoteSelect } from "alchemy_admin/components/remote_select"
import ajaxConfig from "alchemy_solidus/components/ajax_config"

export default class TaxonSelect extends RemoteSelect {
  get ajaxConfig() {
    return ajaxConfig(super.ajaxConfig, this.apiKey)
  }

  get apiKey() {
    return this.getAttribute("api-key")
  }

  /**
   * Parses server response into a results object
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
   * slots of a dropdown option
   * @param {object} taxon
   * @param {string} term
   * @returns {object}
   * @protected
   */
  _entry(taxon, term) {
    return {
      primary: this._hightlightTerm(taxon.pretty_name, term)
    }
  }

  /**
   * slots of the selected taxon shown in the control
   * @param {object} taxon
   * @returns {object}
   * @protected
   */
  _selectedEntry(taxon) {
    return {
      primary: taxon.text || taxon.pretty_name
    }
  }
}

customElements.define("alchemy-taxon-select", TaxonSelect)

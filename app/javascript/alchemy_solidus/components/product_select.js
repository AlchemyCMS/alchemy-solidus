export default class ProductSelect extends HTMLElement {
  connectedCallback() {
    const input = this.querySelector("#product_link")
    input.classList.add("alchemy_selectbox")

    $(input).alchemyProductSelect({
      baseUrl: this.url,
      apiToken: this.apiToken,
      initSelection: this._initSelection.bind(this),
      formatResultObject: this._formatResult.bind(this),
    })
  }

  get url() {
    return this.getAttribute("url")
  }

  get apiToken() {
    return this.getAttribute("api-key")
  }

  _initSelection(_$el, callback) {
    const selection = this.getAttribute("selection")
    const product = JSON.parse(selection)
    callback(this._formatResult(product))
  }

  _formatResult(product) {
    return {
      id: `${Spree.mountedAt()}products/${product.slug}`,
      text: product.name,
    }
  }

  _searchQuery(value) {
    const slug = value.replace(`${Spree.mountedAt()}products/`, "")
    return `q[slug_eq]=${slug}`
  }
}

customElements.define("alchemy-product-select", ProductSelect)

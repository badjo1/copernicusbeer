// controllers/web3_controller.js
import { Controller } from "@hotwired/stimulus"
import { createPublicClient, http } from "viem"
import { mainnet, polygon, base } from "viem/chains"

export default class Web3Controller extends Controller {

  static values = {
      address : String,
      chain   : String
  }

  connect() {
    console.log('connect web3 controller')
    if (!this.addressValue || !/^0x[a-fA-F0-9]{40}$/.test(this.addressValue)) {
      console.warn("Geen geldig Ethereum-adres gevonden!")
      return
    }
  }

  getClient() {
    if (!this.client) {
      const chainName = this.chainValue || 'mainnet' // fallback
      const chainMap = {
        mainnet,
        polygon,
        base
      }

      const selectedChain = chainMap[chainName]

      if (!selectedChain) {
        console.warn(`Unsupported chain: ${chainName}, falling back to mainnet.`)
      }

      this.client = createPublicClient({
        chain: selectedChain || mainnet,
        transport: http(),
      })
    }
    return this.client
  }
}

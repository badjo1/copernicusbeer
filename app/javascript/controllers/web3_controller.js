// controllers/web3_controller.js
import { Controller } from "@hotwired/stimulus"
import { createPublicClient, http } from "viem"
import { mainnet, polygon, base } from "viem/chains"

export default class ParentController extends Controller {
  static targets = ["eth"]
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
    if (this.hasEthTarget) {
      this.getEth() 
    }
  }

  async getEth() {
    console.log('get Eth Balance')
    const address = this.addressValue
    const balance = await this.getClient().getBalance({ address })
    const balanceInEth = (Number(balance) / (10 ** 18))
    this.balanceTarget.textContent = `Ethereum ${balanceInEth} ETH`
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

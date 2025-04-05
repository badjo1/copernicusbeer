import Web3Controller from "./web3_controller"

export default class extends Web3Controller {
  static targets = ["balance"]

  connect() {
    super.connect() // Roep de `connect()` van Web3Controller aan
    if (this.hasBalanceTarget) {
      this.getEthBalance() 
    }
  }

  async getEthBalance() {
    console.log('get Eth Balance')
    const address = this.addressValue
    const balance = await this.getClient().getBalance({ address })
    const balanceInEth = (Number(balance) / (10 ** 18))
    this.balanceTarget.textContent = `Ethereum ${balanceInEth} ETH`
  }

}

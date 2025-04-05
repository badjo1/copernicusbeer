import Web3Controller from "./web3_controller.js"
import { erc20Abi, formatUnits } from "viem"

export default class extends Web3Controller {
static targets = ["balance", "symbol", "name"]
  static values = {
    contract: String,
  }

  connect() {
    super.connect() // Roep de `connect()` van Web3Controller aan

    // Controleer of een geldig contractadres is meegegeven
    if (!this.contractValue || !/^0x[a-fA-F0-9]{40}$/.test(this.contractValue)) {
      console.error("❌ Geen geldig token contractadres gevonden!")
      return
    }

    console.log("🔄 Ophalen token info...")
    if (this.hasBalanceTarget) {
      this.getTokenBalance() 
    }
    if (this.hasSymbolTarget) {
      this.getTokenSymbol() 
    }
    if (this.hasNameTarget) {
      this.getTokenName() 
    }


  }

  async getTokenBalance() {
    try {
      console.log("📌 Contract:", this.contractValue)
      console.log("📌 Adres:", this.addressValue)

      // Balans ophalen
      const balance = await this.getClient().readContract({
        address: this.contractValue,
        abi: erc20Abi,
        functionName: "balanceOf",
        args: [this.addressValue],
      })
      console.log("✅ Balance opgehaald:", balance.toString())

      // Decimals ophalen
      const decimals = await this.getClient().readContract({
        address: this.contractValue,
        abi: erc20Abi,
        functionName: "decimals",
      })
      console.log("✅ Decimals opgehaald:", decimals)

      // Formatteer de balans
      const formattedBalance = formatUnits(balance, decimals)
      this.balanceTarget.textContent = `${formattedBalance}`
      console.log(`🎉 Token Balans: ${formattedBalance} tokens`)

    } catch (error) {
      this.balanceTarget.textContent = "⚠️ Fout bij ophalen balans!"
      console.error("🚨 Fout bij ophalen token balans:", error)
    }
  }

  async getTokenSymbol() {
    try {
      // Token symbol ophalen
      const client = this.getClient()
      const symbol = await client.readContract({
        address: this.contractValue,
        abi: erc20Abi,
        functionName: "symbol",
      })
      console.log("✅ Symbol opgehaald:", symbol)

      // Formatteer de balans
      this.symbolTarget.textContent = `${symbol}`
      console.log(`🎉 Token Symbol: ${symbol} `)

    } catch (error) {
      this.symbolTarget.textContent = "⚠️ Fout bij ophalen symbol!"
      console.error("🚨 Fout bij ophalen token balans:", error)
    }
  }

  async getTokenName() {
  try {
    const client = this.getClient()
    const name = await client.readContract({
      address: this.contractValue,
      abi: erc20Abi,
      functionName: "name",
    })
    console.log("✅ Name opgehaald:", name)

    this.nameTarget.textContent = `${name}`
    console.log(`🎉 Token Name: ${name}`)

  } catch (error) {
    this.nameTarget.textContent = "⚠️ Fout bij ophalen naam!"
    console.error("🚨 Fout bij ophalen token naam:", error)
  }
}
}

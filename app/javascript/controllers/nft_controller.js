import Web3Controller from "controllers/web3_controller"
// import { erc721Abi } from "viem"
import { erc721EnumerableAbi } from "controllers/erc721EnumerableAbi"

export default class NftController extends Web3Controller {
  static targets = ["grid"]
  static values = {
    contract: String,
  }

  connect() {
    super.connect()

       // Controleer of een geldig contractadres is meegegeven
    if (!this.contractValue || !/^0x[a-fA-F0-9]{40}$/.test(this.contractValue)) {
      console.error("Geen geldig token contractadres gevonden!")
      return
    }

    if (this.hasGridTarget) {
      this.getNFTs()
    }
  }

  async getNFTBalance() {
    try {
      const balance = await this.getClient().readContract({
        address: this.contractValue,
        abi: erc721EnumerableAbi,
        functionName: "balanceOf",
        args: [this.addressValue],
      })

      this.balanceTarget.textContent = balance.toString()
      console.log(`🎉 ERC-721 NFT Balance: ${balance.toString()}`)

    } catch (e) {
      console.error("❌ Fout bij ophalen ERC-721 balans:", e)
      this.balanceTarget.textContent = "⚠️"
    }
  }

  async getNFTs() {
    try {
      const client = this.getClient()

      // Stap 1: Aantal NFT's ophalen
      const balance = await client.readContract({
        address: this.contractValue,
        abi: erc721EnumerableAbi,
        functionName: "balanceOf",
        args: [this.addressValue],
      })

      const nftCount = Number(balance)
      console.log(`🔍 Aantal NFT's: ${nftCount}`)

      for (let i = 0; i < nftCount; i++) {
        // Stap 2: tokenId ophalen van eigenaar
        const tokenId = await client.readContract({
          address: this.contractValue,
          abi: erc721EnumerableAbi,
          functionName: "tokenOfOwnerByIndex",
          args: [this.addressValue, BigInt(i)],
        })

        console.log(`📦 Token ID: ${tokenId}`)

        // Stap 3: tokenURI ophalen
        const tokenUri = await client.readContract({
          address: this.contractValue,
          abi: erc721EnumerableAbi,
          functionName: "tokenURI",
          args: [tokenId],
        })

        console.log(`🌐 tokenURI: ${tokenUri}`)

        // Stap 4: Metadata ophalen
        const metadataUrl = this.normalizeUri(tokenUri)
        const res = await fetch(metadataUrl)
        const metadata = await res.json()

        this.renderNFT(tokenId, tokenUri, metadata)
      }

      console.log("🎉 Alle NFT data opgehaald:")

    } catch (error) {
      console.error("🚨 Fout bij ophalen NFT’s:", error)
    }
  }

  // ✅ Helperfunctie om IPFS of gateway URLs correct te maken
  normalizeUri(uri) {
    if (uri.startsWith("ipfs://")) {
      return uri.replace("ipfs://", "https://ipfs.io/ipfs/")
    }
    return uri
  }

  renderNFT(tokenId, tokenUri, metadata){
    const div = document.createElement("div")
    div.innerHTML = `
        <div class="rounded border p-2 mb-5">
          <img src="${this.normalizeUri(metadata.image)}" alt="NFT ${tokenId}" class="w-full h-auto rounded">
          <h3 class="mt-2 font-bold">${metadata.name || `NFT #${tokenId}`}</h3>
          <p class="text-sm text-gray-600">${metadata.description || ""}</p>
        </div>
      `
    this.gridTarget.appendChild(div)
  }

}


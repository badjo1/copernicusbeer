import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="user-session"
export default class extends Controller {
  static targets = [ "eth_signature", "eth_message", "eth_address", "error_message"]
  static values = { apiUrl: {type: String, default: '/get_nonce/' } }
    
  connect() {     
    this.eth_signatureTarget.hidden = true
    this.eth_messageTarget.hidden = true
    this.eth_addressTarget.hidden = true
  }

  async login(event) {
    console.log('login...')
    const btnSubmit = event.currentTarget
    btnSubmit.disabled = true

    
    // only proceed with ethereum context available
    if (typeof window.ethereum == 'undefined') {
      this.error_messageTarget.innerHTML = "No Ethereum Context Available"
      event.preventDefault()
      return false;
    }
    
    // request accounts from ethereum provider
    const accounts = await ethereum.request({ method: 'eth_requestAccounts' })
    const etherbase = accounts[0];
    console.log('etherbase...'+etherbase); 

    // sign a message with current time and nonce from database
    const nonce = await this.getUuidByAccount(etherbase);  
    console.log('nonce...'+nonce);

    if (nonce) {
      const customTitle = "Beer on Copernicus";
      const requestTime = new Date().getTime();
      //const message = customTitle + "," + requestTime + "," + nonce;
      const message = nonce;
      console.log('message:'+message)  
      const signature = await this.personalSign(etherbase, message);
      console.log('signature:'+signature)  
      // populate and submit form
      this.eth_signatureTarget.value = signature;
      this.eth_messageTarget.value = message;
      this.eth_addressTarget.value = etherbase;
      console.log('populate fields') 
      btnSubmit.form.submit();
      return true
    }

  }

 // request ethereum signature for message from account
  async personalSign(account, message) {
    try {
      const signature = await ethereum.request({ method: 'personal_sign', params: [ message, account ] });
      return signature;
    }
    catch(err) {
      this.error_messageTarget.innerHTML = err.message;
    }
  }
  
  async getUuidByAccount(account) {
    const response = await fetch(this.apiUrlValue + account);
    const nonceJson = await response.json();
    if (!nonceJson) return null;
    const uuid = nonceJson[0].nonce_token;
    return uuid;
  }

}
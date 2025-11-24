# 🌾 Subsidy Voucher DApp

<p align="center">
  <img src="assets/banner.png" alt="Subsidy Voucher DApp Banner" width="100%">
</p>

<p align="center">
  <img src="https://img.shields.io/badge/Solidity-0.8.0-blue?logo=solidity">
  <img src="https://img.shields.io/badge/Ethers.js-v5-yellow?logo=javascript">
  <img src="https://img.shields.io/badge/MetaMask-Compatible-orange?logo=metamask">
  <img src="https://img.shields.io/badge/LICENSE-MIT-green">
</p>

A decentralized blockchain system for issuing and redeeming **agricultural subsidy vouchers**, designed to increase transparency, reduce fraud, and streamline subsidy distribution between **Government Funders**, **Farmers**, and **Agro-Input Suppliers**.

This project uses:

- **Solidity (Ethereum Smart Contracts)**
- **Remix IDE for deployment**
- **Ethers.js**
- **MetaMask**
- **HTML/JavaScript Frontend**

---

## 🚀 Project Overview

The Subsidy Voucher DApp enables:

### 👤 **Funder**

- Registers suppliers
- Issues subsidy vouchers to farmers
- Views all registered suppliers

### 🏪 **Supplier**

- Connects their MetaMask account
- Redeems vouchers issued to farmers
- Verifies voucher validity and timestamps

### 👨‍🌾 **Farmer**

- Receives subsidy vouchers
- Their address is recorded in the blockchain for tracking

---

## ✨ Features

- 🔐 **Role-based access**
- 🧾 **Immutable ledger of issued vouchers**
- ✔ **Prevent double redemption**
- 🌐 **MetaMask wallet integration**
- 🔎 **Voucher detail viewer**
- 🧱 **On-chain supplier registration**
- 🔄 **Account switching from UI dropdown**

---

## 🏛 Smart Contract

The Solidity contract includes:

- `registerSupplier(address)`
- `issueVoucher(address farmer, uint amount)`
- `redeemVoucher(uint voucherId)`
- `getAllSuppliers()`
- `mapping(address => bool) isSupplier`
- `Voucher` struct for full on-chain voucher tracking

Contract file name (recommended):

SubsidyVouchers.sol

yaml
Copy code

---

## 📁 Project Structure

project/
│
├── index.html
├── script.js (optional) # JS logic (or embedded in HTML)
├── SubsidyVouchers.sol # Smart contract
├── README.md # Documentation
└── assets/ # (optional) screenshots, icons

yaml
Copy code

---

## 🧰 Prerequisites

Before running this project, ensure you have:

| Tool                        | Required                    |
| --------------------------- | --------------------------- |
| **MetaMask** browser wallet | ✔ YES                       |
| **Remix IDE**               | For deployment              |
| **Node.js** (optional)      | If using a local dev server |
| **Live Server** (VS Code)   | Recommended                 |

---

## 🧪 Deploying the Smart Contract

1. Open **Remix IDE**
2. Create a new file `SubsidyVouchers.sol`
3. Paste the provided smart contract code
4. Compile using **Solidity 0.8.x**
5. Use **Injected Provider (MetaMask)** to deploy
6. Copy the deployed **contract address**

---

## 🖥 Running the Frontend (DApp UI)

### Option 1 — VS Code Live Server (Recommended)

1. Open the project folder in VS Code
2. Right-click `index.html`
3. Select **“Open with Live Server”**

Your DApp opens at something like:

http://127.0.0.1:5500/

yaml
Copy code

MetaMask will now inject correctly into the browser.

---

### Option 2 — Simple Node HTTP Server

Install:

```bash
npm install -g http-server

Run:
bash
Copy code
http-server .

Open:
arduino
Copy code
http://localhost:8080

🔌 Connecting MetaMask
Click Connect Wallet in the UI.
You will see:

All MetaMask accounts exposed to the DApp
Highlighted roles (Funder, Supplier, Other)
Only funder can register suppliers / issue vouchers
Only suppliers can redeem vouchers

To expose more accounts:

Open MetaMask
Create or import more accounts
Refresh the DApp
Click Connect Wallet again

🎭 Role Detection (How It Works)
The UI automatically identifies your role by reading on-chain data:

Funder
The wallet that deployed the contract.

Supplier
Any address that funder registered using:

scss
Copy code
registerSupplier(address)

Other
Any exposed MetaMask address with no role.

🎨 UI Overview
✔ Separate panels for Funder and Supplier
✔ Voucher viewer
✔ Dropdown to switch acting wallet

Screenshots (add your own):

bash
Copy code
assets/connect-wallet.png
assets/funder-panel.png
assets/supplier-panel.png

🧩 How the System Works
1. Funder registers supplier
Supplier address stored both in:

mapping
array supplierList[]

2. Funder issues voucher
Voucher fields stored on-chain:

farmer
amount
issue timestamp
status

3. Supplier redeems voucher
Contract:

Checks supplier is registered
Ensures voucher exists
Prevents double redemption
Saves redemption timestamp

🧪 Testing Scenarios
Test the following in your DApp:

✔ Funder issuing a voucher
✔ Supplier redeeming
✔ Attempt redemption with unregistered account
→ should fail

✔ Two suppliers trying to redeem the same voucher
→ should fail

🛡 Security Considerations
All critical functions use role-based access control

Vouchers cannot be redeemed twice

Supplier list kept on-chain for transparency

No upgradeability → safer for simple deployments

📜 License
This project is released under the MIT License.
Feel free to modify and use for academic, governmental, or commercial purposes.

🙌 Acknowledgements
Ethereum Foundation
MetaMask
Ethers.js team
Kenya’s agricultural subsidy programs (inspiration)
```

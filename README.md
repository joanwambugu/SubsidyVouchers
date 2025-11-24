Subsidy Voucher DApp 🌾
A decentralized application for managing agricultural subsidy vouchers on the blockchain. This DApp allows funders to issue digital vouchers to farmers, which can then be redeemed at authorized suppliers for agricultural inputs.

Features
Wallet Integration: Connect MetaMask wallet to interact with the DApp

Role-Based Access: Separate functionalities for Funders and Suppliers

Voucher Management: Issue, redeem, and track subsidy vouchers

Supplier Registration: Funders can register/unregister suppliers

Real-time Status: View voucher status (Not Issued, Issued, Redeemed, Expired)

Blockchain Transparency: All transactions are recorded on the blockchain

Smart Contract Functions
Funder Functions
registerSupplier(address _supplier) - Register new suppliers

unregisterSupplier(address _supplier) - Remove supplier authorization

issueVoucher(address _farmer, uint256 _amount) - Create new vouchers for farmers

Supplier Functions
redeemVoucher(uint256 _voucherId) - Redeem vouchers from farmers

View Functions
vouchers(uint256) - Get voucher details by ID

getAllSuppliers() - List all registered suppliers

isSupplier(address) - Check if address is an authorized supplier

funder() - Get contract owner address

Voucher Status Types
Not Issued: Voucher ID doesn't exist yet

Issued: Voucher created but not redeemed

Redeemed: Voucher has been used by supplier

Expired: Voucher is no longer valid

Installation & Setup
Prerequisites
MetaMask browser extension

Ethereum wallet with test ETH

Modern web browser

Local Development
Clone the repository:

bash
git clone https://github.com/joanwambugu/SubsidyVouchers.git
Open index.html in your browser or serve using a local server:

bash
# Using Python
python -m http.server 8000

# Using Node.js
npx http-server
Access the DApp at http://localhost:8000

Smart Contract Deployment
Compile and deploy SubsidyVouchers.sol to your preferred Ethereum network

Update the contract address in the DApp interface

Connect your wallet and start managing vouchers

Usage Guide
For Funders
Connect your wallet (must be the contract deployer)

Load the contract using the deployed address

Register suppliers who can redeem vouchers

Issue vouchers to farmer addresses with specified amounts

For Suppliers
Connect your wallet with a registered supplier account

Ensure the contract is loaded

Redeem vouchers using the voucher ID provided by farmers

For Everyone
View voucher details by entering the voucher ID

Check real-time status of any voucher

Technology Stack
Frontend: HTML, CSS, JavaScript

Blockchain: Ethereum, Solidity

Web3 Library: Ethers.js

Wallet: MetaMask

Icons: Font Awesome

Contract Address
Update this with your deployed contract address

text
0x...
Network Support
Ethereum Mainnet

Ethereum Testnets (Goerli, Sepolia)

Local Development Networks (Ganache, Hardhat)

Security Features
Role-based access control

Input validation

Only authorized suppliers can redeem vouchers

Immutable transaction records

Contributing
Fork the repository

Create a feature branch

Commit your changes

Push to the branch

Create a Pull Request

Built with ❤️ for transparent agricultural subsidy management
# NFT Marketplace

A comprehensive NFT marketplace built on the Stacks blockchain using Clarity smart contracts. This marketplace supports NFT minting, trading, collections, auctions, and royalty management.

## 🚀 Features

### Core Functionality
- **NFT Minting & Trading**: Create and trade unique digital assets
- **Collection Management**: Organize NFTs into themed collections
- **Auction System**: Timed auctions for high-value NFTs
- **Royalty System**: Automatic royalty distribution to creators
- **Marketplace Listings**: Buy/sell NFTs with flexible pricing

### Smart Contracts

#### 1. NFT Contract (\`nft-contract.clar\`)
- Implements SIP-009 NFT standard
- Handles minting, transfers, and metadata
- Supports royalty information storage

#### 2. Marketplace Contract (\`marketplace-contract.clar\`)
- Manages NFT listings and sales
- Handles royalty distribution
- Processes marketplace fees
- Supports both fixed-price and negotiable listings

#### 3. Collection Contract (\`collection-contract.clar\`)
- Creates and manages NFT collections
- Handles collection metadata and themes
- Manages collection ownership and permissions

#### 4. Auction Contract (\`auction-contract.clar\`)
- Implements timed auction functionality
- Handles bid management and validation
- Automatic settlement and fund distribution
- Support for reserve prices and buy-now options

## 📋 Prerequisites

- Stacks CLI
- Clarinet (for local development)
- Node.js 16+ (for testing)
- Stacks Wallet

## 🛠️ Installation

1. Clone the repository:
   \`\`\`bash
   git clone <repository-url>
   cd nft-marketplace
   \`\`\`

2. Install dependencies:
   \`\`\`bash
   npm install
   \`\`\`

3. Initialize Clarinet project:
   \`\`\`bash
   clarinet new nft-marketplace
   \`\`\`

## 🧪 Testing

Run the test suite using Vitest:

\`\`\`bash
npm test
\`\`\`

Run tests in watch mode:
\`\`\`bash
npm run test:watch
\`\`\`

## 📁 Project Structure

\`\`\`
nft-marketplace/
├── contracts/
│   ├── nft-contract.clar
│   ├── marketplace-contract.clar
│   ├── collection-contract.clar
│   └── auction-contract.clar
├── tests/
│   ├── nft-contract.test.js
│   ├── marketplace-contract.test.js
│   ├── collection-contract.test.js
│   └── auction-contract.test.js
├── scripts/
│   └── deploy.js
├── README.md
├── PR_DETAILS.md
└── package.json
\`\`\`

## 🚀 Deployment

1. Configure your deployment settings in \`Clarinet.toml\`
2. Deploy to testnet:
   \`\`\`bash
   clarinet deploy --testnet
   \`\`\`

3. Deploy to mainnet:
   \`\`\`bash
   clarinet deploy --mainnet
   \`\`\`

## 📖 Usage

### Minting NFTs
\`\`\`clarity
(contract-call? .nft-contract mint-nft u1 'SP1234... "metadata-uri")
\`\`\`

### Creating Collections
\`\`\`clarity
(contract-call? .collection-contract create-collection "Collection Name" "Description" 'SP1234...)
\`\`\`

### Listing NFTs
\`\`\`clarity
(contract-call? .marketplace-contract list-nft u1 u1000000 'SP1234...)
\`\`\`

### Starting Auctions
\`\`\`clarity
(contract-call? .auction-contract create-auction u1 u500000 u1000000 u144)
\`\`\`

## 🔧 Configuration

### Marketplace Settings
- **Marketplace Fee**: 2.5% (configurable)
- **Royalty Cap**: 10% maximum
- **Auction Duration**: Minimum 24 blocks (~4 hours)

### Contract Addresses
Update contract addresses in your deployment configuration:
- NFT Contract: \`SP...nft-contract\`
- Marketplace Contract: \`SP...marketplace-contract\`
- Collection Contract: \`SP...collection-contract\`
- Auction Contract: \`SP...auction-contract\`

## 🤝 Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the LICENSE file for details.

## 🆘 Support

For support and questions:
- Create an issue in the repository
- Join our Discord community
- Check the documentation wiki

## 🔮 Roadmap

- [ ] Multi-chain support
- [ ] Advanced auction types (Dutch auctions)
- [ ] NFT fractionalization
- [ ] Governance token integration
- [ ] Mobile app development
- [ ] Layer 2 scaling solutions

# LITHplus
The ERC-1155 Token for the ESG Platform and Company Data

# INSTALL TASKS

npm install --safe-dev hardhat
yarn

# COMPILE & TEST TASKS

yarn hardhat compile
yarn hardhat test

# DEPLOYMENT

create .env file from .env.example updated contents

yarn hardhat run scripts/deploy-lithplus.js --network ropsten
yarn hardhat run scripts/deploy-lithplusproxy.js --network ropsten

# CONTRACT SIZES

yarn hardhat size-contracts

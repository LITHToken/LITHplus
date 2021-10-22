const hre = require("hardhat");

async function main() {
  const LITHplus = await hre.ethers.getContractFactory("LITHplus");
  const token = await LITHplus.deploy();

  await token.deployed();
  await token.initialize("https://ipfs.io/ipfs/", 
    ["QmQntdqVXEf1coijvwNi3a5CiRrrg3dfAEc3fmFRUsgWyM", "QmeMVv4xmRHKu39GomAtt9HAYxQU7cmeJ5QL3fTNvEMD36"]);

  console.log("LITHplus deployed to:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

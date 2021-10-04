const hre = require("hardhat");

async function main() {
  const LITHplus = await hre.ethers.getContractFactory("LITHplus");
  const token = await LITHplus.deploy();

  await token.deployed();
  await token.initialize("https://www.lithtoken.io/", []);

  console.log("LITHplus deployed to:", token.address);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

import { ethers } from "hardhat";

async function main() {
  const contract = await ethers.getContractFactory("DabbyICO");

  const deployContract = await contract.deploy();

  await deployContract.deployed();

  console.log("DabbyICO Token Deployed Here", deployContract.address);

  // Dabby Token Deployed Here 0x4458A3a6e063EAf915D7b4dbc1ae0FB524f7519f;
  // DabbyICO Token Deployed Here 0x98e236992030E2Fb76F75B8f5E264001472f121E

//   


  
}

// We recommend this pattern to be able to use async/await everywhere
// and properly handle errors.
main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
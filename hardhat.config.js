require("@nomicfoundation/hardhat-toolbox");
require('dotenv').config();

/** @type import('hardhat/config').HardhatUserConfig */
module.exports = {
  solidity: "0.8.27",
  networks: {
    localhost:{
      url:"http://127.0.0.1:8545/"
    },
    sepolia: {
      url: process.env.ALCHEMY_API,
      accounts:[process.env.PRIVATE_KEY]
    }
  }
};

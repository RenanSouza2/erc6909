import { HardhatUserConfig } from 'hardhat/config';
import '@nomicfoundation/hardhat-toolbox';
import 'hardhat-exposed';


const config: HardhatUserConfig = {
  solidity: '0.8.23',
  exposed: {
    prefix: '$',
  },
};

export default config;

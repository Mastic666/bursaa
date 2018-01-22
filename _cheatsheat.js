/*
npm version patch
npm publish

parity --testnet --jsonrpc-apis web3,eth,net,parity,traces,rpc,personal


parity --chain=ropsten --jsonrpc-apis web3,eth,net,parity,traces,rpc,personal --bootnodes="enode://256405c3af6b9369c84bb90927c99a1edabe061a62e3c7bec19f23e3c8ad6fea9cc5c47e174435bbb415852e344ad9d7bb61c158e69fb5f29f16cc787f85cf2c@92.111.252.195:63451,enode://27f7328ef96a15f6f47ddeba8ba2a50952e430a3f294bd0e479e47239123167ba67fb46057405b1baa1716ee8ef5cd58b982b241e82d1fd8f5891d77f1a84a51@85.223.209.56:51938,enode://42de7d88a5473d6317f1826ca87689b2b9566a2ece72da0c78d529b61295264b2aec8c13fc3e2d1f5d05fbfb0c2ab98af2c64a6f6fa9dc7236b28d97323d2ba4@136.62.220.147:30303,enode://6991bbef05ca85e9cb0cfab1b8f9427500bb004ff21edb189760d146bf5f37015202b565e0af752f2975f3f8bdc672ab8b39d378b0911874883ac70cdf23c83d@121.122.127.186:45534,enode://9e99e183b5c71d51deb16e6b42ac9c26c75cfc95fff9dfae828b871b348354cbecf196dff4dd43567b26c8241b2b979cb4ea9f8dae2d9aacf86649dafe19a39a@51.15.79.176:41462,enode://9eccca5941e191de1f43345c7bbcb8a0a77fe383329d5f85da72d445f72bb9561768118443604b474022ce7e9dc58779acc8486fb882801e61a800ca0c089930@140.112.238.158:37162,enode://f55d3f3a5e21bb4e0bcd046ccc880f4e79bddee570a9909c72de61470b48e0309d38460b28408c50d689cf4629a3bb0877f7556d142950cb3d3b3251ced405a1@52.212.59.171:30303,enode://94c15d1b9e2fe7ce56e458b9a3b672ef11894ddedd0c6f247e0f1d3487f52b66208fb4aeb8179fce6e3a749ea93ed147c37976d67af557508d199d9594c35f09@192.81.208.223:30303"


  await show();

  var privkey = new Buffer('3c9229289a6125f7fdf1885a77bb12c37a8d3b4962d936f7e3084dece32a3ca1', 'hex');
  var data = ethUtils.sha3('a');
  var vrs = ethUtils.ecsign(data, privkey);
  var pubkey = ethUtils.ecrecover(data, vrs.v, vrs.r, vrs.s);
  // Check !
  var check1 = pubkey.toString('hex') ==
      ethUtils.privateToPublic(privkey).toString('hex');
  var check2 = ethUtils.publicToAddress(pubkey).toString('hex') ==
      ethUtils.privateToAddress(privkey).toString('hex');

  console.log(check1);
  console.log(check2);

// var previousBlock = 1000;
// var options = {
//   fromBlock: previousBlock,
//   toBlock: "previousBlock" + 100,
//   address: "0xab1323fe3234234234fa34324324234af3423432",
// };
//
// var sub = web3.eth.subscribe('logs',options); // for example options = {address: '0x123456..',    topics: ['0x12345...']}
// sub.on('data',function(result){
// console.log(result);
// });



//
// web3.eth.personal.newAccount('password')
// .then(function (result) {
//       web3.eth.accounts[0] = result;
//       console.log(result);
//   }, function (result) {
//       console.error(result);
//   })
//
//  web3.eth.personal.unlockAccount(web3.eth.accounts[0].address, "password", 0);


// var password = 'password';
// try {
//   // console.log(web3.eth.coinbase);
//   web3.eth.personal.unlockAccount(web3.eth.accounts[0], password);
// } catch(e) {
//   console.log('UNLOCK FAILED', e);
//   return;
// }



// const solc = require('solc');
// const input = fs.readFileSync('bursa.sol');
// const output = solc.compile(input.toString(), 1);
// const bytecode = output.contracts['Token'].bytecode;
// const abi = JSON.parse(output.contracts['Token'].interface);


// web3.eth.accounts.privateKeyToAccount('0x348ce564d427a3311b6536bbcff9390d69395b06ed6c486954e971d960fe8709');


// var Web3 = require('Web3');
// web3 = new Web3(new Web3.providers.HttpProvider("http://localhost:8545"));


//
// web3.eth.personal.newAccount('password')
// .then(function (result) {
//       web3.eth.accounts[0] = result;
//       console.log(result);
//   }, function (result) {
//       console.error(result);
//   })
//
//  web3.eth.personal.unlockAccount(web3.eth.accounts[0].address, "password", 0);


// var password = 'password';
// try {
//   // console.log(web3.eth.coinbase);
//   web3.eth.personal.unlockAccount(web3.eth.accounts[0], password);
// } catch(e) {
//   console.log('UNLOCK FAILED', e);
//   return;
// }



// const solc = require('solc');
// const input = fs.readFileSync('bursa.sol');
// const output = solc.compile(input.toString(), 1);
// const bytecode = output.contracts['Token'].bytecode;
// const abi = JSON.parse(output.contracts['Token'].interface);


// web3.eth.accounts.privateKeyToAccount('0x348ce564d427a3311b6536bbcff9390d69395b06ed6c486954e971d960fe8709');
*/

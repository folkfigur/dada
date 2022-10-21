// example of signing 
var fs = require('fs');

main = async ()=>{
    const ethers = require("ethers")
    let privateKey = 'b357d68856ea9a7b584b116d20c3df895f523d26c36040fcc9f5375d852c1e35';
    let wallet = new ethers.Wallet(privateKey);

    // console.log(wallet.address);
    // "0x14791697260E4c9A71f18484C9f997B308e59325"


    // Sign the string message
    
    let flatSig = await wallet.signMessage(fs.readFileSync("json-for-mint/folkfigur#42.json", { encoding: 'utf8' }));
    console.log(flatSig);
};

main();

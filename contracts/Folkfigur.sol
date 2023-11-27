// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

import "./common/meta-transactions/ContentMixin.sol";
import "./common/meta-transactions/NativeMetaTransaction.sol";


/*
 * 
.----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------.  .----------------. 
| .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. || .--------------. |
| |  _________   | || |     ____     | || |   _____      | || |  ___  ____   | || |  _________   | || |     _____    | || |    ______    | || | _____  _____ | || |  _______     | |
| | |_   ___  |  | || |   .'    `.   | || |  |_   _|     | || | |_  ||_  _|  | || | |_   ___  |  | || |    |_   _|   | || |  .' ___  |   | || ||_   _||_   _|| || | |_   __ \    | |
| |   | |_  \_|  | || |  /  .--.  \  | || |    | |       | || |   | |_/ /    | || |   | |_  \_|  | || |      | |     | || | / .'   \_|   | || |  | |    | |  | || |   | |__) |   | |
| |   |  _|      | || |  | |    | |  | || |    | |   _   | || |   |  __'.    | || |   |  _|      | || |      | |     | || | | |    ____  | || |  | '    ' |  | || |   |  __ /    | |
| |  _| |_       | || |  \  `--'  /  | || |   _| |__/ |  | || |  _| |  \ \_  | || |  _| |_       | || |     _| |_    | || | \ `.___]  _| | || |   \ `--' /   | || |  _| |  \ \_  | |
| | |_____|      | || |   `.____.'   | || |  |________|  | || | |____||____| | || | |_____|      | || |    |_____|   | || |  `._____.'   | || |    `.__.'    | || | |____| |___| | |
| |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | || |              | |
| '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' || '--------------' |
'----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------'  '----------------' 
 * 
 * Solidity contract of Folkfigur
 * 
 * 
 */ 
// here we use c3 linearization
contract Folkfigur is  ERC721, ContextMixin, NativeMetaTransaction {
    
    // we do math with guarantees
    using SafeMath for uint256;
    
    // +1 -1
    using Counters for Counters.Counter;
    
    Counters.Counter private _tokenIds;

    // the credits of the art piece
    string credits;
    
    // the address of the deployer (folkfigur.eth)
    address creator;
    
    // role model: BAYC
    uint128 MAX_FOLKFIGUR = 10000;
    
    constructor()
    ERC721("Folkfigur", "FLK")
    {
        creator = msg.sender;
    }
    
    function setCredits(string calldata param) external {
       require(msg.sender == creator, "you're not creator");
       credits = param;
    }

   struct FolkfigurPiece {
        bytes32 piece; // the IPFS id of the description file
        uint256 tokenId;
    }
            
    
    
    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return creator;
    }
    
    /**
     * @notice Mapping for storing id -> piece
     */
    mapping(uint256 => FolkfigurPiece) private _pieces;
    
    
    function getFolkfigurByIndex(uint256 index) public view returns (bytes32, uint256) {
        return (
            _pieces[index].piece,
            _pieces[index].tokenId
        );
    }
    
    bytes constant ALPHABET =
    "123456789ABCDEFGHJKLMNPQRSTUVWXYZabcdefghijkmnopqrstuvwxyz";
        
    /**
        * @notice encode is used to encode the given bytes in base58 standard.
        * @param data_ raw data, passed in as bytes.
        * @return base58 encoded data_, returned as bytes.
        * 
        * from https://github.com/storyicon/base58-solidity/ MIT LICENSE
        */
    function encode(bytes memory data_) internal pure returns (bytes memory) {
        unchecked {
            uint256 size = data_.length;
            uint256 zeroCount;
            while (zeroCount < size && data_[zeroCount] == 0) {
                zeroCount++;
            }
            size = zeroCount + ((size - zeroCount) * 8351) / 6115 + 1;
            bytes memory slot = new bytes(size);
            uint32 carry;
            int256 m;
            int256 high = int256(size) - 1;
            for (uint256 i = 0; i < data_.length; i++) {
                m = int256(size - 1);
                for (carry = uint8(data_[i]); m > high || carry != 0; m--) {
                    carry = carry + 256 * uint8(slot[uint256(m)]);
                    slot[uint256(m)] = bytes1(uint8(carry % 58));
                    carry /= 58;
                }
                high = m;
            }
            uint256 n;
            for (n = zeroCount; n < size && slot[n] == 0; n++) {}
            size = slot.length - (n - zeroCount);
            bytes memory out = new bytes(size);
            for (uint256 i = 0; i < size; i++) {
                uint256 j = i + n - zeroCount;
                out[i] = ALPHABET[uint8(slot[j])];
            }
            return out;
        }
    }
        
    // // https://raw.githubusercontent.com/MrChico/verifyIPFS/master/contracts/verifyIPFS.sol MIT License
    function toBytes(bytes32 input) internal pure returns (bytes memory) {
        bytes memory output = new bytes(32);
        for (uint8 i = 0; i<32; i++) {
            output[i] = input[i];
        }
        return output;
    }
    
    function tokenURI(uint256 _tokenId) override public view returns (string memory) {
        //return string(abi.encodePacked("ipfs://Qm", verifyIPFS.toBase58(verifyIPFS.toBytes(_pieces[_tokenId].piece))));
        return string(abi.encodePacked("ipfs://", encode(abi.encodePacked(hex"1220", toBytes(_pieces[_tokenId].piece)))));
    }
    
        
    function mintFolkFigur(bytes32 ipfs) 
    external
    returns (uint256)
    {
        require(msg.sender == creator, "only folkfigur.eth can mint");
        require(_tokenIds.current() <= MAX_FOLKFIGUR, "all folkfigur have been minted"); 
        uint256 newItemId = mintToCaller(msg.sender);
        _pieces[newItemId].piece = ipfs;
        _pieces[newItemId].tokenId = newItemId;
        return newItemId;
    }
    
    // increment the token id 
    function mintToCaller(address caller) 
    internal
    returns (uint256)
    {
        _tokenIds.increment();        
        uint256 newItemId = _tokenIds.current();
        _safeMint(caller, newItemId);
        return newItemId;
    }
    
    /**
     *        @dev Returns the total tokens minted so far.
     *        1 is always subtracted from the Counter since it tracks the next available tokenId.
     */
    function totalSupply() public view returns (uint256) {
        return _tokenIds.current();
    }
    
}

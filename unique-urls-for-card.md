The unique-urls-for-card.xlsx file includes 256 fake keys, which serve two purposes
 - bencmark printing services to print cool cards with unique QR codes pointing to a key
 - build the web page that loads the unique artpiece owned by the owner of a key

# Benchmark printers

Specification for a safe and creative printing service
 - support secure communication channels to share the file that contains the keys
 - transform each key in a QR code
 - ability to print unique cards with a QR code
 - provide nice material for the card


# Web page to load a Folkfigur

The web page loads the unique folkfigur of the key's owner
1. retrieve the hash part of address. This provides the key
2. resolve the address of the NFT owner with the key. Done with web3.js
3. ask the FLK contract to return the JSON file that is owned by the NFT owner. The JSON data file is stored on the blockchain and contains everything that is needed to regenerate the unique Folkfigur
4. load the folkfigur code to generate the artpiece, pass it the JSON file and load the generated piece in the web page

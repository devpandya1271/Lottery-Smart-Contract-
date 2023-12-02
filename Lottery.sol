// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// 1. OWNER ACCOUNT(Mnager) Deployer
// 2. EK FUN JO ADD LEGA AUR INDEX ALLOT KEREGA
// 3. array jisne index k according info jyega.
// 4. Array k max index se random number genertate krega.

contract Lottry {
    //Address array where info will be stored off the entery
    address owner;
    address[] players;

    //Constructor to send the owner of the contract
    constructor() {
        owner = msg.sender;
    }

    modifier OnlyOwner() {
        owner == msg.sender;
        _;
    }
    //Function to enter the lottry
    error throwError(string, address);

    function ENTER() public payable {
        for (uint _i; _i < players.length; _i++) {
            if (msg.sender == players[_i])
                revert throwError("Fuck off! Duplicate", msg.sender);
        }
        require(msg.value > 1e16, "Inshuffient Eth");
        players.push() = msg.sender;
    }

    //Pick random number for the winner
    uint public randNo;

    function SlectWinner() public OnlyOwner returns (string memory, address) {
        require(players.length > 3, "NOT ENOUGH PLAYER");

        randNo =
            uint(
                keccak256(abi.encodePacked(msg.sender, block.timestamp, randNo))
            ) %
            players.length;
        Send();
        return ("Winner is", players[randNo]);
    }

    function Send() internal {
        address payable winner = payable(players[randNo]);
        (bool sent, ) = winner.call{value: address(this).balance}("");
        require(sent, "Tx fail!");
    }
}

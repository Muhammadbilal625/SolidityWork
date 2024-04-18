// SPDX-License-Identifier: MIT
pragma solidity ^0.8.24;

interface IERC165 {
    function supportsInterface( bytes4 interfceID)
    external view returns(bool);
}
interface IERC721 is IERC165{
    function balanceOf(address owner) external view returns (uint256 balance);
    function ownerOf(uint256 tokenId) external view returns (address owner);
    function safeTransferFrom(
        address from ,address to,uint256 tokenId) external;
    function safeTransferFrom(
        address from,address to,uint256 id,bytes calldata data) external ;
    function transferFrom(address from ,address to, uint256 tokenId) external;
    function approve(address to,uint256 tokenId) external;
    function getApproved( uint256 tokenId)
    external view returns(address operator);
    function setApprovalForAll(address operator ,bool _approved) external ;
    function isApprovedForAll(address owner,address operator)
    external  view returns(bool);
}
interface IERC721Receiver {
    function onERC721Received(
        address operator,
        address from ,
        uint256 tokenId,
        bytes calldata data ) external returns(bytes4);
    }
contract ERC721 is IERC721{
    event Transfer(address indexed from,address indexed to,uint256 indexed id);
    event Approval(address indexed owner,address indexed spender,uint256 indexed id);
    event ApprovalForAll(address indexed owner,address indexed operator,bool approved);
    // ID to owner Address 
    mapping(uint256 => address ) internal _ownerOf;
    //owner to token count
    mapping(address => uint256) internal _balanceOf;
    // tokenId to approved address
    mapping(uint256 => address) internal _approvals;
    //owner->operator->bool
    mapping(address => mapping(address => bool))public isApprovedForAll;
    function supportsInterface(bytes4 interfaceId) external pure returns(bool){
        return interfaceId==type(IERC721).interfaceId ||
         interfaceId == type(IERC165).interfaceId;
    }
    function ownerOf(uint256 id) external view returns (address owner){
        owner=_ownerOf[id];
        require(owner != address(0),"Token doesn't Exists");
    }
     function balanceOf(address owner) external view returns (uint256){
        require(owner != address(0),"Token doesn't Exists or owner == 0x00.. address ");
        return _balanceOf[owner];
    }
    function setApprovalForAll( address operator ,bool approved)external{
        isApprovedForAll[msg.sender][operator]=approved;
        emit ApprovalForAll(msg.sender, operator, approved);
    }
    function approve(address spender,uint256 id) external {
        address owner=_ownerOf[id];
        require(msg.sender==owner || isApprovedForAll[owner][msg.sender],"Not Authorized");

        _approvals[id]=spender;
        emit Approval(owner, spender, id);
    }

    function getApproved(uint256 id) external view returns (address){
        require(_ownerOf[id]!=address(0),"Token not Exists");
        return _approvals[id];
    }
    function _isApprovedOrOwner(address owner,address spender,uint256 id)
    internal view returns(bool){
        return( owner==spender || isApprovedForAll[owner][spender]||
        spender==_approvals[id]);

    }
    function transferFrom(address from, address to, uint256 id) public {
        require(from == _ownerOf[id], "from != owner");
        require(to != address(0), "transfer to zero address");

        require(_isApprovedOrOwner(from, msg.sender, id), "not authorized");

        _balanceOf[from]--;
        _balanceOf[to]++;
        _ownerOf[id] = to;

        delete _approvals[id];

        emit Transfer(from, to, id);
    }

    function safeTransferFrom(address from,address to,uint256 id) external {
        transferFrom(from, to, id);
        require(
            to.code.length==0
             || IERC721Receiver(to).onERC721Received(msg.sender,from,id,"") ==
             IERC721Receiver.onERC721Received.selector,"Unsafe Recipient");
    }

    function safeTransferFrom(address from,address to,uint256 id,bytes calldata data)
    external {
        transferFrom(from, to, id);
        require(
            to.code.length==0
             || IERC721Receiver(to).onERC721Received(msg.sender,from,id,data) ==
             IERC721Receiver.onERC721Received.selector,"Unsafe Recipient");
    }


    function _mint(address to,uint256 id) internal {
        require(to != address(0),"Mint To 0x00... Adddresss ");
        require(_ownerOf[id]==address(0),"Already Minted ");

        _balanceOf[to]++;
        _ownerOf[id] =to;

        emit Transfer(address(0), to, id);

    }
    function _burn(uint256 id)internal {
        address owner=_ownerOf[id];
        require(owner != address(0), "Not Minted Token");
        _balanceOf[owner]-=1;

        delete _ownerOf[id];
        delete _approvals[id];

        emit Transfer(owner, address(0), id);
    }
}

contract MyNFT is ERC721 {
    function mint(address to, uint256 id) external {
        _mint(to, id);
    }

    function burn(uint256 id) external {
        require(msg.sender == _ownerOf[id], "not owner");
        _burn(id);
    }
}

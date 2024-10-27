{ config, lib, ... }:
let
  hostName = lib.strings.toLower config.networking.hostName;
  mkPeer = endpoint: publicKey: ip: {
    inherit endpoint publicKey;
    allowedIPs = [ ip ];
  };
  peer-rico0 = mkPeer "192.168.1.10:51830" "9mfgKUM6hXllEUunvI8szlni9OFpKSbaLVZRAhAh51Q=" "10.10.10.10";
  peer-rico1 = mkPeer "192.168.1.11:51831" "lFtIm7CX3gcHMAu673ptRzNDQh5QEa7FbzlHSQerRg0=" "10.10.10.11";
  peer-rico2 = mkPeer "192.168.1.12:51832" "FyFlOHfAprr474cJCXKRvgsU6o22xaQ8gzs1563AQnI=" "10.10.10.12";
  peer-wynne = mkPeer "192.168.1.13:51833" "re9z2AAKGaJrEn5Q+xp7XnZn4x4+GoJPLZScaXrnMC0=" "10.10.10.13";
  peer-layne = mkPeer "192.168.1.14:51834" "qhthtzB7vTGRfS1RGyP7RJ+BZLKd/BNxhaTJvAlYuyo=" "10.10.10.14";
  selectPeer = host: peer: if hostName == host then [ ] else [ peer ];
  interface-name = "Homelab";

in
{
  nodeconfig.wireguard = {
    inherit interface-name;
    endpoint = "165.232.180.97:51821";
    endpoint-publickey = "NNw/iDMCTq8mpHncrecEh4UlvtINX/UUDtCJf2ToFR4=";
    allowed-ips = if hostName == "skipper" then [ "10.10.10.0/24" ] else [ "10.10.10.1" "10.10.10.2" "10.10.10.3" ];
  };
  networking.wg-quick.interfaces.${interface-name}.peers = if hostName == "skipper" then [ ] else
  ((selectPeer "rico0" peer-rico0)
    ++ (selectPeer "rico1" peer-rico1)
    ++ (selectPeer "rico2" peer-rico2)
    ++ (selectPeer "wynne" peer-wynne)
    ++ (selectPeer "layne" peer-layne));
}

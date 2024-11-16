let
  mkPeer = endpoint: publicKey: allowedIPs: {
    inherit endpoint publicKey allowedIPs;
  };
in
{
  bifrost = mkPeer "165.232.180.97:51821" "NNw/iDMCTq8mpHncrecEh4UlvtINX/UUDtCJf2ToFR4=" [ "10.10.10.1" "10.10.10.2" "10.10.10.3" ];
  skipper = mkPeer null "ob8Ri5fYBCkksRnpbkq0kBlU0Ll3xjIPpMk8e9TKpl4=" [ "10.10.10.2" ];
  kowalski = mkPeer null "ZgtftftDNAnNsOKo34cgaP3lQim2HMmoCXayALIVsFU=" [ "10.10.10.3" ];
  rico0 = mkPeer "192.168.1.10:51830" "9mfgKUM6hXllEUunvI8szlni9OFpKSbaLVZRAhAh51Q=" [ "10.10.10.10" ];
  rico1 = mkPeer "192.168.1.11:51831" "lFtIm7CX3gcHMAu673ptRzNDQh5QEa7FbzlHSQerRg0=" [ "10.10.10.11" ];
  rico2 = mkPeer "192.168.1.12:51832" "FyFlOHfAprr474cJCXKRvgsU6o22xaQ8gzs1563AQnI=" [ "10.10.10.12" ];
  wynne = mkPeer "192.168.1.13:51833" "re9z2AAKGaJrEn5Q+xp7XnZn4x4+GoJPLZScaXrnMC0=" [ "10.10.10.13" ];
  layne = mkPeer "192.168.1.14:51834" "qhthtzB7vTGRfS1RGyP7RJ+BZLKd/BNxhaTJvAlYuyo=" [ "10.10.10.14" ];
}

{
  description = "rCore-dev";

  inputs = {
    nixpkgs.url = "https://mirrors.cernet.edu.cn/nix-channels/nixpkgs-unstable/nixexprs.tar.xz";
  };

  outputs = {self, nixpkgs, ...}:
  let 
    pkgs = import nixpkgs { inherit system;};
    system = "x86_64-linux";
    base = pkgs.appimageTools.defaultFhsEnvArgs;
  in {
    devShells.x86_64-linux.default = (pkgs.buildFHSEnv (base // {
        name = "rCore-dev";
        targetPkgs = pkgs: (base.targetPkgs pkgs) ++ (with pkgs; [
          qemu cargo-binutils # gdb gdbgui
        ]);
        runScript = "fish";
      })).env;
  };
}

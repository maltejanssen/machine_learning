{
  description = "C Template";

  inputs = {
    nixpkgs.url = "nixpkgs";
    systems.url = "github:nix-systems/x86_64-linux";
    flake-utils = {
      url = "github:numtide/flake-utils";
      inputs.systems.follows = "systems";
    };
  };

  outputs = { 
    self,
    nixpkgs,
    flake-utils,
    ...
  }:
  let
    system = "x86_64-linux";	
    pkgs = nixpkgs.legacyPackages.${system};    
  in
  {
    devShells.${system}.default = pkgs.mkShell {
      NIX_LD_LIBRARY_PATH = pkgs.lib.makeLibraryPath [ pkgs.stdenv.cc.cc ];
      packages = with pkgs; [                                                       
        python313                               
        uv
        pkgs.glib
        zlib
        libGL
        fontconfig
        xorg.libX11
        libxkbcommon
        freetype
        dbus
        stdenv
        python313Packages.tkinter
        tk  
      ];                                                                            
      shellHook = ''    
        export LD_LIBRARY_PATH=$NIX_LD_LIBRARY_PATH 
        uv init -q
        uv add --dev ipykernel
        uv run ipython kernel install --user --env VIRTUAL_ENV $(pwd)/.venv --name=project
        #uv run --with jupyter jupyter lab
        '';                   
    };
  };
}

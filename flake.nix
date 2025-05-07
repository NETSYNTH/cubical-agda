{ inputs =
  { nixpkgs =
    { url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    };
  };

  outputs =
  { self, nixpkgs, ... }:
    let systems = nixpkgs.lib.genAttrs
        [ "aarch64-linux"
          "x86_64-linux"
        ];

     in { packages = systems
          ( system: with import nixpkgs
            { inherit system;
            };
            { default = agda.withPackages
              ( with agdaPackages;
                [ cubical
                  standard-library
                ]
              );
            }
          );
        };
}

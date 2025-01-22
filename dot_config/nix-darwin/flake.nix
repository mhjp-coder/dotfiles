{
  description = "nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;
      nixpkgs.config.allowBroken = true;

      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.shells = [
        pkgs.fish
      ];
      environment.systemPackages = [
        pkgs.mkalias
        pkgs.neovim
        pkgs.git
        pkgs.starship
        pkgs.chezmoi
        pkgs.direnv
        pkgs.fzf
        pkgs.zoxide
        pkgs.uv
        pkgs.tldr
        pkgs.sqlite
        pkgs.openssh
        pkgs.fping
        pkgs.eza
        pkgs.bat
      ];

      # HomeBrew
      homebrew = {
        enable = true;
        brews = [
          "mas"
        ];
        casks = [
          "firefox"
          "the-unarchiver"
          "visual-studio-code"
          "ghostty"
        ];
        masApps = {
          "WireGuard" = 1451685025;
        };
        onActivation.cleanup = "zap";
      };

      # Install Fonts.
      fonts.packages = [
	pkgs.nerd-fonts.jetbrains-mono
      ];

      # enable packages
      programs.direnv.enable = true;
      programs.fish.enable = true;

      # macos System Settings.
      system.defaults = {
  	dock.autohide = true;
  	dock.mru-spaces = false;
	dock.show-recents = false;
	dock.static-only = true;
	dock.tilesize = 24;
	dock.orientation = "right";
	finder.ShowStatusBar = true;
	finder.FXRemoveOldTrashItems = true;
	finder.ShowPathbar = true;
  	finder.CreateDesktop = false;
	finder.AppleShowAllExtensions = true;
  	finder.FXPreferredViewStyle = "clmv";
  	loginwindow.LoginwindowText = "Darwin Nix";
	loginwindow.GuestEnabled  = false;
  	screencapture.location = "~/Pictures/screenshots";
  	screensaver.askForPasswordDelay = 10;
	trackpad.Clicking = true;
        trackpad.Dragging = true;
	NSGlobalDomain.AppleICUForce24HourTime = false;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.KeyRepeat = 2;
     	NSGlobalDomain."com.apple.trackpad.scaling" = 2.0;
	controlcenter.BatteryShowPercentage = true;
      };
      system.keyboard.enableKeyMapping = true;
      system.keyboard.remapCapsLockToEscape = true;

      # Allow Fingerprint for sudo
      security.pam.enableSudoTouchIdAuth = true;

      # User config
      users.users.mparsons.shell = pkgs.fish;

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

      # Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;

      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."mbp-nix" = nix-darwin.lib.darwinSystem {
      modules = [
      configuration
      nix-homebrew.darwinModules.nix-homebrew
        {
          nix-homebrew = {
            enable = true;
            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "mparsons";

            autoMigrate = true;
          };
        }
      ];
    };
    darwinPackages = self.darwinConfigurations."mbp-nix".pkgs;
  };
}

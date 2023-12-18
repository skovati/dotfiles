{ ... }:
let
    keyid = "0x5026E406B7B3818F";
in {

    programs.gpg = {
        # homedir = /home/skovati/.local/share/gnupg;
        settings = {
            default-key = keyid;
            trusted-key = keyid;
        };
    };

    services = {
        gpg-agent = {
            enable = true;
            pinentryFlavor = "tty";
            grabKeyboardAndMouse = false;
        };
    };
}

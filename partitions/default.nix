{ ... }:
{
  disk = {
    nvme0n1 = {
      device = "/dev/nvme0n1";
      type = "disk";
      content = {
        type = "table";
        format = "gpt";
        partitions = [
          {
            name = "ESP";
            start = "0";
            end = "1G";
            bootable = true;
            type = "EF00";
            content = {
              type = "filesystem";
              format = "vfat";
              mountpoint = "/boot";
            };
          }
          {
            name = "luks";
            start = "1G";
            end = "100%";
            content = {
              type = "luks";
              name = "crypted";
              extraFormatArgs = [ "--label NIXCRYPT" ];
              extraOpenArgs = [ "--allow-discards" ];
              settings.keyFile = "/tmp/secret.key";
              content = {
                type = "lvm_pv";
                vg = "vg0";
              };
            };
          }
        ];
      };
    };
    lvm_vg = {
      pool = {
        type = "lvm_vg";
        lvs = {
          root = {
            size = "200G";
            content = {
              type = "filesystem";
              format = "ext4";
              mountpoint = "/";
              mountOptions = [
                "defaults"
              ];
            };
          };
          swap = {
            size = "64G";
            content = {
              type = "swap";
              resumeDevice = true;
            };
          };
        };
      };
    };
  };
}

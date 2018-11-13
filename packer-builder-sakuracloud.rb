class PackerBuilderSakuracloud < Formula

  _version = "0.2.2"
  sha256_src = "951910f80c0937e7eb6e704a14662aac1312f01626a479d8ebfefc25871e6017"

  desc "Packer builder plugin for SakuraCloud"
  homepage "https://github.com/sacloud/packer-builder-sakuracloud"
  url "https://github.com/sacloud/packer-builder-sakuracloud/releases/download/v#{_version}/packer-builder-sakuracloud_darwin-amd64.zip"
  sha256 sha256_src
  head "https://github.com/sacloud/packer-builder-sakuracloud.git"
  version _version

  depends_on "packer"

  def install
    bin.install "packer-builder-sakuracloud"
  end

  def caveats; <<~EOS

    This plugin requires locate into "~/.packer.d/plugins" directory.
    To enable, execute following:

        mkdir -p ~/.packer.d/plugins
        ln -s #{bin/"packer-builder-sakuracloud"} ~/.packer.d/plugins/

  EOS
  end


  test do
    minimal = testpath/"minimal.tf"
    minimal.write <<~EOS
    {
      "builders": [{
          "type": "sakuracloud",
          "zone": "is1b",
          "os_type": "centos",
          "password": "this_is_fake_password"
      }]
    }
    EOS
    system "packer", "validate", minimal
  end
end

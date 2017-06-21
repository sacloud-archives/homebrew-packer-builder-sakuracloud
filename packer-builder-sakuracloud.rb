class PackerBuilderSakuracloud < Formula

  _version = "0.1.1"
  sha256_src = "5af47c92e9a7ebdba6e73f62fa86f4b1028cb28c971019121259deb701104ec7"

  desc "Packer builder plugin for SakuraCloud"
  homepage "https://github.com/sacloud/packer-builder-sakuracloud"
  url "https://github.com/sacloud/packer-builder-sakuracloud/releases/download/v#{_version}/packer-builder-sakuracloud_darwin-amd64.zip"
  sha256 sha256_src
  head "https://github.com/sacloud/packer-builder-sakuracloud.git"
  version _version

  depends_on "packer" => :run

  def install
    bin.install "packer-builder-sakuracloud"
  end

  def caveats; <<-EOS.undent

    This plugin requires locate into "~/.packer.d/plugins" directory.
    To enable, execute following:

        mkdir -p ~/.packer.d/plugins
        ln -s #{bin/"packer-builder-sakuracloud"} ~/.packer.d/plugins/

  EOS
  end


  test do
    minimal = testpath/"minimal.tf"
    minimal.write <<-EOS.undent
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
